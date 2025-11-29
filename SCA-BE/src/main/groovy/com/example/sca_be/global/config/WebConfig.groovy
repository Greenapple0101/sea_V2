package com.example.sca_be.global.config

import org.springframework.context.annotation.Configuration
import org.springframework.http.MediaType
import org.springframework.http.converter.HttpMessageConverter
import org.springframework.http.converter.StringHttpMessageConverter
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer

import java.nio.charset.StandardCharsets
import java.util.ArrayList
import java.util.List

@Configuration
class WebConfig implements WebMvcConfigurer {
    
    @Override
    void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        // StringHttpMessageConverter에 UTF-8 인코딩 명시
        converters.add(new StringHttpMessageConverter(StandardCharsets.UTF_8))
        
        // JSON 응답을 위한 MappingJackson2HttpMessageConverter에 UTF-8 인코딩 설정
        MappingJackson2HttpMessageConverter jsonConverter = new MappingJackson2HttpMessageConverter()
        jsonConverter.setDefaultCharset(StandardCharsets.UTF_8)
        // Content-Type에 charset=UTF-8 포함
        List<MediaType> supportedMediaTypes = new ArrayList<>(jsonConverter.getSupportedMediaTypes())
        supportedMediaTypes.add(new MediaType(MediaType.APPLICATION_JSON, StandardCharsets.UTF_8))
        jsonConverter.setSupportedMediaTypes(supportedMediaTypes)
        converters.add(jsonConverter)
    }
}

