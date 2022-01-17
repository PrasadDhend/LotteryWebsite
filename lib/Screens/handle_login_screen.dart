import 'package:flutter/material.dart';
import 'package:startlottery/Services/auth_service.dart';

class HandleLoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const HandleLoginScreen({Key? key}) : super(key: key);

  @override
  _HandleLoginScreenState createState() => _HandleLoginScreenState();
}

class _HandleLoginScreenState extends State<HandleLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthService().handleAuth();
  }
}
