
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../views/splash/splash_screen_viewmodel.dart';
class AppProvider {
  //The providers for dependency injection and state management will be added here
  //as the app will use MultiProvider
  static final providers = <SingleChildWidget>[
    ChangeNotifierProvider(create: (_) => SplashScreenVM()),
    // ChangeNotifierProvider(create: (_) => SignUpVM())
  ];
}
