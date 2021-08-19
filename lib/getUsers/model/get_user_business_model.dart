
import 'package:amplify_flutter_clean_framework/model.dart';
import 'package:freespace_assignment/getUsers/api/get_user_response_model.dart';

class GetUserBusinessModel extends BusinessModel
{
   List<UsersDataBusinessModel> listUsers=[];

  void updateBusinessModel(GetUserResponseModel responseModel)
  {
    responseModel.userList.forEach((element) {
      UsersDataBusinessModel usersDataBusinessModel=_getUserData(element);
      listUsers.add(usersDataBusinessModel);
    });

  }


  void updateSingleUserPost(UsersDataResponseModel element)
  {
    listUsers.add(_getUserData(element));
  }


  UsersDataBusinessModel _getUserData(UsersDataResponseModel element)
  {
    return UsersDataBusinessModel(
        userID: element.userID,
        avatar: element.avatar,
        name: element.name,
        postList: List<UsersPostDataBusinessModel>.from(element.postList.map((e) => UsersPostDataBusinessModel(
            title: e.title,
            author: e.author,
            body: e.body,
            postID: e.postID
        )))
    );
  }

}


class UsersDataBusinessModel extends BusinessModel
{
  String userID;
  String name;
  String avatar;
  List<UsersPostDataBusinessModel> postList;

  UsersDataBusinessModel({required this.userID, required this.name, required this.avatar, required this.postList});
}

class UsersPostDataBusinessModel extends BusinessModel
{
  String postID;
  String author;
  String title;
  String body;

  UsersPostDataBusinessModel({required this.postID, required this.author, required this.title, required this.body});

}