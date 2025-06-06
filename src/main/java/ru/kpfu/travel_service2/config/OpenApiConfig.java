package ru.kpfu.travel_service2.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI travelServiceOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("Travel Service API")
                        .description("REST API для сервиса путешествий")
                        .version("1.0"));
    }
} 