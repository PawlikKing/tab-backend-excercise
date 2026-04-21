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
    @Column(name = "userId")
    private int userId;
    
    @Column(name = "flowerId")
    private int flowerId;
}
