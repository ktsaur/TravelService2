package ru.kpfu.travel_service2.services;


import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.Map;

@Service
public class CurrencyService {

    private final RestTemplate restTemplate = new RestTemplate();

    public String getUsdToRubExchangeRate() {
        String url = UriComponentsBuilder
                .fromUriString("https://api.exchangerate.host/live")
                .queryParam("access_key", "428c61542df6d634ddc115c3497dbbfb")
                .queryParam("currencies", "RUB")
                .toUriString();

        Map<String, Object> response = restTemplate.getForObject(url, Map.class);

        if (response == null || !response.containsKey("quotes")) {
            throw new RuntimeException("Не удалось получить курс валют");
        }

        Map<String, Object> quotes = (Map<String, Object>) response.get("quotes");

        if (quotes == null || !quotes.containsKey("USDRUB")) {
            throw new RuntimeException("Нет курса USDRUB в ответе");
        }

        Double rubRate = Double.valueOf(quotes.get("USDRUB").toString());

        return "Текущий курс USD к RUB: " + rubRate;
    }

}