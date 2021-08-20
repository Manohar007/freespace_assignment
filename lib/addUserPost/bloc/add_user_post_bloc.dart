

import 'package:amplify_flutter_clean_framework/bloc/bloc.dart';
import 'package:freespace_assignment/addUserPost/api/add_user_post_service.dart';
import 'package:freespace_assignment/addUserPost/model/add_post_businees_model.dart';
import 'package:freespace_assignment/addUserPost/model/add_post_view_model.dart';
import 'package:freespace_assignment/getUsers/bloc/get_user_bloc.dart';

class AddUserPostBloc extends Bloc
{
  final String userId;
  EventPipe onLaunch=EventPipe();
  BroadcastPipe<AddPostViewModel> sendViewModel=BroadcastPipe();
  BroadcastPipe<Map> onButtonClicked=BroadcastPipe();
  late AddPostBusinessModel businessModel;
  late AddUserPostService addUserPostService;
  late ResponseHandler responseHandler;
  AddUserPostBloc({required this.userId}){
    businessModel=AddPostBusinessModel();
    responseHandler=ResponseHandler();
    addUserPostService=AddUserPostService(url: "https://609b59ee2b549f00176e34df.mockapi.io/api/users/$userId/posts",handler: responseHandler);
    onLaunch.listen(_onLaunch);
    onButtonClicked.receive.listen(_onButtonClick);
  }

  void _onLaunch() {
    sendViewModel.send(AddPostViewModel(isPostAdded: businessModel.isPostAdded));
  }

  void _onButtonClick(Map map)async
  {
    AddUserPostServiceRequestModel requestModel=AddUserPostServiceRequestModel(title: map["title"],body: map["body"]);
    bool? result=await addUserPostService.request(data: requestModel);
    if(result!=null)
    businessModel.isPostAdded=result;
    else
    businessModel.isPostAdded=false;
    _onLaunch();
  }
}