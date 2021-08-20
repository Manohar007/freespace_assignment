import 'package:amplify_flutter_clean_framework/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freespace_assignment/addUserPost/bloc/add_user_post_bloc.dart';
import 'package:freespace_assignment/addUserPost/ui/add_user_post_presenter.dart';

class AddUserPostFeature extends StatelessWidget {
  final String userId;
  const AddUserPostFeature({Key? key,required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post"),),
      body: BlocProvider(child: AddUserPostPresenter(), bloc: AddUserPostBloc(userId: userId)),
    );
  }
}
