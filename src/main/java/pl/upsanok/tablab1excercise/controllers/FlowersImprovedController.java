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

@RestController()
@CrossOrigin(origins = {"http://localhost:3000", "https://tab-front-production.up.railway.app"})
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
    return ResponseEntity.ok(Flower.builder().name("testowa").build());
  }
}

