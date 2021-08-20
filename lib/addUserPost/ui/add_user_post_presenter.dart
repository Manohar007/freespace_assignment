import 'package:amplify_flutter_clean_framework/ui/presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freespace_assignment/addUserPost/bloc/add_user_post_bloc.dart';
import 'package:freespace_assignment/addUserPost/model/add_post_view_model.dart';
import 'package:freespace_assignment/addUserPost/ui/add_user_post_screen.dart';


class AddUserPostPresenter extends Presenter<AddUserPostBloc,AddPostViewModel>
{

  @override
  Widget buildLoadingScreen(BuildContext context) {
    return Center(child: CircularProgressIndicator(),);
  }

  @override
  Widget buildScreen(BuildContext context, AddUserPostBloc bloc, AddPostViewModel viewModel) {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      if(viewModel.isPostAdded!=null)
        {
          Widget okButton = TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );

          AlertDialog alert = AlertDialog(
            title: Text("Add post"),
            content: Text(viewModel.isPostAdded!?"Post Added Successfully":"Post Failed"),
            actions: [
              okButton,
            ],
          );
            showDialog(context: context, builder: (context)=>alert);
        }
    });

    return AddPostUserScreen(onButtonClicked: (map){
      bloc.onButtonClicked.send(map);
    },);
  }

  @override
  Stream<AddPostViewModel?> getViewModelStream(BuildContext context, AddUserPostBloc bloc) {
    return bloc.sendViewModel.receive;
  }

  @override
  void sendViewModelRequest(BuildContext context, AddUserPostBloc bloc) {
    bloc.onLaunch.launch();
  }

}