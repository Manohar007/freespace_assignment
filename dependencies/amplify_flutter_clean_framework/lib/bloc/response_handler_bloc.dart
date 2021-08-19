import '../service/amplify_service.dart';

import 'bloc.dart';

class ResponseHandlerBloc extends Bloc
    implements AmplifyServiceResponseHandler {
  static final String noListenersException =
      'Response Handler has no listeners';

  BroadcastPipe<ResponseHandlerResult> responseHandlerResultPipe =
      BroadcastPipe<ResponseHandlerResult>();

  @override
  void onInvalidRequest(Error error) {
    if (!responseHandlerResultPipe.hasListeners)
      throw noListenersException;
    else
      responseHandlerResultPipe.send(ResponseHandlerResult.invalidRequest);
  }

  @override
  void onInvalidSession() {
    if (!responseHandlerResultPipe.hasListeners)
      throw noListenersException;
    else
      responseHandlerResultPipe.send(ResponseHandlerResult.invalidSession);
  }

  @override
  void onServerError() {
    if (!responseHandlerResultPipe.hasListeners)
      throw noListenersException;
    else
      responseHandlerResultPipe.send(ResponseHandlerResult.serverError);
  }

  @override
  void onUnexpectedContent(Exception exception) {
    if (!responseHandlerResultPipe.hasListeners)
      throw noListenersException;
    else
      responseHandlerResultPipe.send(ResponseHandlerResult.unexpectedContent);
  }

  @override
  void dispose() {
    responseHandlerResultPipe.dispose();
  }
}
