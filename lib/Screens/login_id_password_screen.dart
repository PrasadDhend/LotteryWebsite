import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:startlottery/Screens/admin_panel_screen.dart';
import 'package:startlottery/Screens/handle_login_screen.dart';
import 'package:startlottery/Services/auth_service.dart';
import 'package:startlottery/Utils/utils.dart';
import 'package:startlottery/components/custom_appbar.dart';
import 'package:startlottery/responsive.dart';

class LoginIdAndPasswordScreen extends StatefulWidget {
  static const routeName = "/LoginIdAndPasswordScreen";
  const LoginIdAndPasswordScreen({Key? key}) : super(key: key);

  @override
  _LoginIdAndPasswordScreenState createState() =>
      _LoginIdAndPasswordScreenState();
}

class _LoginIdAndPasswordScreenState extends State<LoginIdAndPasswordScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final passWordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Responsive.isDesktop(context)
          ? null
          : Drawer(
              child: CustomDrawer(size: size),
              semanticLabel: "Sidebar",
            ),
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context)) CustomDrawer(size: size),
          Expanded(
              child: Center(
            child: Container(
              width: Responsive.isMobile(context)
                  ? size.width * .9
                  : Responsive.isTablet(context)
                      ? size.width * .7
                      : size.width * .3,
              height: 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Update Password",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  TextField(
                    controller: passWordController,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20)),
                      onPressed: () async {
                        if (passWordController.text.isEmpty) return;
                        try {
                          await FirebaseAuth.instance.currentUser!
                              .updatePassword(passWordController.text);
                          Utils.showSnackBar(
                              context, "Password Updated Successfully",
                              color: Colors.greenAccent);
                        } catch (e) {
                          Utils.showSnackBar(context, e.toString(),
                              color: Colors.redAccent);
                        }
                      },
                      child: const Text("Update Details",
                          style: TextStyle(fontSize: 18))),
                ],
              ),
            ),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          AuthService().signOut();
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(HandleLoginScreen.routeName);
        },
        child: const Icon(Icons.directions_run),
      ),
    );
  }
}
