import 'package:amplify_flutter_clean_framework/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freespace_assignment/getUsers/bloc/get_user_bloc.dart';
import 'package:freespace_assignment/getUsers/ui/get_users_presenter.dart';

class GetUsersFeature extends StatelessWidget {
  const GetUsersFeature({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: BlocProvider(child: GetUsersPresenter(), bloc: GetUserBloc()),
    );
  }
}
