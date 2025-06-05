package ru.kpfu.travel_service2.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.kpfu.travel_service2.dto.ArticleDto;
import ru.kpfu.travel_service2.entity.Article;
import ru.kpfu.travel_service2.entity.User;
import ru.kpfu.travel_service2.repository.ArticleRepository;
import ru.kpfu.travel_service2.repository.UserRepository;

import java.util.Date;
import java.util.List;

@Service
public class ArticleService {
    @Autowired
    private ArticleRepository articleRepository;

    @Autowired
    private UserRepository userRepository;

    public List<Article> getAllArticles() {
        return articleRepository.findAll();
    }

    public void createArticle(ArticleDto articleDto, User user) {
        Article article = new Article();
        article.setTitle(articleDto.getTitle());
        article.setContent(articleDto.getContent());
        article.setCategory(articleDto.getCategory());
        article.setCreatedDate(new Date());
        article.setUsers(List.of(user));
        articleRepository.save(article);
    }

    public boolean toggleFavourite(User user, Integer articleId) {
        Article article = articleRepository.findById(articleId)
                .orElseThrow(() -> new RuntimeException("Статья не найдена"));

        List<Article> favourites = user.getFavouriteArticles();
        boolean isAdded;

        if (favourites.contains(article)) {
            favourites.remove(article);
            isAdded = false;
        } else {
            favourites.add(article);
            isAdded = true;
        }

        userRepository.save(user);
        return isAdded;
    }

    public Article getArticleById(Integer articleId) {
        return articleRepository.findById(articleId)
                .orElseThrow(() -> new RuntimeException("Статья не найдена"));
    }
}
