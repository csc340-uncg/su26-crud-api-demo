<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
  <link rel="stylesheet" href="/style.css">
  <title>Demo CRUD App</title>
</head>

<body>
  <nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
      <a class="navbar-brand" href="/posts" style="margin: 10px;">
        <img src="/images/logo.jpg" alt="" width="80" height="60">
      </a>
      <a class="navbar-brand" href="/posts">CRUD API Demo</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="/posts">Posts</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/posts/new">Create Post</a>
          </li>
          <#if Session.SPRING_SECURITY_CONTEXT??>
            <li class="nav-item">
              <a class="nav-link" href="/logout">(${Session.SPRING_SECURITY_CONTEXT.authentication.name}) Sign Out</a>
            </li>
          </#if>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container text-center mt-5">
    <h1>Welcome to the CRUD API Demo Application!</h1>
    <p>This application allows you to create, read, update, and delete blog posts.</p>
    <a href="/posts" class="btn btn-primary mt-3">View Posts (MVC)</a>
    <a href="/api/posts" class="btn btn-secondary mt-3">View Posts (API)</a>
    <h3> Other API Endpoints </h3>
    <ul class="list-unstyled">
      <li><a href="/api/posts" class="btn btn-link">GET /api/posts</a></li>
      <li><a href="/api/posts/1" class="btn btn-link">GET /api/posts/{id}</a></li>
      <li><a href="/api/posts/search?query=example" class="btn btn-link">GET /api/posts/search?query=example</a></li>
      <li><a href="/api/posts/author?name=Wi" class="btn btn-link">GET /api/posts/author?name=Wi</a></li>
      <li>POST /api/posts</li>
      <li>PUT /api/posts/{id}</li>
      <li>DELETE /api/posts/{id}</li>
    </ul>
  </div>
</body>

</html>