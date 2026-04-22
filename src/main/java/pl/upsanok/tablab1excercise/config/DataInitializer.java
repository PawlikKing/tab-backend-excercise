package pl.upsanok.tablab1excercise.config;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import pl.upsanok.tablab1excercise.entities.FlowerEntity;
import pl.upsanok.tablab1excercise.entities.UserEntity;
import pl.upsanok.tablab1excercise.repositories.FlowerRepository;
import pl.upsanok.tablab1excercise.repositories.UserRepository;

@Component
@AllArgsConstructor
@Slf4j
public class DataInitializer implements CommandLineRunner {
    
    private final FlowerRepository flowerRepository;
    private final UserRepository userRepository;
    
    @Override
    public void run(String... args) throws Exception {
        if (flowerRepository.count() == 0) {
            log.info("Initializing seed data...");
            
            // Create flowers
            FlowerEntity flower1 = flowerRepository.save(
                FlowerEntity.builder().flowerName("Ziemniak").build()
            );
            FlowerEntity flower2 = flowerRepository.save(
                FlowerEntity.builder().flowerName("Barszcz Sosnowskiego").build()
            );
            FlowerEntity flower3 = flowerRepository.save(
                FlowerEntity.builder().flowerName("Mak").build()
            );
            FlowerEntity flower4 = flowerRepository.save(
                FlowerEntity.builder().flowerName("Pomidor").build()
            );
            
            // Create users with favorite flowers
            userRepository.save(
                UserEntity.builder()
                    .name("Pawelo")
                    .favouriteFlower(flower1)
                    .build()
            );
            userRepository.save(
                UserEntity.builder()
                    .name("Ania")
                    .favouriteFlower(flower2)
                    .build()
            );
            userRepository.save(
                UserEntity.builder()
                    .name("Jakub")
                    .favouriteFlower(flower3)
                    .build()
            );
            
            log.info("Seed data initialized successfully!");
        }
    }
}
