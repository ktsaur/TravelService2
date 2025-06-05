<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .article-card {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .article-title {
            color: #333;
            font-size: 24px;
            margin-bottom: 10px;
        }
        .article-meta {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .article-content {
            color: #444;
            margin-bottom: 15px;
        }
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
        .create-article-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .create-article-button:hover {
            background-color: #218838;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
        .article-link {
            color: #333;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .article-link:hover {
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Добро пожаловать!</h2>
            <div class="auth-buttons">
                <#if user??>
                    <a href="/travels" class="auth-button">Мои путешествия</a>
                    <a href="/favourites" class="auth-button">Избранные статьи</a>
                    <a href="/profile" class="auth-button">Профиль</a>
                    <form action="/logout" method="post" style="margin: 0;">
                        <button type="submit" class="auth-button">Выйти</button>
                    </form>
                <#else>
                    <a href="/login" class="auth-button">Войти</a>
                    <a href="/registration" class="auth-button">Зарегистрироваться</a>
                </#if>
            </div>
        </div>

        <div id="alert" class="alert alert-error" style="display: none;"></div>

        <#if error??>
            <div class="alert alert-error">${error}</div>
        </#if>
        <#if success??>
            <div class="alert alert-success">${success}</div>
        </#if>

        <#if user??>
            <a href="/create/article" class="create-article-button">Создать статью</a>
        </#if>

        <h3>Статьи о путешествиях:</h3>
        
        <#if articles?? && articles?size gt 0>
            <div class="article-list">
                <#list articles as article>
                    <div class="article-item">
                        <h3 class="article-title">
                            <a href="/article/detail/${article.articleId}" class="article-link">${article.title}</a>
                        </h3>
                        <div class="article-meta">
                            Категория: ${(article.category)!'Без категории'}
                        </div>
                        <i class="favourite-icon <#if favouriteArticles?? && favouriteArticles?seq_contains(article)>fas fa-heart<#else>far fa-heart</#if>"
                           data-article-id="${article.articleId}"
                           onclick="<#if user??>toggleFavourite(this, ${article.articleId})<#else>showAuthAlert()</#if>"></i>
                    </div>
                </#list>
            </div>
        <#else>
            <p>На данный момент статей нет.</p>
        </#if>
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
