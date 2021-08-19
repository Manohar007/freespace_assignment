

import 'package:amplify_flutter_clean_framework/bloc/bloc.dart';
import 'package:freespace_assignment/getUsers/api/get_user_response_model.dart';
import 'package:freespace_assignment/getUsers/bloc/get_user_bloc.dart';
import 'package:freespace_assignment/getUsers/model/get_user_business_model.dart';
import 'package:freespace_assignment/getUsers/model/get_user_view_model.dart';
import 'package:freespace_assignment/getUsersPosts/api/get_users_post_service.dart';

class GetUsersPostBloc extends Bloc {
  final String userId;
  EventPipe onLaunch = EventPipe();
   BroadcastPipe<UsersDataViewModel> sendViewModel = BroadcastPipe();
  late GetUsersPostService _getUsersPostService;
  late ResponseHandler responseHandler;
  late GetUserBusinessModel businessModel;

  GetUsersPostBloc({required this.userId}) {
    onLaunch.listen(_getUserPosts);
    businessModel = GetUserBusinessModel();
    responseHandler = ResponseHandler();
    _getUsersPostService = GetUsersPostService(
        url: "https://609b59ee2b549f00176e34df.mockapi.io/api/users/"+userId,
        handler: responseHandler);
  }


  _getUserPosts() async{
    UsersDataResponseModel responseModel= await _getUsersPostService.request();
    businessModel.updateSingleUserPost(responseModel);
    sendViewModel.send(_createViewModel());
  }

  UsersDataViewModel _createViewModel() {
    var element=businessModel.listUsers.first;
    return UsersDataViewModel(
        name: element.name,
        avatar: element.avatar,
        userID: element.userID,
        postList: List<UsersPostDataViewModel>.from(element.postList.map((e) => UsersPostDataViewModel(
            postID: e.postID,
            body: e.body,
            author: e.author,
            title: e.title
        )))
    );
  }
}