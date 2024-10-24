import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} | Change: $change');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('${bloc.runtimeType} | Closed');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('${bloc.runtimeType} | Created');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('${bloc.runtimeType} | Error: $error | StackTrace: $stackTrace');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('${bloc.runtimeType} | Event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} | Transition: $transition');
  }
}
