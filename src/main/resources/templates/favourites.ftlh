<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Избранные статьи</title>
</head>
<body>
    <#include "header.ftlh">

    <div class="container py-4">
        <!-- Toast для уведомлений -->
        <div class="toast-container position-fixed top-0 end-0 p-3">
            <div class="toast align-items-center text-white bg-primary border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body"></div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h2 class="mb-0">
                        <i class="bi bi-heart-fill text-danger me-2"></i>Избранные статьи
                    </h2>
                    <a href="/home" class="btn btn-outline-primary">
                        <i class="bi bi-journal-text me-2"></i>Все статьи
                    </a>
                </div>

                <#if articles?? && articles?size gt 0>
                    <div class="row g-4">
                        <#list articles as article>
                            <div class="col-12" id="article-${article.articleId}">
                                <div class="card shadow-sm h-100">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <h3 class="card-title h4 mb-3">
                                                <a href="/article/${article.articleId}" class="text-decoration-none text-dark">
                                                    ${article.title}
                                                </a>
                                            </h3>
                                            <form action="/home" method="post" class="d-inline" onsubmit="return handleFavoriteSubmit(event, ${article.articleId})">
                                                <#if _csrf??>
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                </#if>
                                                <input type="hidden" name="action" value="toggleFavourite"/>
                                                <input type="hidden" name="articleId" value="${article.articleId}"/>
                                                <button type="submit" class="btn btn-link text-danger p-0 favorite-btn">
                                                    <i class="bi bi-heart-fill fs-4"></i>
                                                </button>
                                            </form>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-light text-dark">
                                                <i class="bi bi-bookmark-fill me-1"></i>
                                                ${(article.category)!'Без категории'}
                                            </span>
                                            <span class="ms-2 text-muted">
                                                <i class="bi bi-calendar3 me-1"></i>
                                                ${article.createdDate?string("dd.MM.yyyy")}
                                            </span>
                                        </div>

                                        <p class="card-text text-muted">
                                            <#if article.content??>
                                                <#if article.content?length gt 200>
                                                    ${article.content[0..199]}...
                                                <#else>
                                                    ${article.content}
                                                </#if>
                                            </#if>
                                        </p>

                                        <a href="/article/${article.articleId}" class="btn btn-primary">
                                            <i class="bi bi-book me-2"></i>Читать полностью
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </#list>
                    </div>
                <#else>
                    <div class="text-center py-5">
                        <i class="bi bi-heart text-danger display-1 mb-3"></i>
                        <h3 class="text-muted">У вас пока нет избранных статей</h3>
                        <p class="text-muted mb-4">Добавляйте интересные статьи в избранное, чтобы не потерять их</p>
                        <a href="/home" class="btn btn-primary">
                            <i class="bi bi-journal-text me-2"></i>Перейти к статьям
                        </a>
                    </div>
                </#if>
            </div>
        </div>
    </div>

    <#include "footer.ftlh">

    <script>
        function showToast(message, isError = false) {
            const toast = document.querySelector('.toast');
            const toastBody = toast.querySelector('.toast-body');
            
            toast.classList.remove('bg-primary', 'bg-danger');
            toast.classList.add(isError ? 'bg-danger' : 'bg-primary');
            
            toastBody.textContent = message;
            
            const bsToast = new bootstrap.Toast(toast);
            bsToast.show();
        }

        function handleFavoriteSubmit(event, articleId) {
            event.preventDefault();
            const form = event.target;
            const formData = new FormData(form);
            
            fetch('/article/toggle-favourite/' + articleId, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('input[name="_csrf"]').value
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const articleElement = document.getElementById('article-' + articleId);
                    articleElement.style.opacity = '0';
                    articleElement.style.transition = 'opacity 0.3s ease';
                    
                    setTimeout(() => {
                        articleElement.remove();
                        
                        // Проверяем, остались ли статьи
                        const articles = document.querySelectorAll('[id^="article-"]');
                        if (articles.length === 0) {
                            location.reload(); // Перезагружаем страницу для отображения пустого состояния
                        }
                    }, 300);

                    showToast('Статья удалена из избранного');
                } else {
                    showToast(data.message || 'Произошла ошибка', true);
                }
            })
            .catch(error => {
                showToast('Произошла ошибка при обновлении избранного', true);
            });

            return false;
        }
    </script>
</body>
</html> 