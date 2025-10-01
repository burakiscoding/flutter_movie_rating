enum HttpMethod { get, post, put, patch, delete }

extension HttpMethodX on HttpMethod {
  String get name => switch (this) {
    HttpMethod.get => 'GET',
    HttpMethod.post => 'POST',
    HttpMethod.put => 'PUT',
    HttpMethod.patch => 'PATCH',
    HttpMethod.delete => 'DELETE',
  };
}
