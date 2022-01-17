import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:startlottery/Screens/admin_panel_screen.dart';
import 'package:startlottery/components/custom_appbar.dart';
import 'package:startlottery/responsive.dart';

class MainHeadScreen extends StatefulWidget {
  static const routeName = "/MainHeadScreen";
  const MainHeadScreen({Key? key}) : super(key: key);

  @override
  _MainHeadScreenState createState() => _MainHeadScreenState();
}

class _MainHeadScreenState extends State<MainHeadScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _mainHeadController = TextEditingController();
  final _titleController = TextEditingController();
  final _termsController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isFirstLoad = true;

  getWebsiteData() async {
    final DocumentSnapshot<Map<String, dynamic>> mainHeadResponse =
        await FirebaseFirestore.instance
            .collection("websiteData")
            .doc("MainHead")
            .get();
    final DocumentSnapshot<Map<String, dynamic>> titleResponse =
        await FirebaseFirestore.instance
            .collection("websiteData")
            .doc("title")
            .get();
    final DocumentSnapshot<Map<String, dynamic>> termsResponse =
        await FirebaseFirestore.instance
            .collection("websiteData")
            .doc("terms")
            .get();
    final DocumentSnapshot<Map<String, dynamic>> contentResponse =
        await FirebaseFirestore.instance
            .collection("websiteData")
            .doc("content")
            .get();
    _termsController.text = termsResponse["text"] ?? " ";
    _titleController.text = titleResponse["text"] ?? " ";
    _mainHeadController.text = mainHeadResponse["text"] ?? " ";
    _contentController.text = contentResponse["text"] ?? " ";
    setState(() {});
  }

  @override
  void didChangeDependencies() async {
    if (isFirstLoad) {
      await getWebsiteData();
    }
    isFirstLoad = false;
    super.didChangeDependencies();
  }

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
              height: 450,
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Main Head",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Main Head";
                            } else {
                              return null;
                            }
                          },
                          controller: _mainHeadController,
                          decoration: InputDecoration(
                            hintText: "Main Head",
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
                              borderSide:
                                  const BorderSide(color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Title";
                            } else {
                              return null;
                            }
                          },
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: "Title",
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
                              borderSide:
                                  const BorderSide(color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Content",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Content";
                            } else {
                              return null;
                            }
                          },
                          controller: _contentController,
                          decoration: InputDecoration(
                            hintText: "Content",
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
                              borderSide:
                                  const BorderSide(color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Terms & Policy",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Terms and Policy";
                            } else {
                              return null;
                            }
                          },
                          controller: _termsController,
                          decoration: InputDecoration(
                            hintText: "Terms and Policy",
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
                              borderSide:
                                  const BorderSide(color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurpleAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20)),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;

                          await FirebaseFirestore.instance
                              .collection("websiteData")
                              .doc("MainHead")
                              .update({
                            "text": _mainHeadController.text,
                            "date": DateTime.now()
                          });
                          await FirebaseFirestore.instance
                              .collection("websiteData")
                              .doc("title")
                              .update({
                            "text": _titleController.text,
                            "date": DateTime.now()
                          });
                          await FirebaseFirestore.instance
                              .collection("websiteData")
                              .doc("content")
                              .update({
                            "text": _contentController.text,
                            "date": DateTime.now()
                          });
                          await FirebaseFirestore.instance
                              .collection("websiteData")
                              .doc("terms")
                              .update({
                            "text": _termsController.text,
                            "date": DateTime.now()
                          });
                          await getWebsiteData();
                        },
                        child: const Text("Update ",
                            style: TextStyle(fontSize: 18)))
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
