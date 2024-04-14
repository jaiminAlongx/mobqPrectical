import 'package:deemo/Home/binding.dart';
import 'package:deemo/Home/homescreen.dart';
import 'package:deemo/splashscren.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  // static String login = '/login_screen';

  static String SplashScreenn = "/Splassh_screen";
  static String Homescreen = "/Home_screen";

  static List<GetPage> pages = [
    GetPage(
      name: SplashScreenn,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Homescreen,
      page: () => HomeScreen(),
      bindings: [binding()],
    ),
  ];
}
