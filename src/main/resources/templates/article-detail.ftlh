<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Детали статьи</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .article-header {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }
        .article-title {
            font-size: 32px;
            color: #333;
            margin-bottom: 10px;
        }
        .article-meta {
            color: #666;
            font-size: 14px;
            margin-bottom: 20px;
        }
        .article-content {
            font-size: 16px;
            line-height: 1.6;
            color: #444;
            margin-bottom: 30px;
        }
        .back-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
        .favourite-icon {
            font-size: 24px;
            cursor: pointer;
            color: #dc3545;
            margin-left: 10px;
            transition: all 0.3s ease;
        }
        .favourite-icon:hover {
            transform: scale(1.1);
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            display: none;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Детали статьи</h2>
            <div class="auth-buttons">
                <a href="/home" class="auth-button">На главную</a>
                <#if user??>
                    <a href="/travels" class="auth-button">Мои путешествия</a>
                    <a href="/favourites" class="auth-button">Избранные статьи</a>
                    <a href="/profile" class="auth-button">Профиль</a>
                    <form action="/logout" method="post" style="margin: 0;">
                        <button type="submit" class="auth-button">Выйти</button>
                    </form>
                </#if>
            </div>
        </div>

        <a href="/home" class="back-button">← Назад к списку статей</a>
        
        <div id="alert" class="alert alert-error"></div>

        <div class="article-header">
            <h1 class="article-title">
                ${article.title}
                <i class="favourite-icon <#if favouriteArticles?? && favouriteArticles?seq_contains(article)>fas fa-heart<#else>far fa-heart</#if>"
                   data-article-id="${article.articleId}"
                   onclick="<#if user??>toggleFavourite(this, ${article.articleId})<#else>showAuthAlert()</#if>"></i>
            </h1>
            <div class="article-meta">
                Категория: ${(article.category)!'Без категории'}
                <br>
                Дата публикации: ${article.createdDate?string("dd.MM.yyyy")}
            </div>
        </div>

        <div class="article-content">
            ${article.content}
        </div>
    </div>

    <script>
        function showAuthAlert() {
            showAlert('Чтобы добавить статью в избранное, необходимо авторизоваться');
        }

        function showAlert(message) {
            const alert = document.getElementById('alert');
            alert.textContent = message;
            alert.style.display = 'block';
            setTimeout(() => {
                alert.style.display = 'none';
            }, 3000);
        }

        function toggleFavourite(icon, articleId) {
            fetch('/article/toggle-favourite/' + articleId, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    if (data.isAdded) {
                        icon.classList.remove('far');
                        icon.classList.add('fas');
                    } else {
                        icon.classList.remove('fas');
                        icon.classList.add('far');
                    }
                } else {
                    showAlert(data.message);
                }
            })
            .catch(error => {
                showAlert('Произошла ошибка при обновлении избранного');
            });
        }
    </script>
</body>
</html> 