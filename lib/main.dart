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

import 'components/app_bar.dart';
import 'components/bottom_bar.dart';
import 'constants/constant.dart';
import 'providers/locale.dart';

void main() {
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
  void didChangeDependencies() async {
    await context.read<AuthProvider>().init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(fontFamily: "Hellix");

    return Consumer<LocaleProvider>(
      builder: (context, provider, snapshot) {
        return MaterialApp(
          theme: theme,
          locale: provider.locale,
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('fr', ''), // French, no country code
          ],
          home: Consumer<AuthProvider>(
            builder: (context, value, child) {
              if (value.jwt.isEmpty) {
                return const AuthScreens();
              } else {
                return const RootScreens();
              }
            },
          ),
        );
      },
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

class AuthScreens extends StatefulWidget {
  const AuthScreens({super.key});

  @override
  State<AuthScreens> createState() => _AuthScreensState();
}

class _AuthScreensState extends State<AuthScreens> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultTextStyle(
          style: Constants.defaultTextStyle, child: LoginScreen()),
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

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
