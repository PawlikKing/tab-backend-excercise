package pl.upsanok.tablab1excercise.controllers;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import pl.upsanok.tablab1excercise.controllers.dto.Flower;
import pl.upsanok.tablab1excercise.services.FlowersService;

@RestController()
@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:8080", "http://[::1]:8080", "https://tab-front-production.up.railway.app"}, allowCredentials = "true", allowedHeaders = "*", methods = {org.springframework.web.bind.annotation.RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST, org.springframework.web.bind.annotation.RequestMethod.PUT, org.springframework.web.bind.annotation.RequestMethod.DELETE, org.springframework.web.bind.annotation.RequestMethod.OPTIONS})
public class FlowersController {

  @Autowired
  private FlowersService flowersService;

  private String favFlower = "Narcyz";

  @GetMapping("flowers")
  public ResponseEntity<List<Flower>> getName() {
    return ResponseEntity.ok(flowersService.getAllFlowers());
  }

  @GetMapping("flowers/fav")
  public ResponseEntity<Flower> getFav() {
    return ResponseEntity.ok(
            Flower.builder()
                .name(this.favFlower)
                .build());
  }

  @PostMapping("flowers/fav")
  public ResponseEntity<Flower> setNewFav(
      @RequestBody Flower flower
  ) {
    this.favFlower = flower.name();
    return ResponseEntity.ok(
        Flower.builder()
            .name(this.favFlower)
            .build()
    );
  }
}
