package org.santam.screening;

import org.santam.screening.security.CustomPasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestMvcConfiguration;
import org.springframework.data.web.config.EnableSpringDataWebSupport;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.authentication.dao.ReflectionSaltSource;
import org.springframework.security.config.annotation.ObjectPostProcessor;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configurers.GlobalAuthenticationConfigurerAdapter;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.handler.SimpleUrlHandlerMapping;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Properties;

@Configuration
@ComponentScan
@EnableAutoConfiguration
public class Application extends SpringBootServletInitializer {
    public static void main(String[] args){
        SpringApplication.run(Application.class, args);
    }

    public static final String API_ROOT = "/api";

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class);
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

        @Autowired
        private CustomPasswordEncoder passwordEncoder;

        @Override
        public void init(AuthenticationManagerBuilder auth) throws Exception {

            auth
                .userDetailsService(usersDetailsService)
                .passwordEncoder(passwordEncoder)
                .withObjectPostProcessor(new ObjectPostProcessor<DaoAuthenticationProvider>() {

                    @Override
                    public DaoAuthenticationProvider postProcess(DaoAuthenticationProvider dap) {
                        ReflectionSaltSource rss = new ReflectionSaltSource();
                        rss.setUserPropertyToUse("salt");
                        dap.setSaltSource(rss);
                        return dap;
                    }
                });
        }
    }

    @Order(SecurityProperties.ACCESS_OVERRIDE_ORDER)
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
    protected static class RestMvcConfiguration extends RepositoryRestMvcConfiguration {
        @Override
        protected void configureRepositoryRestConfiguration(RepositoryRestConfiguration config) {
            super.configureRepositoryRestConfiguration(config);
            try {
                config.setBaseUri(new URI(API_ROOT));
            } catch (URISyntaxException e) {
                e.printStackTrace();
            }
        }
    }

    @Configuration
    @EnableJpaRepositories
    @EnableSpringDataWebSupport
    protected static class WebMvcConfiguration extends WebMvcConfigurerAdapter {
        @Override
        public void addViewControllers(ViewControllerRegistry registry)
        {
            super.addViewControllers(registry);
            registry.addViewController("/login").setViewName("login");
        }
    }
}
