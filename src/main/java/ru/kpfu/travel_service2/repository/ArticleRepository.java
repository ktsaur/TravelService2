package ru.kpfu.travel_service2.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.travel_service2.entity.Article;
import ru.kpfu.travel_service2.entity.Travel;

import java.util.List;

@Repository
public interface ArticleRepository  extends JpaRepository<Article, Integer> {
    public List<Article> findAll();
}
