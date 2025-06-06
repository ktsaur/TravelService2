<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Изменение пароля</title>
</head>
<body>
    <#include "header.ftlh">

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h2 class="card-title text-center mb-4">Изменение пароля</h2>

                        <form action="/profile/password" method="post">
                            <#if _csrf??>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </#if>

                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Текущий пароль</label>
                                <div class="input-group">
                                    <input type="password" id="currentPassword" name="currentPassword" class="form-control" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('currentPassword')">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                                <#if errors?? && errors.getFieldError('currentPassword')??>
                                    <div class="invalid-feedback d-block">${errors.getFieldError('currentPassword').defaultMessage}</div>
                                </#if>
                            </div>

                            <div class="mb-3">
                                <label for="newPassword" class="form-label">Новый пароль</label>
                                <div class="input-group">
                                    <input type="password" id="newPassword" name="newPassword" class="form-control" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('newPassword')">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                                <#if errors?? && errors.getFieldError('newPassword')??>
                                    <div class="invalid-feedback d-block">${errors.getFieldError('newPassword').defaultMessage}</div>
                                </#if>
                            </div>

                            <div class="mb-4">
                                <label for="confirmPassword" class="form-label">Подтвердите новый пароль</label>
                                <div class="input-group">
                                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword')">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                                <#if errors?? && errors.getFieldError('confirmPassword')??>
                                    <div class="invalid-feedback d-block">${errors.getFieldError('confirmPassword').defaultMessage}</div>
                                </#if>
                            </div>

                            <#if errorMessage??>
                                <div class="alert alert-danger mb-4" role="alert">
                                    ${errorMessage}
                                </div>
                            </#if>

                            <div class="d-flex justify-content-end gap-2">
                                <a href="/profile" class="btn btn-outline-secondary">
                                    <i class="bi bi-x-lg me-2"></i>Отмена
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-lg me-2"></i>Сохранить пароль
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <#include "footer.ftlh">

    <script>
        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const button = input.nextElementSibling;
            const icon = button.querySelector('i');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        }
    </script>
</body>
</html> 