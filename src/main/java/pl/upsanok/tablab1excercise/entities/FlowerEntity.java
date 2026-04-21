package pl.upsanok.tablab1excercise.entities;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "flowers")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FlowerEntity {

    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "name")
    private String name;

    @OneToMany(mappedBy = "favouriteFlower")
    private List<UserEntity> usersWhoLikeThisFlower;

    @ManyToMany(mappedBy = "gardenFlowers")
    private List<UserEntity> owners;
}