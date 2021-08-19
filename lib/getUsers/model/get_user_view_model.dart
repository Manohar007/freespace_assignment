

import 'package:amplify_flutter_clean_framework/model.dart';

class GetUserViewModel extends ViewModel
{
  final List<UsersDataViewModel> listUsers;

  GetUserViewModel({required this.listUsers});

}


class UsersDataViewModel extends ViewModel
{
  final String userID;
  final String name;
  final String avatar;
  final List<UsersPostDataViewModel> postList;

  UsersDataViewModel({required this.userID, required this.name, required this.avatar, required this.postList});
}

class UsersPostDataViewModel extends ViewModel
{
  final String postID;
  final String author;
  final String title;
  final String body;

  UsersPostDataViewModel({required this.postID, required this.author, required this.title, required this.body});

}