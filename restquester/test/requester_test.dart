// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:restquester/requester.dart';
import 'package:restquester/scope.dart';

import 'model.dart';

void main() {
  RequestScope scope;
  test('Test request', () async {
    scope = RequestScope
        .newScope(baseUrl: 'https://api.github.com/');
    Response response = await scope
        .newRequestBuilder()
        .get('orgs/octokit')
        .withMapper((map) => Response.fromJson(map))
        .withLoggingType(LoggingType.all)
        .execute();
    print("${response.login}");
    assert(response != null);
  });
  test('Test request2', () async {
    var response = await scope
        .newRequestBuilder()
        .get('orgs/octokit/repos')
        .withMapper((list) => list, isList: true)
        .execute();
    print("${response}");
    assert(response != null);
  });
  test('Test request3', () async {
    var response = await scope
        .newRequestBuilder()
        .get('orgs/octokit/repos')
        .execute();
    print("${response}");
    assert(response != null);
  });
}