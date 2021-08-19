# amplify_flutter_clean_framework

##Note: 
This package is going to move out of this bundle. It's a temporary solution to  make the test build
execute. Need to find out solution to load this packages from git repo with version controlling.

This package used to make things easy in developing the flutter application using Bloc patter.

## Getting Started

### Step 1: 
Clone this repo into the same folder where you clone the amplify_flutter application.
```
clone command: git clone https://github.com/amplifylife/amplify-flutter-clean-framework.git

```
#### Example: 

Assume if amplify_flutter is cloned in Users/users_name/Documents/amplify_mobile/amplify-flutter.
And place this package by creating a directory as "mobile_dependencies" in samle location as 
Users/users_name/Documents/amplify_mobile/mobile_dependencies/amplify-flutter-clean-framework

### Step 2: 
Modify the pubspec.yaml and add below line in dependencies

```
  amplify_flutter_clean_framework:
    path: ../mobile-dependencies/amplify-flutter-clean-framework
   ``` 
### Step 3: 
Import the package in you Bloc or UI based on usage


## Using Pipes

One very important part of the Bloc architecture followed by the Amplify App is the mechanism
to transmit data between Blocs and UI elements. The Bloc design avoids completely the calling of
methods directly between classes, in order to remove dependencies (this is high coupling), which
creates code very difficult to maintain, refactor and reuse.

The preferred way to send data are asynchronous streams, which follow the Publisher / Subscriber
pattern and are easily accessible as part of the Dart language.

To make easier the implementation of these streams, we have available a practical wrapper we
called Pipe, which is a core class that is just a direct implementation of those streams but with 
a more straightforward set of methods, since most of the streams require a bit of boilerplate code.

### Pipe

The most basic example of a Pipe with some common calls is the following:

```
Pipe<bool> myFlagPipe = Pipe<bool>;

myFlagPipe.send(true);

myFlagPipe.receive.listen((newValue) => // do something with the value );
```

Pipes are meant to be used as public attributes of any Bloc, allowing any widget that wishes to 
listen to changes through them easily attach listeners, as in the above example.

The data object sent through a Pipe can be of any type, thus making easy for the Bloc to send a
whole Model to the UI, like this:

```

class MyModel {
  DateTime date;
  String name;
  List<double> coordinates;
  
  // assume constructors and JSON parsers are contained in the class
}


// Bloc code:

Pipe<MyModel> myModelPipe = Pipe<MyModel>;
myModelPipe.send(MyModel());


// UI Code:

StreamBuilder<MyModel>(
  stream: _bloc.myModelPipe.receive,
  builder: (context, snapshot){
      // Extract the values from the model and show them here.
  }
);

```

There are available additional types of Pipes:

### Event Pipe

The most basic example of a EventPipe with some common calls is the following:

```
/// Bloc code
EventPipe myEventPipe = EventPipe();

myEventPipe.listen(() => // do something in fectchiing info from API's 
and do business logic and send rsponse to UI );


/// UI code

var bloc = BlocInheritedProvider.of<ExampleBloc>(context);
bloc.myEventPipe.launch() // This triggers the bloc and listen to this request
```
EventPipe is used to trigger some event in bloc without any input parameters.


### Broadcast Pipe

The most basic example of a BroadcastPipe with some common calls is the following:

```
BroadcastPipe<bool> myPipe = BroadcastPipe<bool>;

myPipe.send(true);

myPipe.receive.listen((newValue) => // do something with the value );
```

BroadCastPipe is similar to Pipe implementaion. The main difference is it can handle multiple subscribers
per data transmission. For scenarios where more than one listeners are needed (for example, when 
sending the status of a checkbox to the Bloc, but also to a listener on the UI to change the state 
value of the same checkbox).

## Using BlocProvider & BlocInheritedProvider

BlocProvider is used to get the instance of bloc from his child widget. And BlocInheritedProvider is used to pass the same instance of bloc to all his child widgets.


Inorder to share the bloc to his child widget should be wrapped with BlocProvider and pass the bloc instance.
#### Example
```
class ExampleFeatureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider<ExampleBloc>(
        bloc: ExampleBloc(),
            child: ExamplePresenter()),
    );
  }
}
```


Inorder to share the Bloc instance across all the child of navigation stack, the BlocInheritedProvider should be wrapped around with Navigator.
#### Example
```
class ExampleFeatureWidget extends StatelessWidget {
@override
Widget build(BuildContext conetxt) {
    return BlocInheritedProvider(
           bloc: ExampleBloc(),
           child: Navigator(onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                      builder: (context) {
                        return ExamplePresenter();
                      });
                   }),
     );
}
```
## Using Presenter

These classes are the only UI components that interact with Bloc instances. They will retrieve the bloc reference from the context and set up a
Stream Builder, which extracts the View Model and propagates it to the rest of the UI components. This class will also contain any callbacks with
code that requires the use of context, such as navigation and dialog creation. Presenters are always StatelessWidgets, no state will be saved on UI components.

```
import 'package:amplify-flutter-clean-framework/ui/presenter.dart';

class ExamplePresenter
    extends Presenter<ExampleBloc, ExampleViewModel> {

  @override
  Stream<ExampleViewModel> getViewModelStream(BuildContext context, ExampleBloc bloc) {
    return bloc.exampleViewModelPipe.receive;
  }

  @override
  void sendViewModelRequest(BuildContext context, ExampleBloc bloc) {
    bloc.exampleRequestEvent.launch();
  }

  @override
  Widget buildLoadingScreen(BuildContext context) {
    return Container(
        child: Center(child: CircularProgressIndicator()));
  }

  @override
  Widget buildScreen(BuildContext context, ExampleBloc bloc,
      ExampleViewModel viewModel) {
    return ExampleScreen();
  }
}
```



