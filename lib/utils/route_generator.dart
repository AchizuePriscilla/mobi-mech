import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobi_mech/views/views.dart';
import 'constants.dart';

class RouteGenerator {
  ///Generates routes, extracts and passes navigation arguments.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreenViewRoute:
        return _getPageRoute(const SplashScreenView());
      case signUpViewRoute:
        return _getPageRoute(const SignUpView());
      case loginViewRoute:
        return _getPageRoute(const LoginView());
      case homeViewRoute:
        return _getPageRoute(const HomeView());
      case favoriteViewRoute:
        return _getPageRoute(const FavoriteView());
      case historyViewRoute:
        return _getPageRoute(const HistoryView());
      case selectedMechanicViewRoute:
        return _getPageRoute(const SelectedMechanicView());
      default:
        return _getPageRoute(_errorPage());
    }
  }

  //Wraps widget with a CupertinoPageRoute and adds route settings
  static CupertinoPageRoute _getPageRoute(
    Widget child, [
    String? routeName,
    dynamic args,
  ]) =>
      CupertinoPageRoute(
        builder: (context) => child,
        settings: RouteSettings(
          name: routeName,
          arguments: args,
        ),
      );

  ///Error page shown when app attempts navigating to an unknown route
  static Widget _errorPage({String message = "Error! Page not found"}) =>
      Scaffold(
        appBar: AppBar(
            title: const Text(
          'Page not found',
          style: TextStyle(color: Colors.red),
        )),
        body: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
}
