import 'package:flutter/material.dart';
import 'package:startlottery/Services/auth_service.dart';
import 'package:startlottery/responsive.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordUnvisible = true;
  bool rememberMe = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  setRememberMe() {
    rememberMe = !rememberMe;
    setState(() {});
  }

  makePasswordVisible() {
    isPasswordUnvisible = !isPasswordUnvisible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // print(Responsive.isTablet(context));
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome Admin",
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (Responsive.isDesktop(context))
                  Image.asset("assets/Admin.gif"),
                if (Responsive.isDesktop(context))
                  SizedBox(
                    width: Responsive.isDesktop(context)
                        ? size.width * .05
                        : size.width * .08,
                  ),
                Form(
                  key: _formKey,
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? size.width * .25
                        : Responsive.isTablet(context)
                            ? size.width * .6
                            : size.width * .8,
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Admin Login",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                        ),
                        SizedBox(
                          height: size.height * .03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Email!";
                              } else if (!value.contains(".")) {
                                return "Please Enter Valid Email";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Email",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.redAccent),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Password!";
                              } else {
                                return null;
                              }
                            },
                            obscureText: isPasswordUnvisible,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () => makePasswordVisible(),
                                  icon: Icon(isPasswordUnvisible
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              hintText: "Password",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.redAccent),
                              ),
                            ),
                          ),
                        ),
                        CheckboxListTile(
                          checkColor: Colors.white,
                          value: rememberMe,
                          tileColor: Colors.white,
                          onChanged: (value) => setRememberMe(),
                          title: Text(
                            "Remember Me",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: Responsive.isDesktop(context)
                              ? size.width * .03
                              : Responsive.isTablet(context)
                                  ? size.width * .05
                                  : size.width * .08,
                        ),
                        LayoutBuilder(
                          builder: (context, boxConstraints) {
                            return SizedBox(
                              width: boxConstraints.maxWidth,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      primary: Colors.black,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      backgroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              Responsive.isDesktop(context)
                                                  ? 25
                                                  : 16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      AuthService().signIn(emailController.text,
                                          passwordController.text, context);
                                    }
                                  },
                                  child: const Text("Sign In")),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
