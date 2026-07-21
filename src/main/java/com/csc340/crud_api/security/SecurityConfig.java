package com.csc340.crud_api.security;

import org.springframework.boot.security.autoconfigure.web.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;

import jakarta.servlet.DispatcherType;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

  private final CustomUserDetailsService userDetailsService;

  public SecurityConfig(CustomUserDetailsService userDetailsService) {
    this.userDetailsService = userDetailsService;
  }

  @Bean
  public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    HttpSessionRequestCache requestCache = new HttpSessionRequestCache();
    requestCache.setMatchingRequestParameterName(null);
    http
        .csrf(AbstractHttpConfigurer::disable)
        .authorizeHttpRequests((authorize) -> authorize
            .dispatcherTypeMatchers(DispatcherType.FORWARD,
                DispatcherType.ERROR)
            .permitAll()
            // api endpoints
            .requestMatchers(HttpMethod.GET, "/api/posts/**").permitAll()
            .requestMatchers(HttpMethod.POST, "/api/posts").hasAnyAuthority("ROLE_ADMIN", "ROLE_WRITER")
            .requestMatchers(HttpMethod.PUT, "/api/posts").hasAnyAuthority("ROLE_ADMIN", "ROLE_WRITER")
            .requestMatchers(HttpMethod.DELETE, "/api/posts/**").hasAuthority("ROLE_ADMIN")
            // UI endpoints
            .requestMatchers(PathRequest.toStaticResources().atCommonLocations()).permitAll()
            .requestMatchers("/static/**", "/style.css", "/**/*.css", "/*.jpg", "/*.png", "/*.gif").permitAll()
            .requestMatchers("/", "/signup").permitAll()
            .requestMatchers("/posts/new", "/posts/save", "/posts/update/**")
            .hasAnyAuthority("ROLE_ADMIN", "ROLE_WRITER")
            .requestMatchers("/posts/delete/**").hasAuthority("ROLE_ADMIN")
            .anyRequest().authenticated())
        .formLogin(form -> form
            .loginPage("/login").permitAll()
            .defaultSuccessUrl("/posts"))
        .exceptionHandling((x) -> x.accessDeniedPage("/403"))
        .logout(Customizer.withDefaults())
        .requestCache((cache) -> cache
            .requestCache(requestCache));

    return http.build();
  }

  protected void configure(AuthenticationManagerBuilder auth) throws Exception {
    auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
  }

  @Bean
  public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
  }

}
