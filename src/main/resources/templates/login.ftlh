<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Document</title>
    <style>
        .login-form {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="login-form">
        <h2>Вход</h2>

        <#if param?? && param.error??>
            <div class="alert alert-danger" role="alert">
                Неверное имя пользователя или пароль
            </div>
        </#if>

        <#if param?? && param.logout??>
            <div class="alert alert-success" role="alert">
                Вы успешно вышли
            </div>
        </#if>

        <form action="/login" method="post">
            <div class="form-group">
                <label for="username">Имя пользователя:</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Пароль:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary">Войти</button>
        </form>

    <p class="mt-3 text-center">Нет аккаунта? <a href="/registration">Зарегистрироваться</a></p>
    </div>
</div>

</body>
</html>
