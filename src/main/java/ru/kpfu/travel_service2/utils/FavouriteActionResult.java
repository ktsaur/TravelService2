package ru.kpfu.travel_service2.utils;

public class FavouriteActionResult {
    private boolean success; // Удалось ли выполнить действие
    private boolean isFavourite; // Новый статус избранного

    public FavouriteActionResult(boolean success, boolean isFavourite) {
        this.success = success;
        this.isFavourite = isFavourite;
    }

    public boolean isSuccess() {
        return success;
    }

    public boolean isFavourite() {
        return isFavourite;
    }
}
