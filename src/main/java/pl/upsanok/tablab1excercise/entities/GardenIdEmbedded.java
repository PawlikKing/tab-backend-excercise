package pl.upsanok.tablab1excercise.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;

import java.io.Serializable;

@Embeddable
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class GardenIdEmbedded implements Serializable {
    @Column(name = "user_id")
    private int userId;
    
    @Column(name = "flower_id")
    private int flowerId;
}
