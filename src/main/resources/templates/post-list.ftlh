<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
  <link rel="stylesheet" href="/style.css">
  <title>${pageTitle}</title>
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
  <div class="container" style="margin: 20px;">
    <div>
      <form action="/posts/search" method="get" class="d-flex mb-3">
        <input class="form-control me-2" type="search" name="query" placeholder="Search by title or content"
          aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
    <h1>${pageTitle}</h1>
    <div class="row  row-cols-3">
      <#list postsList as post>
        <div class="col mb-4">
          <div class="card h-100">
            <img src="/images/${(post.thumbnailUrl)!'default.jpg'}" class="card-img-top"
              alt="Thumbnail for ${post.id?c}">
            <div class="card-body">
              <h5 class="card-title">${post.title}</h5>
              <p class="card-text">${post.content}</p>
            </div>
            <a href="/posts/${post.id?c}" class="btn btn-primary">View Post</a>
          </div>
        </div>
      </#list>

    </div>
  </div>


  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
    crossorigin="anonymous"></script>
</body>

</html>