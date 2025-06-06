<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Мои путешествия</title>
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
        .create-travel-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .create-travel-button:hover {
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
        .travel-list {
            list-style: none;
            padding: 0;
        }
        .travel-item {
            padding: 15px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: background-color 0.2s;
        }
        .travel-item:hover {
            background-color: #f8f9fa;
        }
        .travel-link {
            text-decoration: none;
            color: #333;
            font-size: 18px;
            display: block;
        }
        .travel-link:hover {
            color: #007bff;
        }
    </style>
</head>
<body>
    <#include "header.ftlh">

    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="mb-0">Мои путешествия</h1>
            <a href="/create/travel" class="btn btn-primary">
                <i class="bi bi-plus-circle-fill me-2"></i>Создать путешествие
            </a>
        </div>

        <#if success??>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </#if>

        <#if travels?? && travels?size gt 0>
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                <#list travels as travel>
                    <div class="col">
                        <div class="card h-100 shadow-sm">
                            <#if travel.travelUrl?? && travel.travelUrl != "">
                                <img src="${travel.travelUrl}" class="card-img-top" alt="Фото путешествия" style="height: 200px; object-fit: cover;">
                            <#else>
                                <div class="card-img-top bg-light d-flex align-items-center justify-content-center" style="height: 200px;">
                                    <i class="bi bi-image text-secondary" style="font-size: 3rem;"></i>
                                </div>
                            </#if>
                            <div class="card-body">
                                <h5 class="card-title">${travel.nameTravel}</h5>
                                <p class="card-text text-muted">
                                    <i class="bi bi-calendar-event me-2"></i>
                                    ${travel.startDate?string("dd.MM.yyyy")} - ${travel.endDate?string("dd.MM.yyyy")}
                                </p>
                                <p class="card-text">
                                    <i class="bi bi-car-front me-2"></i>${travel.transport}
                                </p>
                                <#if travel.description?? && travel.description?length gt 100>
                                    <p class="card-text">${travel.description[0..100]}...</p>
                                <#else>
                                    <p class="card-text">${travel.description!''}</p>
                                </#if>
                            </div>
                            <div class="card-footer bg-transparent border-top-0">
                                <a href="/travel/detail/${travel.travelId}" class="btn btn-outline-primary w-100">
                                    <i class="bi bi-eye me-2"></i>Подробнее
                                </a>
                            </div>
                        </div>
                    </div>
                </#list>
            </div>
        <#else>
            <div class="text-center py-5">
                <i class="bi bi-compass display-1 text-muted mb-3"></i>
                <h3>У вас пока нет запланированных путешествий</h3>
                <p class="text-muted">Создайте свое первое путешествие, нажав кнопку "Создать путешествие"</p>
            </div>
        </#if>
    </div>

    <#include "footer.ftlh">
</body>
</html> 