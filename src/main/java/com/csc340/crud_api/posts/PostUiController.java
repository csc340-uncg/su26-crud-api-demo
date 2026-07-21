package com.csc340.crud_api.posts;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

//@RestController
@Controller
@RequestMapping("/posts")
public class PostUiController {

  private final PostService postService;

  public PostUiController(PostService postService) {
    this.postService = postService;
  }

  @GetMapping()
  public String getAllPosts(Model model) {
    // return ResponseEntity.ok(postService.getAllPosts());
    model.addAttribute("postsList", postService.getAllPosts());
    model.addAttribute("pageTitle", "All Posts");
    return "post-list";// view name (post-list.ftlh)
  }

  @GetMapping("/{id}")
  public String getPostById(@PathVariable Long id, Model model) {
    Post post = postService.getPostById(id);
    model.addAttribute("post", post);
    model.addAttribute("pageTitle", "Post # " + id + " Details");
    return "post-details";
  }

  @GetMapping("/new")
  public String createPostForm(Model model) {
    model.addAttribute("post", new Post());
    model.addAttribute("pageTitle", "Create New Post");
    return "post-form";
  }

  @PostMapping("/save")
  public String createPost(Post post, MultipartFile thumbnailFile) {
    Post createdPost = postService.createPost(post);
    if (createdPost != null) {
      if (thumbnailFile != null && !thumbnailFile.isEmpty()) {
        postService.saveThumbnail(createdPost, thumbnailFile);
      }
      return "redirect:/posts/" + createdPost.getId();
    }
    return "redirect:/posts/new?error=true";
  }

  @GetMapping("/delete/{id}")
  public String deletePost(@PathVariable Long id) {
    boolean isDeleted = postService.deletePost(id);
    if (isDeleted) {
      return "redirect:/posts";
    }
    return "redirect:/posts/" + id + "?error=true";
  }

  @PostMapping("/update/{id}")
  public String updatePost(@PathVariable Long id, Post updatedPost, MultipartFile thumbnailFile) {
    Post post = postService.updatePost(id, updatedPost);
    if (post != null) {
      if (thumbnailFile != null && !thumbnailFile.isEmpty()) {
        postService.saveThumbnail(post, thumbnailFile);
      }
      return "redirect:/posts/" + post.getId() + "?success=true";
    }
    return "redirect:/posts/" + id + "?error=true";
  }

  @GetMapping("/search")
  public String searchPosts(String query, Model model) {
    model.addAttribute("postsList", postService.searchPosts(query));
    model.addAttribute("pageTitle", "Search Results for: " + query);
    return "post-list";
  }
}
