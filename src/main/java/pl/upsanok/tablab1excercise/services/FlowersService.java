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
        UserEntity user = userRepository.findByName(userName);
        if (user == null || user.getFavouriteFlower() == null) {
            return Flower.builder().name("").build();
        }
        return Flower.builder().name(user.getFavouriteFlower().getName()).build();
    }

    public boolean saveFavouriteFlowerFor(String userName, String flowerName) {
        UserEntity user = userRepository.findByName(userName);
        FlowerEntity flower = flowerRepository.findByName(flowerName);

        if (user == null || flower == null) {
            return false;
        }

        user.setFavouriteFlower(flower);
        userRepository.save(user);
        return true;
    }

    public void addFlowerToGarden(String userName, String flowerName) {
        UserEntity user = userRepository.findByName(userName);
        FlowerEntity flower = flowerRepository.findByName(flowerName);

        if (user == null || flower == null) {
            return;
        }

        user.addFlowerToGarden(flower);
        userRepository.save(user);
    }

    public List<Flower> getGardenFlowers(String userName) {
        UserEntity user = userRepository.findByName(userName);
        if (user == null || user.getGardenFlowers() == null) {
            return List.of();
        }
        return user.getGardenFlowers()
                .stream()
                .map(entity -> Flower.builder().name(entity.getName()).build())
                .toList();
    }
}