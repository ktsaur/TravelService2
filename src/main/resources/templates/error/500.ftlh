<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Внутренняя ошибка сервера</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .error-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .error-content {
            max-width: 600px;
            padding: 2rem;
        }
        .error-code {
            font-size: 8rem;
            font-weight: bold;
            color: #dc3545;
            margin-bottom: 1rem;
        }
        .error-message {
            font-size: 1.5rem;
            margin-bottom: 2rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-content">
            <div class="error-code">500</div>
            <div class="error-message">Внутренняя ошибка сервера</div>
            <p class="mb-4">Произошла непредвиденная ошибка. Пожалуйста, попробуйте позже или обратитесь в службу поддержки.</p>
            <a href="/home" class="btn btn-primary">Вернуться на главную</a>
        </div>
    </div>
</body>
</html> 