<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Document</title>
    <style>
        .registration-form {
            max-width: 500px;
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

<#-- Здесь можно вставить include другого шаблона, например: -->
<#-- <#include "header.ftl"> -->

<div class="container">
    <div class="registration-form">
        <h2>Регистрация</h2>

        <#if errorMessage??>
        <div class="alert alert-danger" role="alert">
            ${errorMessage}
        </div>
        </#if>

    <form action="/registration" method="post">
        <div class="form-group">
            <label for="username">Имя пользователя:</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>

        <div class="form-group">
            <label for="email">Электронная почта:</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="password">Пароль:</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <button type="submit" class="btn btn-primary">Зарегистрироваться</button>
    </form>

    <p class="mt-3 text-center">
        Уже есть аккаунт?
        <a href="/login">Войти</a>
    </p>
</div>
</div>

</body>
</html>
