import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:startlottery/Screens/admin_panel_screen.dart';
import 'package:startlottery/Screens/change_brand_screen.dart';
import 'package:startlottery/Screens/contact_info_screen.dart';
import 'package:startlottery/Screens/handle_login_screen.dart';
import 'package:startlottery/Screens/home_screen.dart';
import 'package:startlottery/Screens/login_id_password_screen.dart';
import 'package:startlottery/Screens/login_screen.dart';
import 'package:startlottery/Screens/main_head_screen.dart';
import 'package:startlottery/Screens/previous_result_screen.dart';
import 'package:startlottery/Screens/scroll_banner.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBrLMtJjfy-UVQwZxchDOmnY6VBj0BTW_M",
          appId: "1:764261955135:web:dfaa5a7e2d347dd8996a8a",
          messagingSenderId: "764261955135",
          projectId: "lottery-website-cbebc"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Star Lottery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        AdminPanelScreen.routeName: (context) => const AdminPanelScreen(),
        HandleLoginScreen.routeName: (context) => const HandleLoginScreen(),
        ChangeBrandScreen.routeName: (context) => const ChangeBrandScreen(),
        ScrollBannerScreen.routeName: (context) => const ScrollBannerScreen(),
        PreviousResultScreen.routeName: (context) =>
            const PreviousResultScreen(),
        MainHeadScreen.routeName: (context) => const MainHeadScreen(),
        LoginIdAndPasswordScreen.routeName: (context) =>
            const LoginIdAndPasswordScreen(),
        ContactInfoScreen.routeName: (context) => const ContactInfoScreen(),
      },
    );
  }
}
