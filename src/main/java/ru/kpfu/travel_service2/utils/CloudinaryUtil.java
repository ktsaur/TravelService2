package ru.kpfu.travel_service2.utils;

import com.cloudinary.Cloudinary;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class CloudinaryUtil {
    private static Cloudinary cloudinary;

    public static Cloudinary getInstance() {
        if (cloudinary == null) {
            Map<String, String> configMap = new HashMap<>();
            configMap.put("cloud_name", "dkiovijcy");
            configMap.put("api_key", "398688584614783");
            configMap.put("api_secret", "3ZS9h40QAT5xzKqBhS39AKHra0o");
            cloudinary = new Cloudinary(configMap);
        }
        return cloudinary;
    }
} 