<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Создание нового путешествия</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
        }
        .header {
            margin-bottom: 2rem;
            text-align: center;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            display: block;
        }
        input[type="text"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            font-size: 1rem;
        }
        textarea {
            min-height: 100px;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        .submit-button {
            background-color: #0d6efd;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 0.25rem;
            cursor: pointer;
            font-size: 1rem;
        }
        .submit-button:hover {
            background-color: #0b5ed7;
        }
        .photo-preview {
            max-width: 300px;
            margin-top: 1rem;
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Создание нового путешествия</h2>
        </div>

        <form action="/create/travel" method="post" enctype="multipart/form-data">
            <#if _csrf??>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </#if>

            <div class="form-group">
                <label for="nameTravel">Название путешествия:</label>
                <input type="text" id="nameTravel" name="nameTravel" value="${(travelDto.nameTravel)!''}" required>
                <#if errors?? && errors.getFieldError('nameTravel')??>
                    <div class="error-message">${errors.getFieldError('nameTravel').defaultMessage}</div>
                </#if>
            </div>

            <div class="form-group">
                <label for="description">Описание:</label>
                <textarea id="description" name="description" required>${(travelDto.description)!''}</textarea>
                <#if errors?? && errors.getFieldError('description')??>
                    <div class="error-message">${errors.getFieldError('description').defaultMessage}</div>
                </#if>
            </div>

            <div class="form-group">
                <label for="startDate">Дата начала:</label>
                <input type="date" id="startDate" name="startDate" value="${(travelDto.startDate?string('yyyy-MM-dd'))!''}" required>
                <#if errors?? && errors.getFieldError('startDate')??>
                    <div class="error-message">${errors.getFieldError('startDate').defaultMessage}</div>
                </#if>
            </div>

            <div class="form-group">
                <label for="endDate">Дата окончания:</label>
                <input type="date" id="endDate" name="endDate" value="${(travelDto.endDate?string('yyyy-MM-dd'))!''}" required>
                <#if errors?? && errors.getFieldError('endDate')??>
                    <div class="error-message">${errors.getFieldError('endDate').defaultMessage}</div>
                </#if>
            </div>

            <div class="form-group">
                <label for="transport">Транспорт:</label>
                <input type="text" id="transport" name="transport" value="${(travelDto.transport)!''}" required>
                <#if errors?? && errors.getFieldError('transport')??>
                    <div class="error-message">${errors.getFieldError('transport').defaultMessage}</div>
                </#if>
            </div>

            <div class="form-group">
                <label for="listOfThings">Список вещей:</label>
                <textarea id="listOfThings" name="listOfThings">${(travelDto.listOfThings)!''}</textarea>
            </div>

            <div class="form-group">
                <label for="notes">Заметки:</label>
                <textarea id="notes" name="notes">${(travelDto.notes)!''}</textarea>
            </div>

            <div class="form-group">
                <label for="photo">Фотография:</label>
                <input type="file" id="photo" name="photo" accept="image/*" class="form-control" onchange="validateAndPreviewImage(this)">
                <div id="photoError" class="error-message" style="display: none;"></div>
                <img id="preview" src="#" alt="Предпросмотр" class="photo-preview">
                <small class="text-muted">Максимальный размер файла: 10MB. Поддерживаемые форматы: JPG, PNG, GIF.</small>
            </div>

            <button type="submit" class="submit-button" id="submitButton">Сохранить путешествие</button>
        </form>
    </div>

    <script>
        function validateAndPreviewImage(input) {
            const preview = document.getElementById('preview');
            const errorDiv = document.getElementById('photoError');
            const submitButton = document.getElementById('submitButton');
            const maxSize = 10 * 1024 * 1024; // 10MB в байтах
            
            // Сбрасываем предыдущие ошибки
            errorDiv.style.display = 'none';
            errorDiv.textContent = '';
            submitButton.disabled = false;
            
            if (input.files && input.files[0]) {
                const file = input.files[0];
                
                // Проверяем размер файла
                if (file.size > maxSize) {
                    errorDiv.textContent = 'Размер файла превышает 10MB';
                    errorDiv.style.display = 'block';
                    preview.style.display = 'none';
                    submitButton.disabled = true;
                    input.value = ''; // Очищаем input
                    return;
                }
                
                // Проверяем тип файла
                if (!file.type.startsWith('image/')) {
                    errorDiv.textContent = 'Пожалуйста, загрузите изображение';
                    errorDiv.style.display = 'block';
                    preview.style.display = 'none';
                    submitButton.disabled = true;
                    input.value = ''; // Очищаем input
                    return;
                }
                
                // Если все проверки пройдены, показываем предпросмотр
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