# su26-crud-api-demo - with Spring Security

## This should be the last thing that you add to your project, after everything is working (all your endpoints and views).

## Notes:
- This repository includes a dependency to [Spring Security](https://github.com/csc340-uncg/su26-crud-api-demo/blob/8f7f793bd84d174d98703b8e90a8a742a1acc903/pom.xml#L46). This is how it handles authentication and authorization.
     - When you start at Spring Initializr and add a dependency to Spring Security, this will also add a FreeMarker dependency for Security as well.
     - The rest of the dependencies should already look familiar: Spring Web, FreeMarker, JPA, MySQL.
     - Remember to have your database up and running before you build your project. Double check that your application properties call for a database that you have in Neon.
- Once the security dependency is included, Security must be configured. The following are the elements needed for that:
     -   A User service class [CustomUserDetailsService](https://github.com/csc340-uncg/su26-crud-api-demo/blob/8f7f793bd84d174d98703b8e90a8a742a1acc903/src/main/java/com/csc340/crud_api/security/CustomUserDetailsService.java#L15)
         - It implements UserDetailsService. This will make it possible to use the connection to the database to access our saved users using their usernames and passwords. In the User repo, we implement a [method](https://github.com/csc340-uncg/su26-crud-api-demo/blob/8f7f793bd84d174d98703b8e90a8a742a1acc903/src/main/java/com/csc340/crud_api/users/UserRepository.java#L8) for finding a user by username.
         - After fetching the user from the database, we build a "security" User object using the username, password, and authorities. For this setup, we get the authority from their "role" attribute in the database.

  -  A Security configuration class - [Security Config](https://github.com/csc340-uncg/su26-crud-api-demo/blob/8f7f793bd84d174d98703b8e90a8a742a1acc903/src/main/java/com/csc340/crud_api/security/SecurityConfig.java#L21)
      -   Annotated with `@Configuration` and `@EnableWebSecurity`
      -   A [filter chain](https://github.com/csc340-uncg/su26-crud-api-demo/blob/8f7f793bd84d174d98703b8e90a8a742a1acc903/src/main/java/com/csc340/crud_api/security/SecurityConfig.java#L30). This is where the rules for authorization are configured. For this example, all requests that edit or remove a Post are only allowed for people who have the ADMIN or WRITER authorization. Some resources that are explicitly secured.
      -   Accessing `/` or `/signup` is permitted for anyone even without signing in.
      -   Any other requests must be authenticated, meaning everyone needs to login before they can do anything on the app.
      -   There are other rules for authorization [here](https://docs.spring.io/spring-security/reference/servlet/authorization/authorize-http-requests.html#authorize-requests)
      -   Provide a login configuration. This can either be [default or customized](https://docs.spring.io/spring-security/reference/servlet/authentication/passwords/form.html#servlet-authentication-form-custom).
      -   Add an [exception handler](https://docs.spring.io/spring-security/reference/servlet/authentication/passwords/form.html). If a request is not authorized based on the rules defined above, the app will send a GET request to /403. You can customize this whatever you want but you MUST have the endpoint mapped in some controller.
      -   Login is also permitted for everyone.
      -   Configure an authentication manager. We are using the BCryptPasswordEncoder from Spring Security, and the previously mentioned CustomUserDetailsService to enforce the above rules for any user who logs in.
      -   Note that when we create Users ([UserService ](https://github.com/csc340-uncg/su26-crud-api-demo/blob/8f7f793bd84d174d98703b8e90a8a742a1acc903/src/main/java/com/csc340/crud_api/users/UserService.java#L24)), we employ this same password encoder, that way passwords are never stored in plain text. However, we need to create the [Bean](https://github.com/csc340-uncg/su26-crud-api-demo/blob/8f7f793bd84d174d98703b8e90a8a742a1acc903/src/main/java/com/csc340/crud_api/security/SecurityConfig.java#L68) in SecurityConfig before we can inject it in the Service. Very straight forward, I know.
