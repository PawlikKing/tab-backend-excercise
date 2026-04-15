package pl.upsanok.tablab1excercise.services;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import pl.upsanok.tablab1excercise.controllers.dto.Flower;
import pl.upsanok.tablab1excercise.entities.FlowerEntity;
import pl.upsanok.tablab1excercise.entities.UserEntity;
import pl.upsanok.tablab1excercise.repositories.FlowerRepository;
import pl.upsanok.tablab1excercise.repositories.UserRepository;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class FlowersService {

    private final FlowerRepository flowerRepository;
    private final UserRepository userRepository;

    public List<Flower> getAllFlowers() {
        return flowerRepository.findAll()
                .stream()
                .map(entity -> Flower.builder().name(entity.getName()).build())
                .toList();
    }

    public Flower getFavouriteFlowerForUser(String userName) {
        return userRepository.findAll()
                .stream()
                .filter(user -> user.getName().equals(userName))
                .findFirst()
                .map(UserEntity::getFlower)
                .map(flower -> Flower.builder().name(flower.getName()).build())
                .orElse(Flower.builder().name("").build());
    }

    public boolean saveFavouriteFlowerFor(String userName, String flowerName) {
        Optional<UserEntity> userOpt = userRepository.findAll()
                .stream()
                .filter(user -> user.getName().equals(userName))
                .findFirst();

        Optional<FlowerEntity> flowerOpt = flowerRepository.findAll()
                .stream()
                .filter(flower -> flower.getName().equals(flowerName))
                .findFirst();

        if (userOpt.isEmpty() || flowerOpt.isEmpty()) {
            return false;
        }

        UserEntity user = userOpt.get();
        user.setFlower(flowerOpt.get());
        userRepository.save(user);
        return true;
    }
}