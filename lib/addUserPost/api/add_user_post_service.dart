import 'package:amplify_flutter_clean_framework/service/amplify_service.dart';
import 'package:amplify_flutter_clean_framework/service/rest_api.dart';
import 'package:freespace_assignment/getUsers/bloc/get_user_bloc.dart';

class AddUserPostService extends AmplifyService {
  final String url;
  final ResponseHandler handler;
  AddUserPostService({required this.url, required this.handler})
      : super(url: url, handler: handler, action: HttpAction.post);

  @override
  bool parseJson(Map<String, dynamic> map) {
    return true;
  }
}

class AddUserPostServiceRequestModel extends RequestModel {
  final String title;
  final String body;

  AddUserPostServiceRequestModel({required this.title, required this.body});

  @override
  toJson() {
    return {"title": title, "body": body};
  }
}
