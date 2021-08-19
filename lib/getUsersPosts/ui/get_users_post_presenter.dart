import 'package:flutter/material.dart';


import 'package:amplify_flutter_clean_framework/ui/presenter.dart';
import 'package:freespace_assignment/getUsers/model/get_user_view_model.dart';
import 'package:freespace_assignment/getUsersPosts/bloc/get_users_post_bloc.dart';

import 'get_users_post_screen.dart';

class GetUsersPostPresenter extends Presenter<GetUsersPostBloc,UsersDataViewModel>
{
  @override
  Widget buildScreen(BuildContext context, GetUsersPostBloc bloc, UsersDataViewModel viewModel) {
    return GetUsersPostScreen(getUserPostViewModel: viewModel,onTapUserPost: (index){},
    onTapAddPost: (){},);
  }

  @override
  Stream<UsersDataViewModel?> getViewModelStream(BuildContext context, GetUsersPostBloc bloc) {
    return bloc.sendViewModel.receive;
  }

  @override
  void sendViewModelRequest(BuildContext context, GetUsersPostBloc bloc) {
    bloc.onLaunch.launch();
  }

  @override
  Widget buildLoadingScreen(BuildContext context) {
    return Center(child: CircularProgressIndicator(),);
  }

}