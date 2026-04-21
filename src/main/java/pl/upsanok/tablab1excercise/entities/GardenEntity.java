package pl.upsanok.tablab1excercise.entities;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "user_garden")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GardenEntity {
    
    @EmbeddedId
    private GardenIdEmbedded gardenId;
}
