import 'package:avatar_view/avatar_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freespace_assignment/getUsers/model/get_user_view_model.dart';


class GetUserScreen extends StatelessWidget {
  final GetUserViewModel getUserViewModel;
  final Function(int) onTapUser;
  GetUserScreen({Key? key,required this.getUserViewModel,required this.onTapUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context,index)=>
      _getItemView(getUserViewModel.listUsers[index],index),
      itemCount: getUserViewModel.listUsers.length,
      ),
    );
  }

  Widget _getItemView(UsersDataViewModel dataViewModel,int index)
  {
    return ListTile(leading: AvatarView(
      radius: 20,
      borderColor: Colors.grey,
      isOnlyText: false,
      text: Text('C', style: TextStyle(color: Colors.white, fontSize: 10),),
      avatarType: AvatarType.CIRCLE,
      backgroundColor: Colors.red,
      imagePath:dataViewModel.avatar,
      placeHolder: Container(
        child: Icon(Icons.person_rounded, color: Colors.black,),
      ),
      errorWidget: Container(
        child: Container(decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color:Colors.grey)
        ),
        child: Icon(Icons.person_rounded,color: Colors.black,),),
      ),
    ),
    title: Text(dataViewModel.name),
    onTap: onTapUser(index),
    );
  }
}
