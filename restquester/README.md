# restquester

Package simplifying rest requests

## Usage

Example for sending post request
```dart
  import 'package:restquester/requester.dart';

  //create scope for localhost api
  RequestScope scope = RequestScope
        .newScope(baseUrl: 'https://localhost:8080/');
  //Instantiating request body for request
  final LoginBody body = LoginBody(
    login: "admin",
    password: "admin",
    clientId:
    "d524c1a0811dt35692f841085cc0063eb62b902735a94542795d1ca9824a941",
  );
  //Instantiating RequestBuilder for specified method and post
  final Response response = await scope
      .newRequestBuilder()
      .post('authorize')
      //setting mapper which will convert json map into specific data model
      .withMapper((map) => Response.fromJson(map))
      //set request body to be sent in request
      //body should have `toJson` method which returns map of data
      .withBody(body)
      //returns Future with converted data model
      .execute();
```

Example request body model
```dart
class LoginBody {
  String login;
  String password;
  String clientId;

  LoginBody({this.login, this.password, this.clientId});

  LoginBody.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    password = json['password'];
    clientId = json['clientId'];
  }

  //needed to be converted to json inside RequestBuilder
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['password'] = this.password;
    data['clientId'] = this.clientId;
    return data;
  }
}
```