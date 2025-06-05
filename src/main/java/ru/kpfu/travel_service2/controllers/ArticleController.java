package ru.kpfu.travel_service2.controllers;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import ru.kpfu.travel_service2.dto.ArticleDto;
import ru.kpfu.travel_service2.entity.Article;
import ru.kpfu.travel_service2.entity.User;
import ru.kpfu.travel_service2.repository.ArticleRepository;
import ru.kpfu.travel_service2.repository.UserRepository;
import ru.kpfu.travel_service2.services.ArticleService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/home")
    public String showHome(Model model, Authentication authentication) {
        List<Article> articles = articleService.getAllArticles();
        model.addAttribute("articles", articles);

        if (authentication != null && authentication.isAuthenticated()) {
            String username = authentication.getName();
            User user = userRepository.findByUsername(username).orElse(null);
            if (user != null) {
                model.addAttribute("user", user);
                model.addAttribute("favouriteArticles", user.getFavouriteArticles());
            }
        }

        return "home";
    }

    @PostMapping("/article/toggle-favourite/{articleId}")
    @ResponseBody
    public ResponseEntity<?> toggleFavourite(@PathVariable Integer articleId, Authentication authentication) {
        Map<String, Object> response = new HashMap<>();

        if (authentication == null || !authentication.isAuthenticated()) {
            response.put("success", false);
            response.put("message", "Чтобы добавить статью в избранное, сначала авторизуйтесь");
            return ResponseEntity.ok(response);
        }

        try {
            String username = authentication.getName();
            User user = userRepository.findByUsername(username)
                    .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

            boolean isAdded = articleService.toggleFavourite(user, articleId);
            
            response.put("success", true);
            response.put("isAdded", isAdded);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Произошла ошибка при обновлении избранного");
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/create/article")
    public String showCreateArticleForm(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/home";
        }
        model.addAttribute("articleDto", new ArticleDto());
        return "create-article";
    }

    @PostMapping("/create/article")
    public String createArticle(@Valid ArticleDto articleDto, 
                              BindingResult bindingResult,
                              Authentication authentication,
                              RedirectAttributes redirectAttributes) {
        if (authentication == null || !authentication.isAuthenticated()) {
            redirectAttributes.addFlashAttribute("error", 
                "Создавать статьи могут только авторизованные пользователи");
            return "redirect:/home";
        }

        if (bindingResult.hasErrors()) {
            return "create-article";
        }

        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        articleService.createArticle(articleDto, user);
        redirectAttributes.addFlashAttribute("success", "Статья успешно создана");
        return "redirect:/home";
    }

    @GetMapping("/article/detail/{id}")
    public String showArticleDetail(@PathVariable("id") Integer articleId,
                                  Model model,
                                  Authentication authentication) {
        Article article = articleService.getArticleById(articleId);
        model.addAttribute("article", article);

        if (authentication != null && authentication.isAuthenticated()) {
            String username = authentication.getName();
            User user = userRepository.findByUsername(username).orElse(null);
            if (user != null) {
                model.addAttribute("user", user);
                model.addAttribute("favouriteArticles", user.getFavouriteArticles());
            }
        }

        return "article-detail";
    }

    @GetMapping("/favourites")
    public String showFavourites(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String username = authentication.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        model.addAttribute("articles", user.getFavouriteArticles());
        model.addAttribute("user", user);
        model.addAttribute("favouriteArticles", user.getFavouriteArticles());

        return "favourites";
    }
} 