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
    <div class="container">
        <div class="header">
            <h2>Мои путешествия</h2>
            <div class="auth-buttons">
                <a href="/home" class="auth-button">На главную</a>
                <form action="/logout" method="post" style="margin: 0;">
                    <button type="submit" class="auth-button">Выйти</button>
                </form>
            </div>
        </div>

        <#if success??>
            <div class="alert alert-success">${success}</div>
        </#if>

        <a href="/create/travel" class="create-travel-button">Создать новое путешествие</a>

        <#if travels?? && travels?size gt 0>
            <ul class="travel-list">
                <#list travels as travel>
                    <li class="travel-item">
                        <a href="/travel/detail/${travel.travelId}" class="travel-link">
                            ${travel.nameTravel}
                        </a>
                    </li>
                </#list>
            </ul>
        <#else>
            <p>У вас пока нет запланированных путешествий.</p>
        </#if>
    </div>
</body>
</html> 