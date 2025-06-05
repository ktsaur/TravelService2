<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Избранные статьи</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }
        .auth-buttons {
            display: flex;
            gap: 10px;
        }
        .auth-button {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            color: white;
            background-color: #007bff;
        }
        .auth-button:hover {
            background-color: #0056b3;
        }
        .article-list {
            list-style: none;
            padding: 0;
        }
        .article-item {
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            position: relative;
        }
        .article-title {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
        }
        .article-meta {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .article-link {
            color: #333;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .article-link:hover {
            color: #007bff;
        }
        .favourite-icon {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 24px;
            cursor: pointer;
            color: #dc3545;
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
        .empty-message {
            text-align: center;
            color: #666;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Избранные статьи</h2>
            <div class="auth-buttons">
                <a href="/home" class="auth-button">На главную</a>
                <a href="/travels" class="auth-button">Мои путешествия</a>
                <a href="/profile" class="auth-button">Профиль</a>
                <form action="/logout" method="post" style="margin: 0;">
                    <button type="submit" class="auth-button">Выйти</button>
                </form>
            </div>
        </div>

        <div id="alert" class="alert alert-error"></div>

        <#if articles?? && articles?size gt 0>
            <div class="article-list">
                <#list articles as article>
                    <div class="article-item" id="article-${article.articleId}">
                        <h3 class="article-title">
                            <a href="/article/detail/${article.articleId}" class="article-link">${article.title}</a>
                        </h3>
                        <div class="article-meta">
                            Категория: ${(article.category)!'Без категории'}
                        </div>
                        <i class="favourite-icon fas fa-heart"
                           data-article-id="${article.articleId}"
                           onclick="toggleFavourite(this, ${article.articleId})"></i>
                    </div>
                </#list>
            </div>
        <#else>
            <p class="empty-message">У вас пока нет избранных статей</p>
        </#if>
    </div>

    <script>
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
                    const articleElement = document.getElementById('article-' + articleId);
                    articleElement.style.opacity = '0';
                    setTimeout(() => {
                        articleElement.remove();
                        const articleList = document.querySelector('.article-list');
                        if (!articleList.children.length) {
                            articleList.innerHTML = '<p class="empty-message">У вас пока нет избранных статей</p>';
                        }
                    }, 300);
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