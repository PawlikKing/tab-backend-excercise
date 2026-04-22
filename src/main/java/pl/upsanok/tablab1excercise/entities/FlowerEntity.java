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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "flowerId")
    private Integer flowerId;

    @Column(name = "flowerName")
    private String flowerName;

    @OneToMany(mappedBy = "favouriteFlower")
    private List<UserEntity> usersWhoLikeThisFlower;
}