import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restquester/requester.dart';

/// This class is defining some basic request data which can be included in some scope
/// for example for api. There should be separate RequestScope for every REST Api you
/// connect to.
class RequestScope {
  ///Base url to which are added endpoint specific paths. example: 'https://api.github.com/'
  final String baseUrl;

  ///default content type for all requests
  final ContentType contentType;

  Map<String, String> _headers = {};

  ///Headers which should be added to all requests which use this scope
  Map<String, String> get headers => _headers;

  RequestScope(this.baseUrl, [this.contentType]);

  ///Base url and default content type
  RequestScope.newScope({
    @required String baseUrl,
    ContentType contentType
  })
      : this.baseUrl = baseUrl,
        this.contentType = contentType ?? ContentType.json;

  ///Allows adding headers for all requests using this scope
  RequestScope addHeader(String key, String value) {
    _headers[key] = value;
    return this;
  }

  ///Instantiate new RequestBuilder with this scope.
  RequestBuilder newRequestBuilder() {
    return RequestBuilder.withScope(this);
  }

}