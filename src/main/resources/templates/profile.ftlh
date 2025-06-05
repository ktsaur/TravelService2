<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Профиль пользователя</title>
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
        .profile-info {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
        }
        .profile-field {
            margin-bottom: 15px;
        }
        .profile-label {
            font-weight: bold;
            color: #666;
            margin-bottom: 5px;
        }
        .profile-value {
            color: #333;
            font-size: 16px;
        }
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        .delete-button {
            background-color: #dc3545;
        }
        .delete-button:hover {
            background-color: #c82333;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .modal-content {
            background-color: #fff;
            margin: 15% auto;
            padding: 20px;
            border-radius: 8px;
            width: 80%;
            max-width: 500px;
        }
        .modal-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }
        .modal-cancel {
            background-color: #6c757d;
        }
        .modal-cancel:hover {
            background-color: #5a6268;
        }
        .modal-delete {
            background-color: #dc3545;
        }
        .modal-delete:hover {
            background-color: #c82333;
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
            <h2>Профиль пользователя</h2>
            <div class="auth-buttons">
                <a href="/home" class="auth-button">На главную</a>
                <a href="/travels" class="auth-button">Мои путешествия</a>
                <form action="/logout" method="post" style="margin: 0;">
                    <button type="submit" class="auth-button">Выйти</button>
                </form>
            </div>
        </div>

        <#if successMessage??>
            <div class="alert alert-success">${successMessage}</div>
        </#if>

        <div class="profile-info">
            <div class="profile-field">
                <div class="profile-label">Имя пользователя:</div>
                <div class="profile-value">${user.username}</div>
            </div>
            <div class="profile-field">
                <div class="profile-label">Email:</div>
                <div class="profile-value">${user.email}</div>
            </div>
            <div class="profile-field">
                <div class="profile-label">Пароль:</div>
                <div class="profile-value">
                    ********
                    <a href="/profile/password" class="auth-button">Изменить пароль</a>
                </div>
            </div>
            <div class="button-group">
                <a href="/profile/update" class="auth-button">Изменить данные</a>
                <button class="auth-button delete-button" onclick="showDeleteModal()">Удалить аккаунт</button>
            </div>
        </div>
    </div>

    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h3>Подтверждение удаления</h3>
            <p>Вы уверены, что хотите удалить свой аккаунт? Это действие нельзя будет отменить.</p>
            <div class="modal-buttons">
                <button class="auth-button modal-cancel" onclick="hideDeleteModal()">Отмена</button>
                <form action="/profile/delete" method="post" style="margin: 0;">
                    <button type="submit" class="auth-button modal-delete">Удалить</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function showDeleteModal() {
            document.getElementById('deleteModal').style.display = 'block';
        }

        function hideDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }

        window.onclick = function(event) {
            const modal = document.getElementById('deleteModal');
            if (event.target == modal) {
                hideDeleteModal();
            }
        }
    </script>
</body>
</html> 