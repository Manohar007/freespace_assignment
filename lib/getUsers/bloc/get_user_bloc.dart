

import 'package:amplify_flutter_clean_framework/bloc/bloc.dart';
import 'package:amplify_flutter_clean_framework/service/amplify_service.dart';
import 'package:freespace_assignment/getUsers/api/get_user_response_model.dart';
import 'package:freespace_assignment/getUsers/api/get_user_service.dart';
import 'package:freespace_assignment/getUsers/model/get_user_business_model.dart';
import 'package:freespace_assignment/getUsers/model/get_user_view_model.dart';

class GetUserBloc extends Bloc
{
  EventPipe onLaunch=EventPipe();
  BroadcastPipe<GetUserViewModel> sendViewModel=BroadcastPipe();
  late GetUserService _getUserService;
  late ResponseHandler responseHandler;
  late GetUserBusinessModel businessModel;
  GetUserBloc(){
    onLaunch.listen(_getUser);
    businessModel=GetUserBusinessModel();
    responseHandler=ResponseHandler();
    _getUserService=GetUserService(url: "https://609b59ee2b549f00176e34df.mockapi.io/api/users", handler: responseHandler);
  }

  void _getUser() async{
    GetUserResponseModel responseModel= await _getUserService.request();
    businessModel.updateBusinessModel(responseModel);
    sendViewModel.send(_createViewModel());
  }

  GetUserViewModel _createViewModel()
  {
    return GetUserViewModel(listUsers: List<UsersDataViewModel>.from(businessModel.listUsers.map((element) => UsersDataViewModel(
      name: element.name,
      avatar: element.avatar,
      userID: element.userID,
      postList: List<UsersPostDataViewModel>.from(element.postList.map((e) => UsersPostDataViewModel(
        postID: e.postID,
        body: e.body,
        author: e.author,
        title: e.title

      )))
    ))));
  }
}


class ResponseHandler extends AmplifyServiceResponseHandler
{
  @override
  void onInvalidRequest(Error error) {
    // TODO: implement onInvalidRequest
  }

  @override
  void onInvalidSession() {
    // TODO: implement onInvalidSession
  }

  @override
  void onServerError() {
    // TODO: implement onServerError
  }

  @override
  void onUnexpectedContent(Exception exception) {
    // TODO: implement onUnexpectedContent
  }

}