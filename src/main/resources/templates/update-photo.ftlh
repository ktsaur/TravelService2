<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Загрузка фотографии профиля</title>
    <style>
        .photo-preview {
            max-width: 150px;
            margin-top: 1rem;
            display: none;
            border-radius: 50%;
        }
        .current-photo {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
        }
        .photo-placeholder {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <#include "header.ftlh">

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h2 class="card-title text-center mb-4">Загрузка фотографии профиля</h2>

                        <form action="/profile/photo" method="post" enctype="multipart/form-data" class="text-center">
                            <#if _csrf??>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </#if>

                            <div class="mb-4">
                                <#if user.profile_url?? && user.profile_url != "">
                                    <img src="${user.profile_url}" alt="Текущее фото" class="current-photo mb-3">
                                <#else>
                                    <div class="photo-placeholder">
                                        <i class="bi bi-person text-secondary" style="font-size: 4rem;"></i>
                                    </div>
                                </#if>
                            </div>

                            <div class="mb-4">
                                <label for="photo" class="form-label">Выберите новую фотографию</label>
                                <input type="file" id="photo" name="photo" accept="image/*" class="form-control" onchange="validateAndPreviewImage(this)" required>
                                <div id="photoError" class="invalid-feedback" style="display: none;"></div>
                                <img id="preview" src="#" alt="Предпросмотр" class="photo-preview mx-auto">
                                <small class="text-muted d-block mt-2">Максимальный размер файла: 10MB. Поддерживаемые форматы: JPG, PNG, GIF.</small>
                            </div>

                            <#if error??>
                                <div class="alert alert-danger" role="alert">${error}</div>
                            </#if>

                            <div class="d-flex justify-content-center gap-2">
                                <a href="/profile" class="btn btn-outline-secondary">
                                    <i class="bi bi-x-lg me-2"></i>Отмена
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-cloud-upload me-2"></i>Загрузить фотографию
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
        function validateAndPreviewImage(input) {
            const maxSize = 10 * 1024 * 1024; // 10MB
            const allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
            const file = input.files[0];
            const errorElement = document.getElementById('photoError');
            const preview = document.getElementById('preview');

            errorElement.style.display = 'none';
            if (file) {
                if (file.size > maxSize) {
                    errorElement.textContent = 'Размер файла превышает 10MB';
                    errorElement.style.display = 'block';
                    input.value = '';
                    preview.style.display = 'none';
                    return;
                }

                if (!allowedTypes.includes(file.type)) {
                    errorElement.textContent = 'Пожалуйста, загрузите изображение в формате JPG, PNG или GIF';
                    errorElement.style.display = 'block';
                    input.value = '';
                    preview.style.display = 'none';
                    return;
                }

                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                }
                reader.readAsDataURL(file);
            } else {
                preview.src = '#';
                preview.style.display = 'none';
            }
        }
    </script>
</body>
</html> 