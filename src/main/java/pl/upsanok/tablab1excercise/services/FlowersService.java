package pl.upsanok.tablab1excercise.services;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pl.upsanok.tablab1excercise.controllers.dto.Flower;
import pl.upsanok.tablab1excercise.entities.FlowerEntity;
import pl.upsanok.tablab1excercise.entities.GardenEntity;
import pl.upsanok.tablab1excercise.entities.GardenIdEmbedded;
import pl.upsanok.tablab1excercise.entities.UserEntity;
import pl.upsanok.tablab1excercise.repositories.FlowerRepository;
import pl.upsanok.tablab1excercise.repositories.GardenRepository;
import pl.upsanok.tablab1excercise.repositories.UserRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
@Slf4j
public class FlowersService {

    private final FlowerRepository flowerRepository;
    private final UserRepository userRepository;
    private final GardenRepository gardenRepository;

    public List<Flower> getAllFlowers() {
        return flowerRepository.findAll()
                .stream()
                .map(entity -> Flower.builder().name(entity.getFlowerName()).build())
                .toList();
    }

    public Flower getFavouriteFlowerForUser(String userName) {
        UserEntity user = userRepository.findByName(userName);
        if (user == null || user.getFavouriteFlower() == null) {
            return Flower.builder().name("").build();
        }
        return Flower.builder().name(user.getFavouriteFlower().getFlowerName()).build();
    }

    public boolean saveFavouriteFlowerFor(String userName, String flowerName) {
        UserEntity user = userRepository.findByName(userName);
        FlowerEntity flower = flowerRepository.findByFlowerName(flowerName);  // Changed from findByName

        if (user == null || flower == null) {
            return false;
        }

        user.setFavouriteFlower(flower);
        userRepository.save(user);
        return true;
    }


    @Transactional
    public boolean saveFlowerInGardenForUser(String userName, String flowerName) {
        Optional<UserEntity> userOptional = userRepository.findAll().stream()
            .filter(userEntity -> userEntity.getName().equals(userName))
            .findFirst();

        Optional<FlowerEntity> flowerOptional = flowerRepository.findAll().stream()
            .filter(flowerEntity -> flowerEntity.getFlowerName().equals(flowerName))
            .findFirst();

        if (userOptional.isEmpty()) {
            List<FlowerEntity> flowersInGarden = new ArrayList<>();
            flowersInGarden.add(flowerOptional.get());
            
            UserEntity userEntity = UserEntity.builder()
                .name(userName)
                .build();

            userRepository.save(userEntity);

            gardenRepository.save(
                GardenEntity.builder()
                    .gardenId(GardenIdEmbedded.builder()
                        .userId(userOptional.get().getId())
                        .flowerId(flowerOptional.get().getFlowerId())
                        .build())
                    .build());

            return true;
        }
        return false;
    }

    public void addFlowerToGarden(String userName, String flowerName) {
        UserEntity user = userRepository.findByName(userName);
        FlowerEntity flower = flowerRepository.findByFlowerName(flowerName);

        if (user == null || flower == null) {
            return;
        }

        gardenRepository.save(
            GardenEntity.builder()
                .gardenId(GardenIdEmbedded.builder()
                    .userId(user.getId())
                    .flowerId(flower.getFlowerId())
                    .build())
                .build());
    }

    public List<Flower> getGardenFlowers(String userName) {
        UserEntity user = userRepository.findByName(userName);
        if (user == null) {
            return List.of();
        }
        return gardenRepository.findAll().stream()
                .filter(g -> g.getGardenId().getUserId() == user.getId())
                .map(g -> {
                    FlowerEntity flower = flowerRepository.findById(g.getGardenId().getFlowerId()).orElse(null);
                    return flower != null ? Flower.builder().name(flower.getFlowerName()).build() : null;
                })
                .filter(f -> f != null)
                .toList();
    }

    @Transactional
    public int saveNewFlower(String flowerName) {
        var result = flowerRepository.save(FlowerEntity.builder().flowerName(flowerName).build()).getFlowerId();
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        log.info("Flower saved with id: {}", result);
        return result;
    }

    @Transactional
    public int saveNewFlowerWithLimit(String flowerName) {
        Long nrOfFlowers = flowerRepository.count();
        if (nrOfFlowers < 6) {
            var result = flowerRepository.save(FlowerEntity.builder().flowerName(flowerName).build()).getFlowerId();
            try {
                Thread.sleep(5000);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            log.info("Flower saved with id: {}", result);
            return result;
        }
        log.info("Flower not saved, max number of Flowers reached");
        return -1;
    }
}