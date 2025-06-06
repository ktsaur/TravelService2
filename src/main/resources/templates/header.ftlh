<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title!"Travel Service"}</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar {
            background-color: white !important;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 600;
            color: #343a40 !important;
        }
        .nav-link {
            font-weight: 500;
            color: #495057 !important;
        }
        .nav-link:hover {
            color: #212529 !important;
        }
        .main-content {
            flex: 1;
        }
        .hero-container {
            position: relative;
            text-align: center;
            color: white;
            height: 200px;
            overflow: hidden;
        }
        .hero-container img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            object-position: center;
        }
        .hero-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        .hero-text h1 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }
        .hero-text p {
            font-size: 1.2rem;
            margin-bottom: 0;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="/home">
                <i class="bi bi-globe-americas me-2"></i>Travel Service
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="d-flex ms-auto">
                    <#if user??>
                        <a href="/profile" class="btn btn-outline-secondary me-2">
                            <i class="bi bi-person-circle me-1"></i>Профиль
                        </a>
                        <a href="/travels" class="btn btn-outline-secondary me-2">
                            <i class="bi bi-map me-1"></i>Мои путешествия
                        </a>
                        <a href="/favourites" class="btn btn-outline-secondary me-2">
                            <i class="bi bi-heart me-1"></i>Избранное
                        </a>
                        <form action="/logout" method="post" class="d-inline">
                            <#if _csrf??>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </#if>
                            <button type="submit" class="btn btn-outline-secondary">
                                <i class="bi bi-box-arrow-right me-1"></i>Выйти
                            </button>
                        </form>
                    <#else>
                        <a href="/login" class="btn btn-outline-success me-2">Вход</a>
                        <a href="/registration" class="btn btn-outline-success">Регистрация</a>
                    </#if>
                </div>
            </div>
        </div>
    </nav>

    <div class="hero-container">
        <img src="https://res.cloudinary.com/dkiovijcy/image/upload/v1733936812/IMG_4770_b5kw5g.jpg" alt="Hero image">
        <div class="hero-text">
            <h1>Добро пожаловать в TravelMate!</h1>
            <p>Планируйте путешествия своей мечты с легкостью.</p>
        </div>
    </div>

    <div class="main-content"> 