import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:startlottery/Screens/admin_panel_screen.dart';
import 'package:startlottery/Screens/login_screen.dart';
import 'package:startlottery/Utils/utils.dart';

class AuthService {
  User? user;

  Widget handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const AdminPanelScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }

  signUp(String email, String password, BuildContext context) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      user = value.user;
    }).catchError((e) {
      Utils.showSnackBar(context, e.toString(), color: Colors.redAccent);
    });
  }

  signIn(String email, String password, BuildContext context) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      user = value.user;
    }).catchError((e) {
      Utils.showSnackBar(context, e.toString(), color: Colors.redAccent);
    });
  }

  signOut() async {
    await FirebaseAuth.instance.signOut().catchError((e) {});
  }
}
