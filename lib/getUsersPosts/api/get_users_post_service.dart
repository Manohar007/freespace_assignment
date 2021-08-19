import 'package:amplify_flutter_clean_framework/service/amplify_service.dart';
import 'package:amplify_flutter_clean_framework/service/rest_api.dart';
import 'package:freespace_assignment/getUsers/api/get_user_response_model.dart';


class GetUsersPostService extends AmplifyService
{
  final String url;
  final AmplifyServiceResponseHandler handler;
  GetUsersPostService({required this.url,required this.handler}) : super(url: url,action: HttpAction.get,handler: handler);

  @override
  UsersDataResponseModel parseJson(Map<String, dynamic> map) {
    return UsersDataResponseModel.fromJson(map);
  }
}