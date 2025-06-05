<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Изменение профиля</title>
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
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #666;
        }
        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
        }
        .button-group {
            margin-top: 20px;
        }
        .btn-save {
            background-color: #28a745;
        }
        .btn-save:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Изменение профиля</h2>
            <div class="auth-buttons">
                <a href="/profile" class="auth-button">Назад к профилю</a>
            </div>
        </div>

        <form action="/profile/update" method="post">
            <div class="form-group">
                <label for="username">Имя пользователя:</label>
                <input type="text" id="username" name="username" value="${updateProfileDto.username}" required>
                <#if errors?? && errors.getFieldError('username')??>
                    <div class="error-message">${errors.getFieldError('username').defaultMessage}</div>
                </#if>
                <#if usernameError??>
                    <div class="error-message">${usernameError}</div>
                </#if>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${updateProfileDto.email}" required>
                <#if errors?? && errors.getFieldError('email')??>
                    <div class="error-message">${errors.getFieldError('email').defaultMessage}</div>
                </#if>
                <#if emailError??>
                    <div class="error-message">${emailError}</div>
                </#if>
            </div>

            <#if error??>
                <div class="error-message" style="margin-bottom: 20px;">${error}</div>
            </#if>

            <div class="button-group">
                <button type="submit" class="auth-button btn-save">Сохранить изменения</button>
            </div>
        </form>
    </div>
</body>
</html> 