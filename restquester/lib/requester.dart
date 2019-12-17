import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restquester/scope.dart';

import 'headers.dart';

class RequestBuilder {
  String _path;
  HttpMethods _method;
  final HeaderBuilder _headerBuilder = HeaderBuilder();
  JSONMapper _mapper;
  dynamic _body;
  RequestScope _scope;

  ///Constructor which instantiates default RequestScope with provided data
  RequestBuilder(String baseUrl, {ContentType defaultContentType}) {
    _scope = RequestScope.newScope(
      baseUrl: baseUrl,
      contentType: defaultContentType,
    );
  }

  ///Constructor which uses specified RequestScope
  RequestBuilder.withScope(RequestScope scope)
      :_scope = scope;

  ///Sets up custom request
  RequestBuilder request({String path, HttpMethods method}) {
    _path = path;
    _method = method;
    return this;
  }

  ///Sets up get request
  RequestBuilder get(String path) {
    return request(path: path, method: HttpMethods.get);
  }

  ///Sets up post request
  RequestBuilder post(String path) {
    return request(path: path, method: HttpMethods.post);
  }

  ///Sets up delete request
  RequestBuilder delete(String path) {
    return request(path: path, method: HttpMethods.delete);
  }

  ///Sets up put request
  RequestBuilder put(String path) {
    return request(path: path, method: HttpMethods.put);
  }

  ///Sets up patch request
  RequestBuilder patch(String path) {
    return request(path: path, method: HttpMethods.patch);
  }

  ///Sets bearer authorization for request
  RequestBuilder withBearerAuthorization(String accessToken) {
    _headerBuilder.withBearerAuthorization(accessToken);
    return this;
  }

  ///sets content type of request
  RequestBuilder withContentType(ContentType contentType) {
    _headerBuilder.withContentType(contentType);
    return this;
  }

  ///adds header to request
  RequestBuilder withHeader(String key, String value) {
    _headerBuilder.withHeader(key, value);
    return this;
  }

  ///Sets mapper
  ///Mapper is taking Map of json values and instantiates data model which will
  ///be returned by request
  RequestBuilder withMapper(JSONMapper mapper) {
    _mapper = mapper;
    return this;
  }

  ///Sets request body
  RequestBuilder withBody(dynamic body) {
    _body = body;
    return this;
  }

  ///Sends request and return Future with value mapped with `JSONMapper`
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
    assert(_scope.baseUrl != null);
    assert(_path != null);
    assert(_method != null);
    final url = _buildUrl(_path);
    final headers = _headerBuilder
        .withHeaders(_scope.headers)
        .build();
    headers.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => _scope.contentType.value);
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
    assert(_scope.baseUrl != null);
    assert(_scope.baseUrl.endsWith('/'));
    return "${_scope.baseUrl}$path";
  }
}

typedef T JSONMapper<T>(Map jsonMap);

enum HttpMethods { get, post, delete, put, patch }
