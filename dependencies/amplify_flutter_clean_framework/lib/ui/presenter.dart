import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import '../model.dart';
import '../bloc/bloc.dart';

abstract class Presenter<B extends Bloc, V extends ViewModel>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    B bloc = BlocProvider.of<B>(context);

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      sendViewModelRequest(context, bloc);
    });

    return StreamBuilder<V?>(
        stream: getViewModelStream(context, bloc),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildScreen(context, bloc, snapshot.data!);
          } else if(snapshot.hasError) {
            return buildErrorScreen(context);
          }
          return buildLoadingScreen(context);
        });
  }

  Widget buildScreen(BuildContext context, B bloc, V viewModel);

  /// By default, the view model pipe should have a onListen callback on the
  /// bloc, making unnecessary to send an event. But on complex situations,
  /// this method can be overridden to control exactly the bloc sends the
  /// view model.
  void sendViewModelRequest(BuildContext context, B bloc);

  Stream<V?> getViewModelStream(BuildContext context, B bloc);

  Widget buildLoadingScreen(BuildContext context) {
    return Container(key: Key('waitingFromStream'));
  }

  Widget buildErrorScreen(BuildContext context) {
    return Container(key: Key('noContentFromStream'));
  }
}
