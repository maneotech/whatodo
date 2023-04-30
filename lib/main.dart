import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatodo/providers/auth.dart';
import 'package:whatodo/providers/location.dart';
import 'package:whatodo/providers/user.dart';
import 'package:whatodo/screens/history_screen.dart';
import 'package:whatodo/screens/home.dart';
import 'package:whatodo/screens/login.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

import 'components/app_bar.dart';
import 'components/bottom_bar.dart';
import 'constants/constant.dart';
import 'providers/locale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LocaleProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => LocationProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(fontFamily: "Hellix");

    return MaterialApp(
      theme: theme,
      locale: Provider.of<LocaleProvider>(context).locale,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(
            analytics: FirebaseAnalytics.instance), // <-- here
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // French, no country code
        Locale('es', ''), // French, no country code
      ],
      routes: {
        '/': (context) => const SplashScreen(),
      },
      initialRoute: '/',
    );
  }

  ThemeData getTheme() {
    final ThemeData theme = ThemeData(fontFamily: "Hellix");
    TextStyle smallText = const TextStyle(
        fontFamily: "Hellix", fontSize: 15.0, color: Colors.black);

    TextStyle mediumText = const TextStyle(
        fontFamily: "Hellix", fontSize: 20.0, color: Colors.black);

    TextStyle largeText = const TextStyle(
        fontFamily: "Hellix", fontSize: 25.0, color: Colors.black);

    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        background: const Color(0xff04012E),
        primary: const Color(0xff04012E),
      ),
      textTheme: TextTheme(
        bodyLarge: largeText,
        bodyMedium: mediumText,
        bodySmall: smallText,
      ),
      unselectedWidgetColor: Colors.white,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        if (value.jwt.isEmpty) {
          return AuthScreens(key: UniqueKey());
        } else {
          return RootScreens(
            key: Key(value.jwt),
          );
        }
      },
    );
  }
}

class AuthScreens extends StatefulWidget {
  const AuthScreens({super.key});

  @override
  State<AuthScreens> createState() => _AuthScreensState();
}

class _AuthScreensState extends State<AuthScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
          style: Constants.defaultTextStyle,
          child: LoginScreen(key: UniqueKey())),
    );
  }
}

class RootScreens extends StatefulWidget {
  const RootScreens({super.key});

  @override
  State<RootScreens> createState() => _RootScreensState();
}

class _RootScreensState extends State<RootScreens> {
  int currentPage = 0;

  /*List<Widget> pages =  [PlaceResultScreen(
    requestPlaceModel: RequestPlace([ActivityType.shopping], [MovingType.byWalk], 10, 10, 0, 15),
    
    resultPlaceModel: ResultPlaceModel(
        "ok",
        "oko",
        "Restaurant Le Parfait",
        "5 avenue du Pigeonnet, 13090 Aix en Provence",
        5.2,
        55,
        55,
        ["restaurant"],
        125,
        GeneratedOptions(ActivityType.restaurant, MovingType.byWalk),
        "https://lh3.googleusercontent.com/places/AJQcZqLStmtN2uaanztcyOqCto4EUoP3v8IfRwSMrWnrUYW0U38p35nOWBUBX-Zv2XOZ3ciMlRtDVTzK7X1-YIwI1JcfyF26z8PaoEI=s1600-w400"))/*HomeScreen()*/, HistoryScreen()];
*/

  List<Widget> pages = const [HomeScreen(), HistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: DefaultTextStyle(
          style: Constants.defaultTextStyle,
          child: pages[currentPage],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        onDestinationSelected: (int index) => onDestinationSelected(index),
      ),
    );
  }

  onDestinationSelected(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
