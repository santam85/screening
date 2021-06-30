package org.santam.screening;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.core.convert.support.ConfigurableConversionService;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.core.event.ValidatingRepositoryEventListener;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.data.web.config.EnableSpringDataWebSupport;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configurers.GlobalAuthenticationConfigurerAdapter;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.mvc.method.annotation.ExceptionHandlerExceptionResolver;

import java.util.List;

@Configuration
@ComponentScan
@EnableAutoConfiguration
public class Application {
    public static final String API_ROOT = "/api";

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public ApplicationSecurity applicationSecurity() {
        return new ApplicationSecurity();
    }

    @Bean
    public AuthenticationSecurity authenticationSecurity() {
        return new AuthenticationSecurity();
    }

    @Order(Ordered.HIGHEST_PRECEDENCE)
    @Configuration
    protected static class AuthenticationSecurity extends GlobalAuthenticationConfigurerAdapter {

        @Autowired
        private UserDetailsService usersDetailsService;

        @Override
        public void init(AuthenticationManagerBuilder auth) throws Exception {
            auth.userDetailsService(usersDetailsService);
        }
    }

    @Order(SecurityProperties.BASIC_AUTH_ORDER)
    protected static class ApplicationSecurity extends WebSecurityConfigurerAdapter {
        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http.authorizeRequests()
                    .antMatchers("/resources/**").permitAll()
                    .antMatchers("/vendor/**").permitAll()
                    .antMatchers("/error").permitAll()
                    .anyRequest().authenticated()
                    .and()
                    .formLogin()
                    .loginPage("/login").permitAll()
                    .and()
                    .logout().permitAll();
        }
    }

    @Configuration
    protected static class RestMvcConfiguration implements RepositoryRestConfigurer {
        @Override
        public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config) {
            config.setBasePath(API_ROOT);
        }

        @Override
        public void configureConversionService(ConfigurableConversionService configurableConversionService) {

        }

        @Override
        public void configureValidatingRepositoryEventListener(ValidatingRepositoryEventListener validatingRepositoryEventListener) {

        }

        @Override
        public void configureExceptionHandlerExceptionResolver(ExceptionHandlerExceptionResolver exceptionHandlerExceptionResolver) {

        }

        @Override
        public void configureHttpMessageConverters(List<HttpMessageConverter<?>> list) {

        }

        @Override
        public void configureJacksonObjectMapper(ObjectMapper objectMapper) {

        }
    }

    @Configuration
    @EnableJpaRepositories
    @EnableSpringDataWebSupport
    protected static class WebMvcConfiguration extends WebMvcConfigurerAdapter {
        @Override
        public void addViewControllers(ViewControllerRegistry registry) {
            super.addViewControllers(registry);
            registry.addViewController("/login").setViewName("login");
        }
    }
}
