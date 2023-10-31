import 'package:get/get.dart';

import '../presentations/login_screen/login_screen.dart';
import '../presentations/login_screen/binding/login_binding.dart';
import '../presentations/signup_screen/signup_screen.dart';
import '../presentations/signup_screen/binding/signup_binding.dart';
import '../presentations/home_screen/home_screen.dart';
import '../presentations/home_screen/binding/home_binding.dart';
import '../presentations/splash_screen/splash_screen.dart';
import '../presentations/splash_screen/binding/splash_binding.dart';
import '../presentations/setting_screen/setting_screen.dart';
import '../presentations/setting_screen/binding/setting_binding.dart';
import '../presentations/chat_screen/chat_screen.dart';
import '../presentations/chat_screen/binding/chat_binding.dart';
import '../presentations/contacts_screen/contacts_screen.dart';
import '../presentations/contacts_screen/binding/contacts_binding.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String homeScreen = '/home';
  static const String settingScreen = '/setting';
  static const String contactsScreen = '/contacts';
  static const String chatScreen = '/chat';

  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: signupScreen,
      page: () => SignupScreen(),
      bindings: [
        SignupBinding(),
      ],
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: settingScreen,
      page: () => SettingScreen(),
      bindings: [
        SettingBinding(),
      ],
    ),
    GetPage(
      name: contactsScreen,
      page: () => ContactsScreen(),
      bindings: [
        ContactsBinding(),
      ],
    ),
    GetPage(
      name: chatScreen,
      page: () => ChatScreen(),
      bindings: [
        ChatBinding(),
      ],
    ),
  ];
}
