package pl.upsanok.tablab1excercise.entities;

import jakarta.persistence.*;
import lombok.*;

@Builder
@Table(name = "user_table")
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private int id;

    @Column(name = "user_name", unique = true)
    private String name;

    @ManyToOne(fetch = jakarta.persistence.FetchType.LAZY)
    @JoinColumn(name = "flower_id")
    private FlowerEntity favouriteFlower;
}