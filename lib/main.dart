import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/model/tourism..dart';
import 'package:tourism_app/provider/detail/bookmark_list_provider.dart';
import 'package:tourism_app/provider/main/index_nav_provider.dart';
import 'package:tourism_app/screen/detail/detail_screen.dart';
import 'package:tourism_app/screen/home/home_screen.dart';
import 'package:tourism_app/screen/main/main_screen.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/style/theme/tourism_theme.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookmarkListProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onDetach: () => debugPrint('app-detached'),
      onInactive: () => debugPrint('app-inactive'),
      onPause: () => debugPrint('app-paused'),
      onResume: () => debugPrint('app-resumed'),
      onRestart: () => debugPrint('app-restarted'),
      onShow: () => debugPrint("app-showed"),
      onHide: () => debugPrint("app-hide"),
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   colorScheme: lightColorScheme,
      //   useMaterial3: true,
      // ),
      theme: TourismTheme.lihtTheme,
      // darkTheme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      // ),
      darkTheme: TourismTheme.darkTheme,
      themeMode: ThemeMode.system,
      // home: HomeScreen(),
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              tourismId: ModalRoute.of(context)?.settings.arguments as int,
            ),
      },
    );
  }
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF2A5BB1),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD9E2FF),
  onPrimaryContainer: Color(0xFF001A43),
  secondary: Color(0xFF245FA6),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD5E3FF),
  onSecondaryContainer: Color(0xFF001B3C),
  tertiary: Color(0xFFAB3500),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFDBD0),
  onTertiaryContainer: Color(0xFF390C00),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFEFBFF),
  onBackground: Color(0xFF1B1B1F),
  surface: Color(0xFFFEFBFF),
  onSurface: Color(0xFF1B1B1F),
  surfaceVariant: Color(0xFFE1E2EC),
  onSurfaceVariant: Color(0xFF44474F),
  outline: Color(0xFF757780),
  onInverseSurface: Color(0xFFF2F0F4),
  inverseSurface: Color(0xFF303034),
  inversePrimary: Color(0xFFAFC6FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF2A5BB1),
  outlineVariant: Color(0xFFC5C6D0),
  scrim: Color(0xFF000000),
);
