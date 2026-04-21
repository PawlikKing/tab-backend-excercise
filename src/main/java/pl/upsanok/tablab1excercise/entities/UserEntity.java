package pl.upsanok.tablab1excercise.entities;

import jakarta.persistence.*;
import lombok.*;

@Builder
@Table(name = "Users")
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "userId")
    private int id;

    @Column(name = "username", unique = true)
    private String name;

    @ManyToOne(fetch = jakarta.persistence.FetchType.LAZY)
    @JoinColumn(name = "flowerId")
    private FlowerEntity favouriteFlower;
}