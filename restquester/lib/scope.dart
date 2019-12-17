import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restquester/requester.dart';

class RequestScope {
  final String baseUrl;
  final ContentType contentType;
  Map<String, String> _headers = {};

  Map<String, String> get headers => _headers;

  RequestScope(this.baseUrl, [this.contentType]);

  RequestScope.newScope({
    @required String baseUrl,
    ContentType contentType
  })
      : this.baseUrl = baseUrl,
        this.contentType = contentType ?? ContentType.json;

  RequestScope addHeader(String key, String value) {
    _headers[key] = value;
    return this;
  }

  RequestBuilder newRequestBuilder() {
    return RequestBuilder.withScope(this);
  }

}