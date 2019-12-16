import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'headers.dart';

class RequestBuilder {
  static String baseUrl;
  static ContentType defaultContentType = ContentType.json;
  final String _path;
  final HttpMethods _method;
  final HeaderBuilder _headerBuilder = HeaderBuilder();
  JSONMapper _mapper;
  dynamic _body;

  RequestBuilder({String path, HttpMethods method})
      : _path = path,
        _method = method;

  RequestBuilder.get(this._path) : _method = HttpMethods.get;

  RequestBuilder.post(this._path) : _method = HttpMethods.post;

  RequestBuilder.delete(this._path) : _method = HttpMethods.delete;

  RequestBuilder.put(this._path) : _method = HttpMethods.put;

  RequestBuilder.patch(this._path) : _method = HttpMethods.patch;

  RequestBuilder withBearerAuthorization(String accessToken) {
    _headerBuilder.withBearerAuthorization(accessToken);
    return this;
  }

  RequestBuilder withContentType(ContentType contentType) {
    _headerBuilder.withContentType(contentType);
    return this;
  }

  RequestBuilder withHeader(String key, String value) {
    _headerBuilder.withHeader(key, value);
    return this;
  }

  RequestBuilder withMapper(JSONMapper mapper) {
    _mapper = mapper;
    return this;
  }

  RequestBuilder withBody(dynamic body) {
    _body = body;
    return this;
  }

  Future<dynamic> execute() {
    return _sendRequest()
        .then((response) => jsonDecode(response.body))
        .then((data) => _map(data));
  }

  dynamic _map(dynamic data) {
    if (_mapper == null) {
      return null;
    } else {
      return _mapper(data);
    }
  }

  Future<dynamic> _sendRequest() {
    assert(_method != null);
    final url = _buildUrl(_path);
    final headers = _headerBuilder.build();
    headers.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => defaultContentType.value);
    switch (_method) {
      case HttpMethods.get:
        return http.get(
          url,
          headers: headers,
        );
      case HttpMethods.post:
        return http.post(
          url,
          headers: headers,
          body: _getBody(),
        );
      case HttpMethods.delete:
        return http.delete(
          url,
          headers: headers,
        );
      case HttpMethods.put:
        return http.put(
          url,
          headers: headers,
          body: _getBody(),
        );
      case HttpMethods.patch:
        return http.patch(
          url,
          headers: headers,
          body: _getBody(),
        );
      default:
        return Future.error(
          UnimplementedError("Method $_method is not implemented"),
        );
    }
  }

  dynamic _getBody() {
    assert(_body != null);
    return jsonEncode(_body);
  }

  String _buildUrl(String path) {
    assert(baseUrl != null);
    assert(baseUrl.endsWith('/'));
    return "$baseUrl$path";
  }
}

typedef T JSONMapper<T>(Map jsonMap);

enum HttpMethods { get, post, delete, put, patch }
