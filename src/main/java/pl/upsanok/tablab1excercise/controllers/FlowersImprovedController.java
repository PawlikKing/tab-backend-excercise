package pl.upsanok.tablab1excercise.controllers;


import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import pl.upsanok.tablab1excercise.services.FlowersService;
import pl.upsanok.tablab1excercise.controllers.dto.Flower;

import java.util.List;

@RestController()
@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:8080", "http://[::1]:8080", "https://tab-front-production.up.railway.app"}, allowCredentials = "true", allowedHeaders = "*", methods = {org.springframework.web.bind.annotation.RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST, org.springframework.web.bind.annotation.RequestMethod.PUT, org.springframework.web.bind.annotation.RequestMethod.DELETE, org.springframework.web.bind.annotation.RequestMethod.OPTIONS})
@AllArgsConstructor
public class FlowersImprovedController {

  @Autowired
  private FlowersService flowersService;

  @GetMapping("flowers/fav/users/{userName}")
  public ResponseEntity<Flower> getFavForUser(
      @PathVariable String userName
  ) {
    var result = flowersService.getFavouriteFlowerForUser(userName);
    return ResponseEntity.ok(result);
  }

  @PostMapping("flowers/fav/users/{userName}")
  public ResponseEntity<Flower> setNewFavForUser(
      @PathVariable String userName,
      @RequestBody Flower flower
  ) {
    boolean result = flowersService.saveFavouriteFlowerFor(userName, flower.name());
    if (result) {
      return ResponseEntity.ok(flower);
    }
    return ResponseEntity.badRequest().build();
  }

  @GetMapping("flowers/garden/users/{userName}")
  public ResponseEntity<List<Flower>> getGardenFlowers(
      @PathVariable String userName
  ) {
    var result = flowersService.getGardenFlowers(userName);
    return ResponseEntity.ok(result);
  }

  @PostMapping("flowers/garden/users/{userName}")
  public ResponseEntity<Flower> addFlowerToGarden(
      @PathVariable String userName,
      @RequestBody Flower flower
  ) {
    flowersService.addFlowerToGarden(userName, flower.name());
    return ResponseEntity.ok(flower);
  }

  @PostMapping("flowers/{newFlower}")
  public ResponseEntity<Integer> saveNewFlower(
      @PathVariable String newFlower
  ) {
    int result = flowersService.saveNewFlower(newFlower);
    return ResponseEntity.ok(result);
  }

  @PostMapping("flowers/limit/{newFlower}")
  public ResponseEntity<Integer> saveNewFlowerWithLimit(
      @PathVariable String newFlower
  ) {
    int result = flowersService.saveNewFlowerWithLimit(newFlower);
    return ResponseEntity.ok(result);
  }
}

