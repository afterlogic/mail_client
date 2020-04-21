import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logger/logger.dart';

class BlocLogger extends BlocDelegate {
  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    logger.log("Bloc error $error in ${bloc.runtimeType}");
    Crashlytics.instance.recordError(error,stacktrace);
    super.onError(bloc, error, stacktrace);
  }
}
