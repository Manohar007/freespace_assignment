// import 'package:flutter/widgets.dart';
// export 'dart:async';
// import '../bloc/bloc.dart';
// import '../model.dart';
//
// abstract class PresenterState<T extends StatefulWidget, B extends Bloc,
//     V extends ViewModel> extends State<T> {
//   PresenterState() : super();
//
//   B bloc;
//   @override
//   void initState() {
//     super.initState();
//     bloc = BlocInheritedProvider.of<B>(context);
//     sendViewModelRequest(bloc);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<V>(
//         stream: getViewModelStream(bloc),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return buildLoadingScreen(context);
//           } else if (snapshot.hasData) {
//             return buildScreen(context, bloc, snapshot.data);
//           }
//           return buildErrorScreen(context);
//         });
//   }
//
//   Stream<V> getViewModelStream(B bloc);
//
//   Widget buildScreen(BuildContext context, B bloc, V viewModel);
//
//   /// By default, the view model pipe should have a onListen callback on the
//   /// bloc, making unnecessary to send an event. But on complex situations,
//   /// this method can be overridden to control exactly the bloc sends the
//   /// view model.
//   void sendViewModelRequest(B bloc);
//
//   Widget buildLoadingScreen(BuildContext context) {
//     return Container(key: Key('waitingFromStream'));
//   }
//
//   Widget buildErrorScreen(BuildContext context) {
//     return Container(key: Key('noContentFromStream'));
//   }
// }
