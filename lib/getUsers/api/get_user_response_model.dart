

import 'package:amplify_flutter_clean_framework/service/amplify_service.dart';

class GetUserResponseModel extends ResponseModel
{
  final List<UsersDataResponseModel> userList;
  GetUserResponseModel.fromJson(Map<String, dynamic> json) :
        userList=List<UsersDataResponseModel>.from(json["data"].map((x)=>UsersDataResponseModel.fromJson(x))),
        super.fromJson(json);

}



class UsersDataResponseModel extends ResponseModel
{
  final String userID;
  final String name;
  final String avatar;
  final List<UsersPostDataResponseModel> postList;
  UsersDataResponseModel.fromJson(Map<String, dynamic> json) :
        userID=json["id"],
        name=json["name"],
        avatar=json["avatar"],
        postList=List<UsersPostDataResponseModel>.from(json["posts"].map((x)=>UsersPostDataResponseModel.fromJson(x))),
        super.fromJson(json);
}

class UsersPostDataResponseModel extends ResponseModel
{
  final String postID;
  final String author;
  final String title;
  final String body;

  UsersPostDataResponseModel.fromJson(Map<String, dynamic> json) :
        postID=json["id"],
        author=json["author"],
        title=json["title"],
        body=json["body"],
        super.fromJson(json);

}


