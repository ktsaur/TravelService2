<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Изменение путешествия</title>
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
        input[type="text"], input[type="date"], textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            height: 100px;
            resize: vertical;
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Изменение путешествия</h2>
            <a href="/travel/detail/${travelId}" class="btn btn-back">Назад</a>
        </div>

        <form action="/travel/update/${travelId}" method="post">
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

            <div class="button-group">
                <button type="submit" class="btn btn-primary">Сохранить изменения</button>
            </div>
        </form>
    </div>
</body>
</html> 