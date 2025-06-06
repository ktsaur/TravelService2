<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Изменение путешествия</title>
    <style>
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #495057;
        }
        .form-group input[type="text"],
        .form-group input[type="date"],
        .form-group textarea {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            font-size: 1rem;
        }
        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        .current-photo {
            max-width: 300px;
            margin: 1rem 0;
            border-radius: 0.5rem;
        }
        .photo-preview {
            max-width: 300px;
            margin-top: 1rem;
            display: none;
            border-radius: 0.5rem;
        }
    </style>
</head>
<body>
    <#include "header.ftlh">

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="mb-0">Изменение путешествия</h1>
            <a href="/travel/detail/${travelId}" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-2"></i>Назад
            </a>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <form action="/travel/update/${travelId}" method="post" enctype="multipart/form-data">
                    <#if _csrf??>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </#if>

                    <div class="form-group">
                        <label for="nameTravel">Название путешествия:</label>
                        <input type="text" id="nameTravel" name="nameTravel" class="form-control" value="${(travelDto.nameTravel)!''}" required>
                        <#if errors?? && errors.getFieldError('nameTravel')??>
                            <div class="error-message">${errors.getFieldError('nameTravel').defaultMessage}</div>
                        </#if>
                    </div>

                    <div class="form-group">
                        <label for="description">Описание:</label>
                        <textarea id="description" name="description" class="form-control" required>${(travelDto.description)!''}</textarea>
                        <#if errors?? && errors.getFieldError('description')??>
                            <div class="error-message">${errors.getFieldError('description').defaultMessage}</div>
                        </#if>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="startDate">Дата начала:</label>
                                <input type="date" id="startDate" name="startDate" class="form-control" value="${(travelDto.startDate?string('yyyy-MM-dd'))!''}" required>
                                <#if errors?? && errors.getFieldError('startDate')??>
                                    <div class="error-message">${errors.getFieldError('startDate').defaultMessage}</div>
                                </#if>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="endDate">Дата окончания:</label>
                                <input type="date" id="endDate" name="endDate" class="form-control" value="${(travelDto.endDate?string('yyyy-MM-dd'))!''}" required>
                                <#if errors?? && errors.getFieldError('endDate')??>
                                    <div class="error-message">${errors.getFieldError('endDate').defaultMessage}</div>
                                </#if>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="transport">Транспорт:</label>
                        <input type="text" id="transport" name="transport" class="form-control" value="${(travelDto.transport)!''}" required>
                        <#if errors?? && errors.getFieldError('transport')??>
                            <div class="error-message">${errors.getFieldError('transport').defaultMessage}</div>
                        </#if>
                    </div>

                    <div class="form-group">
                        <label for="listOfThings">Список вещей:</label>
                        <textarea id="listOfThings" name="listOfThings" class="form-control">${(travelDto.listOfThings)!''}</textarea>
                    </div>

                    <div class="form-group">
                        <label for="notes">Заметки:</label>
                        <textarea id="notes" name="notes" class="form-control">${(travelDto.notes)!''}</textarea>
                    </div>

                    <div class="form-group">
                        <label for="photo">Фотография:</label>
                        <#if travel.travelUrl?? && travel.travelUrl != "">
                            <img src="${travel.travelUrl}" alt="Текущее фото" class="current-photo">
                        </#if>
                        <input type="file" id="photo" name="photo" accept="image/*" class="form-control" onchange="validateAndPreviewImage(this)">
                        <div id="photoError" class="error-message" style="display: none;"></div>
                        <img id="preview" src="#" alt="Предпросмотр" class="photo-preview">
                        <small class="text-muted d-block mt-2">Максимальный размер файла: 10MB. Поддерживаемые форматы: JPG, PNG, GIF.</small>
                    </div>

                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <a href="/travel/detail/${travelId}" class="btn btn-outline-secondary">Отмена</a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-lg me-2"></i>Сохранить изменения
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <#include "footer.ftlh">

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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