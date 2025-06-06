<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Изменение данных профиля</title>
</head>
<body>
    <#include "header.ftlh">

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h2 class="card-title text-center mb-4">Изменение данных профиля</h2>

                        <form action="/profile/update" method="post">
                            <#if _csrf??>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </#if>

                            <div class="mb-3">
                                <label for="username" class="form-label">Имя пользователя</label>
                                <input type="text" id="username" name="username" class="form-control" value="${updateProfileDto.username}" required>
                                <#if errors?? && errors.getFieldError('username')??>
                                    <div class="invalid-feedback d-block">${errors.getFieldError('username').defaultMessage}</div>
                                </#if>
                                <#if usernameError??>
                                    <div class="invalid-feedback d-block">${usernameError}</div>
                                </#if>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" id="email" name="email" class="form-control" value="${updateProfileDto.email}" required>
                                <#if errors?? && errors.getFieldError('email')??>
                                    <div class="invalid-feedback d-block">${errors.getFieldError('email').defaultMessage}</div>
                                </#if>
                                <#if emailError??>
                                    <div class="invalid-feedback d-block">${emailError}</div>
                                </#if>
                            </div>

                            <#if error??>
                                <div class="alert alert-danger" role="alert">${error}</div>
                            </#if>

                            <div class="d-flex justify-content-end gap-2">
                                <a href="/profile" class="btn btn-outline-secondary">
                                    <i class="bi bi-x-lg me-2"></i>Отмена
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-lg me-2"></i>Сохранить изменения
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <#include "footer.ftlh">
</body>
</html> 