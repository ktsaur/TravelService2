<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Профиль пользователя</title>
</head>
<body>
    <#include "header.ftlh">

    <div class="container py-4">
        <#if success??>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </#if>

        <div class="row">
            <div class="col-md-4 text-center mb-4">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <#if user.profile_url?? && user.profile_url != "">
                            <img src="${user.profile_url}" alt="Фото профиля" class="rounded-circle mb-3" style="width: 150px; height: 150px; object-fit: cover;">
                        <#else>
                            <div class="rounded-circle bg-light d-flex align-items-center justify-content-center mx-auto mb-3" style="width: 150px; height: 150px;">
                                <i class="bi bi-person text-secondary" style="font-size: 4rem;"></i>
                            </div>
                        </#if>
                        <h4 class="mb-0">${user.username}</h4>
                        <p class="text-muted">${user.email}</p>
                        <a href="/profile/photo" class="btn btn-outline-primary mt-3">
                            <i class="bi bi-camera me-2"></i>Загрузить фотографию
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title mb-4">Информация профиля</h5>
                        
                        <div class="mb-4">
                            <h6 class="text-muted mb-2">Имя пользователя</h6>
                            <p class="mb-0">${user.username}</p>
                        </div>
                        
                        <div class="mb-4">
                            <h6 class="text-muted mb-2">Email</h6>
                            <p class="mb-0">${user.email}</p>
                        </div>
                        
                        <div class="mb-4">
                            <h6 class="text-muted mb-2">Пароль</h6>
                            <p class="mb-2">********</p>
                            <a href="/profile/password" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-key me-2"></i>Изменить пароль
                            </a>
                        </div>

                        <div class="d-flex gap-2">
                            <a href="/profile/update" class="btn btn-primary">
                                <i class="bi bi-pencil me-2"></i>Изменить данные профиля
                            </a>
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                                <i class="bi bi-trash me-2"></i>Удалить аккаунт
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal для подтверждения удаления аккаунта -->
    <div class="modal fade" id="deleteAccountModal" tabindex="-1" aria-labelledby="deleteAccountModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteAccountModalLabel">Подтверждение удаления</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Вы уверены, что хотите удалить свой аккаунт? Это действие нельзя будет отменить.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                    <form action="/profile/delete" method="post" style="display: inline;">
                        <#if _csrf??>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </#if>
                        <button type="submit" class="btn btn-danger">Удалить аккаунт</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <#include "footer.ftlh">
</body>
</html> 