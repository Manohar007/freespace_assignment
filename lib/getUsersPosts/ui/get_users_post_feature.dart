import 'package:amplify_flutter_clean_framework/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freespace_assignment/getUsersPosts/bloc/get_users_post_bloc.dart';
import 'package:freespace_assignment/getUsersPosts/ui/get_users_post_presenter.dart';

class GetUsersPostFeature extends StatelessWidget {
  final String userId;
  const GetUsersPostFeature({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Posts"),
      ),
      body: BlocProvider(
          child: GetUsersPostPresenter(),
          bloc: GetUsersPostBloc(userId: userId)),
    );
  }
}
