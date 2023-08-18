import 'package:flutter/material.dart';
import 'package:mobi_mech/handlers/navigation_handler.dart';
import 'package:mobi_mech/shared/shared.dart';
import 'package:mobi_mech/utils/constants.dart';
import 'package:mobi_mech/utils/locator.dart';
import 'package:mobi_mech/utils/providers.dart';
import 'package:mobi_mech/utils/route_generator.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 630),
        builder: (context, child) {
          return MultiProvider(
              providers: AppProvider.providers,
              builder: (context, child) {
                return MaterialApp(
                  title: 'Mobi Mech',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  navigatorKey: locator<NavigationHandler>().navigatorKey,
                  onGenerateRoute: RouteGenerator.onGenerateRoute,
                  initialRoute: splashScreenViewRoute,
                );
              });
        });
  }
}
