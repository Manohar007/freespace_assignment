import 'package:flutter/material.dart';
import 'package:amplify_flutter_clean_framework/ui/presenter.dart';
import 'package:freespace_assignment/getUsers/bloc/get_user_bloc.dart';
import 'package:freespace_assignment/getUsers/model/get_user_view_model.dart';
import 'package:freespace_assignment/getUsers/ui/get_users_screen.dart';
import 'package:freespace_assignment/getUsersPosts/ui/get_users_post_feature.dart';

class GetUsersPresenter extends Presenter<GetUserBloc, GetUserViewModel> {
  @override
  Widget buildScreen(
      BuildContext context, GetUserBloc bloc, GetUserViewModel viewModel) {
    return GetUserScreen(
        getUserViewModel: viewModel,
        onTapUser: (int index) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GetUsersPostFeature(
                    userId: viewModel.listUsers[index].userID,
                  )));
        });
  }

  @override
  Stream<GetUserViewModel?> getViewModelStream(
      BuildContext context, GetUserBloc bloc) {
    return bloc.sendViewModel.receive;
  }

  @override
  Widget buildLoadingScreen(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: Colors.blueAccent,
    ));
  }

  @override
  void sendViewModelRequest(BuildContext context, GetUserBloc bloc) {
    bloc.onLaunch.launch();
  }
}
