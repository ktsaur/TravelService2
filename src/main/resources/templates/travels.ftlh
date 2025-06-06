<#import "layout.ftlh" as layout>
<@layout.layout>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="mb-0">Мои путешествия</h1>
            <a href="/create/travel" class="btn btn-primary">
                <i class="bi bi-plus-circle-fill me-2"></i>Создать путешествие
            </a>
        </div>

        <#if success??>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </#if>

        <div id="travel-container" class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <!-- Здесь будут динамически отображаться путешествия через JavaScript -->
        </div>

        <div id="no-travels" class="text-center py-5" style="display: none;">
            <i class="bi bi-compass display-1 text-muted mb-3"></i>
            <h3>У вас пока нет запланированных путешествий</h3>
            <p class="text-muted">Создайте свое первое путешествие, нажав кнопку "Создать путешествие"</p>
        </div>
    </div>
</@layout.layout> 