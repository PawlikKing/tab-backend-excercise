package pl.upsanok.tablab1excercise.entities;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "users")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserEntity {

    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "name")
    private String name;

    @ManyToOne
    @JoinColumn(name = "favourite_flower_id")
    private FlowerEntity favouriteFlower;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "user_garden",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "flower_id")
    )
    private List<FlowerEntity> gardenFlowers;

    public void addFlowerToGarden(FlowerEntity flower) {
        if (this.gardenFlowers == null) {
            this.gardenFlowers = new ArrayList<>();
        }
        this.gardenFlowers.add(flower);
    }
}