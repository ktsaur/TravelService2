<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Создание статьи</title>
    <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            height: 200px;
            resize: vertical;
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
        .submit-button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .submit-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Создание новой статьи</h2>
        <form action="/create/article" method="post">
            <div class="form-group">
                <label for="title">Заголовок:</label>
                <input type="text" id="title" name="title" value="${(articleDto.title)!''}" required>
                <#if errors?? && errors.getFieldError('title')??>
                    <div class="error-message">${errors.getFieldError('title').defaultMessage}</div>
                </#if>
            </div>

            <div class="form-group">
                <label for="category">Категория:</label>
                <input type="text" id="category" name="category" value="${(articleDto.category)!''}" required>
                <#if errors?? && errors.getFieldError('category')??>
                    <div class="error-message">${errors.getFieldError('category').defaultMessage}</div>
                </#if>
            </div>

            <div class="form-group">
                <label for="content">Содержание:</label>
                <textarea id="content" name="content" required>${(articleDto.content)!''}</textarea>
                <#if errors?? && errors.getFieldError('content')??>
                    <div class="error-message">${errors.getFieldError('content').defaultMessage}</div>
                </#if>
            </div>

            <button type="submit" class="submit-button">Создать статью</button>
        </form>
    </div>
</body>
</html> 