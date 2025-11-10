import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  static const _logName = 'Bloc';

  @override
  void onEvent(Bloc bloc, Object? event) {
    developer.log('[Event] ${bloc.runtimeType} -> $event', name: _logName);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    developer.log('[Change] ${bloc.runtimeType} -> $change', name: _logName);
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    developer.log(
      '[Error] ${bloc.runtimeType} -> $error',
      name: _logName,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    developer.log(
      '[Transition] ${bloc.runtimeType} -> $transition',
      name: _logName,
    );
    super.onTransition(bloc, transition);
  }
}
