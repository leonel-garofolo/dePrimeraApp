import 'dart:async';

import 'package:ag/main_common.dart';
import 'package:ag/providers/PersonasProvider.dart';
import 'package:ag/providers/appGruposProvider.dart';
import 'package:ag/providers/arbitrosProvider.dart';
import 'package:ag/providers/asistentesProvider.dart';
import 'package:ag/providers/authenticationProvider.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:ag/providers/comentariosProvider.dart';
import 'package:ag/providers/equiposProvider.dart';
import 'package:ag/providers/jugadoresProvider.dart';
import 'package:ag/providers/ligaProvider.dart';
import 'package:ag/providers/menuProvider.dart';
import 'package:ag/providers/notificacionesProvider.dart';
import 'package:ag/providers/paisesProvider.dart';
import 'package:ag/providers/partidosProvider.dart';
import 'package:ag/providers/provinciasProvider.dart';
import 'package:ag/providers/queryProvider.dart';
import 'package:ag/providers/sharedPreferenceProvider.dart';
import 'package:ag/providers/userProvider.dart';
import 'package:ag/view/configuraciones/ligas.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
      runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => AppGruposProvider()
          ),
          ChangeNotifierProvider(create: (_) => ArbitrosProvider()),
          ChangeNotifierProvider(create: (_) => AsistentesProvider()),
          ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
          ChangeNotifierProvider(create: (_) => CampeonatosProvider()),
          ChangeNotifierProvider(create: (_) => EquiposProvider()),
          ChangeNotifierProvider(create: (_) => JugadoresProvider()),
          ChangeNotifierProvider(
              create: (_) => LigaProvider(),
              child: LigasActivity(),
          ),
          ChangeNotifierProvider(create: (_) => MenuProvider()),
          ChangeNotifierProvider(create: (_) => NotificacionesProvider()),
          ChangeNotifierProvider(create: (_) => PartidosProvider()),
          ChangeNotifierProvider(create: (_) => PersonasProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => PaisesProvider()),
          ChangeNotifierProvider(create: (_) => ProvinciasProvider()),
          ChangeNotifierProvider(create: (_) => QueryProvider()),
          ChangeNotifierProvider(create: (_) => ComentariosProvider()),
          ChangeNotifierProvider(create: (_) => SharedPreferencesProvider()),
        ],
        child: DePrimeraApp(this),
      ));
    }, onError: Crashlytics.instance.recordError);
  }

  String get name => runtimeType.toString();
}





