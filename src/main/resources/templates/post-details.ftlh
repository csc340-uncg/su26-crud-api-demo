<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
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
    <h1>${pageTitle}</h1>
    <#if RequestParameters.success??>
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        Post updated successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    </#if>
    <#if RequestParameters.error??>
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        Error updating post!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    </#if>
    <div class="card" style="width: 50rem; margin: 20px;">
      <h1 class="card-header">${post.title}</h1>
      <img src="/images/${(post.thumbnailUrl)!'default.jpg'}" class="card-img-top" alt="Thumbnail for ${post.id?c}">
      <div class="card-body">
        <h5 class="card-title">${post.title}</h5>
        <p class="card-text">${post.content}</p>
        <figcaption class="blockquote-footer">
          <cite title="Source Title"> ${post.author} - ${post.createdAt}</cite>
        </figcaption>
      </div>
    </div>
    <hr>
    <div class="alert alert-primary" role="alert" style="margin-top: 10px;">Edit Post</div>
    <form action="/posts/update/${post.id?c}" method="post" enctype="multipart/form-data">
      <div>
        <label for="id" class="form-label">ID</label>
        <input type="text" class="form-control" name="id" value="${post.id?c}" readonly>
      </div>
      <div class="mb-3">
        <label for="title" class="form-label">Title</label>
        <input type="text" class="form-control" id="title" name="title" value="${post.title}" required>
      </div>
      <div class="mb-3">
        <label for="content" class="form-label">Content</label>
        <textarea class="form-control" id="content" name="content" rows="3">${post.content}</textarea>
      </div>
      <div class="mb-3">
        <label for="author" class="form-label">Author</label>
        <input type="text" class="form-control" id="author" name="author" value="${post.author}">
      </div>
      <div class="mb-3">
        <label for="thumbnailFile" class="form-label">Thumbnail Image (10MB max)</label>
        <input type="file" class="form-control" id="thumbnailFile" name="thumbnailFile">
      </div>
      <button type="submit" class="btn btn-primary">Submit</button>
    </form>
    <hr>
    <div class="alert alert-danger" role="alert">
      Delete Post
      <a style="float: right;" href="/posts/delete/${post.id?c}" class="btn btn-danger">Delete</a>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
    crossorigin="anonymous"></script>
</body>

</html>