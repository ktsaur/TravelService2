<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Детали путешествия</title>
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
        .travel-detail {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .travel-title {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }
        .travel-info {
            margin-bottom: 15px;
        }
        .travel-info-label {
            font-weight: bold;
            color: #666;
        }
        .travel-info-value {
            margin-top: 5px;
            color: #333;
        }
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Детали путешествия</h2>
            <a href="/travels" class="btn btn-back">Назад к списку</a>
        </div>

        <#if success??>
            <div class="alert alert-success">${success}</div>
        </#if>

        <div class="travel-detail">
            <h1 class="travel-title">${travel.nameTravel}</h1>

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
                <a href="/travel/update/${travel.travelId}" class="btn btn-primary">Изменить путешествие</a>
                <form action="/travel/delete/${travel.travelId}" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-danger" onclick="return confirm('Вы уверены, что хотите удалить это путешествие?')">
                        Удалить путешествие
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>
</html> 