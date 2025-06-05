<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Вход</title>

    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/style/bootstrap.css">
    <link rel="stylesheet" href="/style/_nav.scss">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    
    <style>
        body {
            background: url('https://res.cloudinary.com/dkiovijcy/image/upload/v1733936454/IMG_4766_vsg2b5.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .login-container {
            width: 100%;
            max-width: 480px;
            margin: 0 auto;
            padding: 40px;
            background: rgba(255, 255, 255, 0.92);
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(8px);
        }
        
        .form-title {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
            font-size: 2rem;
            font-weight: 600;
        }

        .form-label {
            font-weight: 500;
            color: #2c3e50;
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-size: 1rem;
            box-sizing: border-box;
        }

        .form-control:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 0 0.2rem rgba(76, 175, 80, 0.25);
        }

        .form-control::placeholder {
            color: #adb5bd;
        }

        .mb-3 {
            margin-bottom: 1.5rem !important;
        }

        .btn-primary {
            width: 100%;
            padding: 12px;
            font-size: 1.1rem;
            font-weight: 500;
            background-color: #4CAF50;
            border: none;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #43A047;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.2);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .text-center {
            margin-top: 1.5rem;
            color: #2c3e50;
        }

        .text-center a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .text-center a:hover {
            color: #43A047;
            text-decoration: underline;
        }

        .alert-danger {
            background-color: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.2);
            color: #dc3545;
            border-radius: 8px;
            padding: 1rem;
        }

        @media (max-width: 576px) {
            .login-container {
                padding: 30px 20px;
            }
            
            .form-title {
                font-size: 1.75rem;
            }
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2 class="form-title">Вход</h2>
    <#if message??>
        <div class="alert alert-danger">
            ${message}
        </div>
    </#if>
    <form action="/login" method="POST">
        <#if _csrf??>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        </#if>
        <div class="mb-3">
            <label for="username" class="form-label">Имя пользователя</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Пароль</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-primary w-100 mb-3">Войти</button>
        <div class="text-center">
            <a href="/registration" class="text-decoration-none">Зарегистрироваться</a>
        </div>
    </form>
</div>

</body>
</html>