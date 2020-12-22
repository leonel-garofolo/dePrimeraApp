import 'dart:async';

import 'package:ag/main_common.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';

class Config {
  static Config value;

  String appDisplayName;
  String version;
  int appInternalId;
  String urlBase;

  Color primarySwatch;

  Config() {
    value = this;
    WidgetsFlutterBinding.ensureInitialized();
    // Set `enableInDevMode` to true to see reports while in debug mode
    // This is only to be used for confirming that reports are being
    // submitted as expected. It is not intended to be used for everyday
    // development.
    Crashlytics.instance.enableInDevMode = true;

    // Pass all uncaught errors to Crashlytics.
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
    runZoned(() {
      runApp(DePrimeraApp(this));
    }, onError: Crashlytics.instance.recordError);
  }

  String get name => runtimeType.toString();
}





