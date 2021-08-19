import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../Log.dart';
import 'base_api.dart';
import 'options.dart';
import 'response.dart';
import 'rest_api.dart';
import 'rest_api_error.dart';

@immutable
abstract class ResponseModel {
  ResponseModel.fromJson(Map<String, dynamic> json);

  String toString();
}

@immutable
abstract class RequestModel {
  dynamic toJson();

  String toString();
}

abstract class AmplifyService<T, U extends AmplifyServiceResponseHandler> {
  final String url;
  final HttpAction action;
  final U handler;
  final Options? options;
  RestAPI? restApi;

  AmplifyService(
      {required this.url,
      required this.action,
      required this.handler,
      this.restApi,
      this.options})
      : assert(url.isNotEmpty){
    restApi ??= BaseAPI();
  }

  Future<T?> request({RequestModel? data}) async {
    var jsonData;
    try {
      jsonData = data?.toJson();
    } on Error catch (e) {
      Log.e("Amplify Invalid Request", e.toString());
      handler.onInvalidRequest(e);
      return null;
    }
    Log.d("Amplify Service Request - $url", jsonData.toString());

    Response? response;

    try {
      switch (action) {
        case HttpAction.get:
          response = await restApi?.get(url, data: jsonData, options: options);

          break;
        case HttpAction.post:
          response = await restApi?.post(url, data: jsonData, options: options);
          break;
        case HttpAction.put:
          response = await restApi?.put(url, data: jsonData, options: options);
          break;
        case HttpAction.delete:
          response =
          await restApi?.delete(url, data: jsonData, options: options);
          break;
        default:
          throw 'Service not implemented';
      }
    } on RestServiceAPIError catch (e) {
      Log.e("Amplify ServerError - $url", e.response.toString());
      if (!serviceErrorHandler(e.response, handler)) handler.onServerError();
      return null;
    }

    if (response != null && response.isSuccessful()) {
      try {
        if (!(response.data is Map)) {
          Map<String, dynamic> map = {'data': response.data};
          Log.d("Amplify Service Response - $url", parseJson(map).toString());
          return parseJson(map);
        } else {
          var parsedResponse = parseJson(response.data);
          Log.d("Amplify Service Response - $url", response.toString());
          return parsedResponse;
        }
      } on Error catch (e) {
        Log.d("Amplify unexpected Error - $url", e.toString());
        handler.onUnexpectedContent(
            Exception(e.toString() + e.stackTrace.toString()));
      }
    } else if (response != null &&
        (response.statusCode == Response.HTTP_RESPONSE_CODE_UNAUTHORIZED ||
            response.statusCode == Response.HTTP_RESPONSE_CODE_FORBIDDEN)) {
      Log.e("Amplify Invalid Session - $url", response.toString());
      handler.onInvalidSession();
    } else {
      Log.e("Amplify Service Error - $url", response.toString());
      if (!serviceErrorHandler(response, handler)) handler.onServerError();
    }
    return null;
  }

  T parseJson(Map<String, dynamic> map);

  /// This method is meant to be overriden when the service includes a custom
  /// error handler. By default, that functionality is not required and a
  /// normal server error is generated.
  bool serviceErrorHandler(Response? response, U handler) {
    return false;
  }
}

enum ResponseHandlerResult {
  invalidRequest,
  unexpectedContent,
  serverError,
  invalidSession,
  onMaintenanceWindow,
  restApiError
}

abstract class AmplifyServiceResponseHandler {
  void onInvalidRequest(Error error);

  void onUnexpectedContent(Exception exception);

  void onServerError();

  void onInvalidSession();
}
