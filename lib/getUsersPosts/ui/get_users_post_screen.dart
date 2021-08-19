import 'package:flutter/material.dart';
import 'package:freespace_assignment/getUsers/model/get_user_view_model.dart';

class GetUsersPostScreen extends StatelessWidget {
  final UsersDataViewModel getUserPostViewModel;
  final Function(int) onTapUserPost;
  final VoidCallback onTapAddPost;
  GetUsersPostScreen(
      {Key? key,
      required this.getUserPostViewModel,
      required this.onTapAddPost,
      required this.onTapUserPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) =>
            _getItemView(getUserPostViewModel.postList[index], index),
        itemCount: getUserPostViewModel.postList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onTapAddPost();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black54,
      ),
    );
  }

  Widget _getItemView(UsersPostDataViewModel dataViewModel, int index) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Card(
        elevation: 3,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                _allWordsCapitalize(dataViewModel.title),
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            ),
            Container(
              child: Text(
                dataViewModel.body,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
            )
          ],
        ),
      ),
      onTap: () {
        onTapUserPost(index);
      },
    );
  }

  String _allWordsCapitalize(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }
}
