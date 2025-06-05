<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Изменение пароля</title>
    <style>
        .container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
        }
        .btn-primary {
            background-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Изменение пароля</h2>
            <a href="/profile" class="auth-button">Назад в профиль</a>
        </div>

        <#if errorMessage??>
            <div class="alert alert-danger">
                ${errorMessage}
            </div>
        </#if>

        <form action="/profile/password" method="post">
            <div class="form-group">
                <label for="currentPassword">Текущий пароль:</label>
                <input type="password" id="currentPassword" name="currentPassword" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="newPassword">Новый пароль:</label>
                <input type="password" id="newPassword" name="newPassword" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Подтвердите новый пароль:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary">Изменить пароль</button>
        </form>
    </div>
</body>
</html> 