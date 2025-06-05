package ru.kpfu.travel_service2.utils;

public class FavouriteActionResult {
    private boolean success;
    private boolean isFavourite;

    public FavouriteActionResult(boolean success, boolean isFavourite) {
        this.success = success;
        this.isFavourite = isFavourite;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public boolean isFavourite() {
        return isFavourite;
    }

    public void setFavourite(boolean favourite) {
        isFavourite = favourite;
    }
}
