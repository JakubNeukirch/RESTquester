import 'dart:io';

class HeaderBuilder {
  Map<String, String> _headers = {};

  Map<String, String> get headers => _headers;

  HeaderBuilder withBearerAuthorization(String accessToken) {
    _headers[HttpHeaders.authorizationHeader] = "Bearer $accessToken";
    return this;
  }

  HeaderBuilder withContentType(ContentType contentType) {
    _headers[HttpHeaders.contentTypeHeader] = contentType.value;
    return this;
  }

  HeaderBuilder withHeader(String key, String value) {
    _headers[key] = value;
    return this;
  }

  HeaderBuilder withHeaders(Map<String, String> headers) {
    _headers.addAll(headers);
    return this;
  }

  Map<String, String> build() {
    return _headers;
  }
}
