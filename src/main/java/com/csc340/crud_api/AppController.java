package com.csc340.crud_api;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.csc340.crud_api.users.User;
import com.csc340.crud_api.users.UserService;

@Controller
public class AppController {

  private final UserService userService;

  public AppController(UserService userService) {
    this.userService = userService;
  }

  @GetMapping
  public String homePage() {
    return "index";
  }

  @RequestMapping("/403")
  public String accessDenied() {
    return "403";
  }

  @GetMapping("/signup")
  public String signUp() {
    return "signup";
  }

  @PostMapping("/signup")
  public String signUp(User user) {
    userService.save(user);
    return "redirect:/login";
  }

  @GetMapping("/error")
  public String error() {
    return "error";
  }

}
