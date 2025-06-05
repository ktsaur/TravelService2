<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${article.title} - Детали статьи</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            color: #212529;
        }
        .article-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.1);
        }
        .article-header {
            border-bottom: 2px solid #e9ecef;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            position: relative;
        }
        .article-title {
            font-size: 2.5rem;
            font-weight: bold;
            color: #212529;
            margin-bottom: 1rem;
        }
        .article-meta {
            color: #6c757d;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }
        .article-content {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #495057;
            margin-bottom: 2rem;
            white-space: pre-wrap;
        }
        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .favorite-btn {
            background: none;
            border: none;
            padding: 0;
            transition: transform 0.3s ease;
        }
        .favorite-btn:hover {
            transform: scale(1.2);
        }
        .category-badge {
            background-color: #e9ecef;
            color: #495057;
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        .toast-container {
            position: fixed;
            top: 1rem;
            right: 1rem;
            z-index: 1050;
        }
    </style>
</head>
<body>
    <#include "header.ftlh">

    <div class="container py-4">
        <div class="article-container">
            <!-- Навигация -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/home" class="text-decoration-none">Главная</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Статья</li>
                </ol>
            </nav>

            <!-- Заголовок и мета-информация -->
            <div class="article-header">
                <h1 class="article-title">${article.title}</h1>
                <div class="article-meta">
                    <span class="meta-item">
                        <i class="bi bi-calendar3"></i>
                        ${article.createdDate?string("dd.MM.yyyy")}
                    </span>
                    <span class="category-badge">
                        <i class="bi bi-bookmark-fill"></i>
                        ${(article.category)!'Без категории'}
                    </span>
                    <#if user??>
                        <form action="/home" method="post" class="d-inline ms-auto">
                            <#if _csrf??>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </#if>
                            <input type="hidden" name="action" value="toggleFavourite"/>
                            <input type="hidden" name="articleId" value="${article.articleId}"/>
                            <button type="submit" class="favorite-btn" title="Добавить в избранное">
                                <#if favouriteStatus[article.articleId?string]?? && favouriteStatus[article.articleId?string]>
                                    <i class="bi bi-heart-fill text-danger fs-4"></i>
                                <#else>
                                    <i class="bi bi-heart text-danger fs-4"></i>
                                </#if>
                            </button>
                        </form>
                    <#else>
                        <button type="button" class="favorite-btn ms-auto" onclick="showAuthAlert()">
                            <i class="bi bi-heart text-danger fs-4"></i>
                        </button>
                    </#if>
                </div>
            </div>

            <!-- Содержание статьи -->
            <div class="article-content">
                ${article.content}
            </div>

            <!-- Нижняя навигация -->
            <div class="d-flex justify-content-between align-items-center mt-4 pt-4 border-top">
                <a href="/home" class="btn btn-outline-primary">
                    <i class="bi bi-arrow-left me-2"></i>Назад к списку
                </a>
                <#if user??>
                    <a href="/favourites" class="btn btn-outline-danger">
                        <i class="bi bi-heart me-2"></i>Избранные статьи
                    </a>
                </#if>
            </div>
        </div>
    </div>

    <!-- Тост для уведомлений -->
    <div class="toast-container">
        <div class="toast align-items-center text-white bg-primary border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body"></div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

    <#include "footer.ftlh">

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Функция для показа уведомления
        function showToast(message, isError = false) {
            const toast = document.querySelector('.toast');
            const toastBody = toast.querySelector('.toast-body');
            
            toast.classList.remove('bg-primary', 'bg-danger');
            toast.classList.add(isError ? 'bg-danger' : 'bg-primary');
            
            toastBody.textContent = message;
            
            const bsToast = new bootstrap.Toast(toast);
            bsToast.show();
        }

        // Функция для неавторизованных пользователей
        function showAuthAlert() {
            showToast('Для добавления в избранное необходимо авторизоваться', true);
        }
    </script>
</body>
</html> 