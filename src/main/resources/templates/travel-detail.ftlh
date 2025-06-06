<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Детали путешествия</title>
    <style>
        .travel-detail {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 1rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
        .travel-title {
            font-size: 2rem;
            color: #212529;
            margin-bottom: 1.5rem;
        }
        .travel-info {
            margin-bottom: 1.5rem;
        }
        .travel-info-label {
            font-weight: 600;
            color: #6c757d;
            margin-bottom: 0.5rem;
        }
        .travel-info-value {
            color: #212529;
        }
        .travel-photo {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
        }
        .button-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
    <#include "header.ftlh">

    <div class="container py-4">
        <#if success??>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </#if>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="mb-0">Детали путешествия</h1>
            <a href="/travels" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-2"></i>Назад к списку
            </a>
        </div>

        <div class="travel-detail">
            <h2 class="travel-title">${travel.nameTravel}</h2>

            <#if travel.travelUrl?? && travel.travelUrl != "">
                <img src="${travel.travelUrl}" alt="Фото путешествия" class="travel-photo">
            </#if>

            <div class="travel-info">
                <div class="travel-info-label">Описание:</div>
                <div class="travel-info-value">${travel.description}</div>
            </div>

            <div class="travel-info">
                <div class="travel-info-label">Даты:</div>
                <div class="travel-info-value">
                    ${travel.startDate?string("dd.MM.yyyy")} - ${travel.endDate?string("dd.MM.yyyy")}
                </div>
            </div>

            <div class="travel-info">
                <div class="travel-info-label">Транспорт:</div>
                <div class="travel-info-value">${travel.transport}</div>
            </div>

            <#if travel.listOfThings?has_content>
                <div class="travel-info">
                    <div class="travel-info-label">Список вещей:</div>
                    <div class="travel-info-value">${travel.listOfThings}</div>
                </div>
            </#if>

            <#if travel.notes?has_content>
                <div class="travel-info">
                    <div class="travel-info-label">Заметки:</div>
                    <div class="travel-info-value">${travel.notes}</div>
                </div>
            </#if>

            <div class="button-group">
                <a href="/travel/update/${travel.travelId}" class="btn btn-primary">
                    <i class="bi bi-pencil me-2"></i>Изменить
                </a>
                <form action="/travel/delete/${travel.travelId}" method="post" style="display: inline;">
                    <#if _csrf??>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </#if>
                    <button type="submit" class="btn btn-danger" onclick="return confirm('Вы уверены, что хотите удалить это путешествие?')">
                        <i class="bi bi-trash me-2"></i>Удалить
                    </button>
                </form>
            </div>
        </div>
    </div>

    <#include "footer.ftlh">
</body>
</html> 