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
import java.util.stream.Collectors;

@Controller
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/home")
    public String showHome(Model model, Authentication authentication) {
        List<Article> articles = articleService.getAllArticles();
        
        // Группируем статьи по категориям
        Map<String, List<Article>> groupedArticles = articles.stream()
                .collect(Collectors.groupingBy(article -> 
                    article.getCategory() != null ? article.getCategory() : "Без категории"));
        
        model.addAttribute("pageTitle", "TravelService");
        model.addAttribute("groupedArticles", groupedArticles);

        // Инициализируем мапу для статуса избранного
        Map<String, Boolean> favouriteStatus = new HashMap<>();
        
        if (authentication != null && authentication.isAuthenticated()) {
            String username = authentication.getName();
            User user = userRepository.findByUsername(username).orElse(null);
            if (user != null) {
                model.addAttribute("user", user);
                List<Article> favourites = user.getFavouriteArticles();
                articles.forEach(article -> 
                    favouriteStatus.put(article.getArticleId().toString(), favourites.contains(article)));
            }
        } else {
            // Для неавторизованных пользователей все статьи не в избранном
            articles.forEach(article -> 
                favouriteStatus.put(article.getArticleId().toString(), false));
        }
        
        model.addAttribute("favouriteStatus", favouriteStatus);

        return "home";
    }

    @PostMapping("/home")
    public String handleHomePost(@RequestParam("action") String action,
                               @RequestParam("articleId") Integer articleId,
                               Authentication authentication,
                               RedirectAttributes redirectAttributes) {
        if ("toggleFavourite".equals(action)) {
            if (authentication != null && authentication.isAuthenticated()) {
                String username = authentication.getName();
                User user = userRepository.findByUsername(username)
                        .orElseThrow(() -> new RuntimeException("Пользователь не найден"));
                
                boolean isAdded = articleService.toggleFavourite(user, articleId);
                redirectAttributes.addFlashAttribute("message", 
                    isAdded ? "Статья добавлена в избранное" : "Статья удалена из избранного");
            }
        }
        return "redirect:/home";
    }

    @GetMapping("/create/article")
    public String showCreateArticleForm(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }
        model.addAttribute("articleDto", new ArticleDto());
        return "create-article";
    }

    @PostMapping("/create/article")
    public String createArticle(@Valid ArticleDto articleDto, 
                              BindingResult bindingResult,
                              Authentication authentication,
                              RedirectAttributes redirectAttributes,
                              Model model) {
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

        try {
            articleService.createArticle(articleDto, user);
            redirectAttributes.addFlashAttribute("success", "Статья успешно создана");
            return "redirect:/home";
        } catch (Exception e) {
            model.addAttribute("error", "Произошла ошибка при создании статьи");
            return "create-article";
        }
    }

    @GetMapping("/article/{id}")
    public String showArticleDetail(@PathVariable("id") Integer articleId,
                                  Model model,
                                  Authentication authentication) {
        Article article = articleService.getArticleById(articleId);
        model.addAttribute("article", article);

        // Инициализируем мапу для статуса избранного
        Map<String, Boolean> favouriteStatus = new HashMap<>();
        favouriteStatus.put(articleId.toString(), false);

        if (authentication != null && authentication.isAuthenticated()) {
            String username = authentication.getName();
            User user = userRepository.findByUsername(username).orElse(null);
            if (user != null) {
                model.addAttribute("user", user);
                // Проверяем, находится ли статья в избранном у пользователя
                favouriteStatus.put(articleId.toString(), user.getFavouriteArticles().contains(article));
            }
        }
        
        model.addAttribute("favouriteStatus", favouriteStatus);
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

    @PostMapping("/article/toggle-favourite/{id}")
    @ResponseBody
    public Map<String, Object> toggleFavouriteAjax(@PathVariable("id") Integer articleId,
                                                  Authentication authentication) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            if (authentication != null && authentication.isAuthenticated()) {
                String username = authentication.getName();
                User user = userRepository.findByUsername(username)
                        .orElseThrow(() -> new RuntimeException("Пользователь не найден"));
                
                boolean isAdded = articleService.toggleFavourite(user, articleId);
                response.put("success", true);
                response.put("isAdded", isAdded);
            } else {
                response.put("success", false);
                response.put("message", "Необходимо авторизоваться");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Произошла ошибка при обновлении избранного");
        }
        
        return response;
    }
} 