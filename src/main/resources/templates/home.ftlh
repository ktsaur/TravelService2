<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .nav-pills .nav-link {
            color: #495057;
            border-radius: 0.5rem;
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
        }
        .nav-pills .nav-link:hover {
            background-color: #e9ecef;
            transform: translateX(5px);
        }
        .nav-pills .nav-link.active {
            background-color: #0d6efd;
            color: white;
        }
        .article-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .article-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15);
        }
        .scrollspy-example-2 {
            height: calc(100vh - 250px);
            overflow-y: auto;
            padding-right: 1rem;
        }
        .scrollspy-example-2::-webkit-scrollbar {
            width: 6px;
        }
        .scrollspy-example-2::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        .scrollspy-example-2::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 3px;
        }
        .create-article-btn {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            z-index: 1000;
            border-radius: 50px;
            padding: 1rem 2rem;
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15);
        }
        .favorite-btn {
            transition: transform 0.3s ease;
        }
        .favorite-btn:hover {
            transform: scale(1.2);
        }
    </style>
</head>
<body>
    <#include "header.ftlh">

    <div class="container-fluid py-5">
        <#if message??>
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </#if>

        <#if groupedArticles?? && groupedArticles?size == 0>
            <div class="text-center py-5">
                <i class="bi bi-journal-x display-1 text-muted mb-3"></i>
                <h3 class="text-muted">Статей пока нет</h3>
                <p class="text-muted">Будьте первым, кто создаст статью!</p>
            </div>
        </#if>

        <#if groupedArticles?? && groupedArticles?size gt 0>
            <div class="row">
                <!-- Sidebar Navigation -->
                <div class="col-lg-3 col-md-4">
                    <div class="position-sticky" style="top: 2rem;">
                        <nav id="navbar-example3" class="navbar navbar-light bg-white rounded-3 shadow-sm p-3">
                            <nav class="nav nav-pills flex-column w-100">
                                <#list groupedArticles?keys as category>
                                    <div class="mb-3">
                                        <a class="nav-link fw-bold" href="#category-${category}">
                                            <i class="bi bi-bookmark-fill me-2"></i>${category}
                                        </a>
                                        <nav class="nav nav-pills flex-column ms-3">
                                            <#list groupedArticles[category] as article>
                                                <a class="nav-link small" href="#article-${article.articleId}">
                                                    ${article.title}
                                                </a>
                                            </#list>
                                        </nav>
                                    </div>
                                </#list>
                            </nav>
                        </nav>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-lg-9 col-md-8">
                    <div data-bs-spy="scroll" data-bs-target="#navbar-example3" data-bs-smooth-scroll="true" 
                         class="scrollspy-example-2" tabindex="0">
                        <#list groupedArticles as category, articles>
                            <div id="category-${category}" class="mb-5">
                                <h3 class="border-bottom pb-2 mb-4">
                                    <i class="bi bi-collection me-2"></i>${category}
                                </h3>
                                <div class="row g-4">
                                    <#list articles as article>
                                        <div class="col-12" id="article-${article.articleId}">
                                            <div class="card article-card border-0 shadow-sm">
                                                <div class="card-body">
                                                    <h4 class="card-title mb-3">${article.title}</h4>
                                                    <p class="card-text text-muted">
                                                        <#if article.content??>
                                                            <#if article.content?length gt 200>
                                                                ${article.content[0..199]}...
                                                            <#else>
                                                                ${article.content}
                                                            </#if>
                                                        </#if>
                                                    </p>
                                                    <div class="d-flex align-items-center justify-content-between mt-3">
                                                        <a href="/article/${article.articleId}" class="btn btn-primary">
                                                            <i class="bi bi-book me-2"></i>Читать полностью
                                                        </a>
                                                        <#if user??>
                                                            <form action="/home" method="post" class="d-inline">
                                                                <#if _csrf??>
                                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                                </#if>
                                                                <input type="hidden" name="action" value="toggleFavourite"/>
                                                                <input type="hidden" name="articleId" value="${article.articleId}"/>
                                                                <button type="submit" class="btn btn-link favorite-btn p-0">
                                                                    <#if favouriteStatus[article.articleId?string]?? && favouriteStatus[article.articleId?string]>
                                                                        <i class="bi bi-heart-fill text-danger fs-4"></i>
                                                                    <#else>
                                                                        <i class="bi bi-heart text-danger fs-4"></i>
                                                                    </#if>
                                                                </button>
                                                            </form>
                                                        </#if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </#list>
                                </div>
                            </div>
                        </#list>
                    </div>
                </div>
            </div>
        </#if>

        <a href="/create/article" class="btn btn-primary create-article-btn">
            <i class="bi bi-plus-circle-fill me-2"></i>Создать статью
        </a>
    </div>

    <#include "footer.ftlh">

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
