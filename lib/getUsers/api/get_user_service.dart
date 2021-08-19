

import 'package:amplify_flutter_clean_framework/service/amplify_service.dart';
import 'package:amplify_flutter_clean_framework/service/rest_api.dart';

import 'get_user_response_model.dart';

class GetUserService extends AmplifyService
{
  final String url;
  final AmplifyServiceResponseHandler handler;
  GetUserService({required this.url,required this.handler}) : super(url: url,action: HttpAction.get,handler: handler);

  @override
  GetUserResponseModel parseJson(Map<String, dynamic> map) {
    return GetUserResponseModel.fromJson(map);
  }
}

// class GetUserServiceRequestModel extends RequestModel
// {
//   final
//   @override
//   toJson() {
//     // TODO: implement toJson
//     throw UnimplementedError();
//   }
//
// }


