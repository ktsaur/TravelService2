<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Создание статьи</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .form-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }

        .form-floating {
            margin-bottom: 1rem;
        }

        .btn-submit {
            padding: 0.75rem 2rem;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>
<#include "header.ftlh">

<div class="container">
    <div class="form-container">
        <h2 class="text-center mb-4">Создание новой статьи</h2>

        <form action="/create/article" method="post">
            <#if _csrf??>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </#if>

            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="title" name="title"
                       value="${(articleDto.title)!''}" placeholder="Введите заголовок" required>
                <label for="title">Заголовок</label>
                <#if errors?? && errors.getFieldError('title')??>
                    <div class="invalid-feedback d-block">
                        ${errors.getFieldError('title').defaultMessage}
                    </div>
                </#if>
            </div>

            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="category" name="category"
                       value="${(articleDto.category)!''}" placeholder="Введите категорию" required>
                <label for="category">Категория</label>
                <#if errors?? && errors.getFieldError('category')??>
                    <div class="invalid-feedback d-block">
                        ${errors.getFieldError('category').defaultMessage}
                    </div>
                </#if>
            </div>

            <div class="form-floating mb-4">
                    <textarea class="form-control" id="content" name="content"
                              style="height: 200px" placeholder="Введите содержание"
                              required>${(articleDto.content)!''}</textarea>
                <label for="content">Содержание</label>
                <#if errors?? && errors.getFieldError('content')??>
                    <div class="invalid-feedback d-block">
                        ${errors.getFieldError('content').defaultMessage}
                    </div>
                </#if>
            </div>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <a href="/home" class="btn btn-secondary me-md-2">Отмена</a>
                <button type="submit" class="btn btn-primary btn-submit">
                    <i class="bi bi-plus-circle me-2"></i>Создать статью
                </button>
            </div>
        </form>
    </div>
</div>
<#include "footer.ftlh">

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 