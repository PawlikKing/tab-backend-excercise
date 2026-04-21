package pl.upsanok.tablab1excercise.entities;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Garden")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GardenEntity {
    
    @EmbeddedId
    private GardenIdEmbedded gardenId;
}
