package org.zxy.abilitynews.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.zxy.abilitynews.component.interceptor.BlogInterceptor;

@Configuration
@PropertySource("classpath:server.properties")
public class WebConfig  implements WebMvcConfigurer {

    @Bean
    public BlogInterceptor bLogInterceptor() {
        return new BlogInterceptor();
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(bLogInterceptor()).addPathPatterns("/**");
    }
}
