package com.csc340.crud_api.posts;

import java.util.Collections;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/posts")
public class PostApiController {

  private final PostService postService;

  public PostApiController(PostService postService) {
    this.postService = postService;
  }

  @GetMapping("/hello")
  public String hello() {
    return "Hello from PostController!";
  }

  @GetMapping
  public ResponseEntity<List<Post>> getAllPosts() {
    List<Post> posts = postService.getAllPosts();
    if (posts.isEmpty()) {
      return ResponseEntity.ok(Collections.emptyList());
    }
    return ResponseEntity.ok(posts);
  }

  @GetMapping("/{id}")
  public ResponseEntity<Post> getPostById(@PathVariable long id) {
    Post post = postService.getPostById(id);
    if (post != null) {
      return ResponseEntity.ok(post);
    } else {
      return ResponseEntity.notFound().build();
    }
  }

  @PostMapping
  public ResponseEntity<Post> createPost(@RequestBody Post post) {
    Post createdPost = postService.createPost(post);
    return ResponseEntity.ok(createdPost);
  }

  @PutMapping("/{id}")
  public ResponseEntity<Post> updatePost(@PathVariable long id, @RequestBody Post updatedPost) {
    Post post = postService.updatePost(id, updatedPost);
    if (post != null) {
      return ResponseEntity.ok(post);
    } else {
      return ResponseEntity.notFound().build();
    }
  }

  @DeleteMapping("/{id}")
  public ResponseEntity<Void> deletePost(@PathVariable long id) {
    boolean deleted = postService.deletePost(id);
    if (deleted) {
      return ResponseEntity.noContent().build();
    } else {
      return ResponseEntity.notFound().build();
    }
  }

  @GetMapping("/search")
  public ResponseEntity<List<Post>> searchPosts(@RequestParam String query) {
    List<Post> posts = postService.searchPosts(query);
    if (posts.isEmpty()) {
      return ResponseEntity.ok(Collections.emptyList());
    }
    return ResponseEntity.ok(posts);
  }

  @GetMapping("/author")
  public ResponseEntity<List<Post>> getPostsByAuthor(@RequestParam String name) {
    List<Post> posts = postService.getPostsByAuthor(name);
    if (posts.isEmpty()) {
      return ResponseEntity.ok(Collections.emptyList());
    }
    return ResponseEntity.ok(posts);
  }

}
