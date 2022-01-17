import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:startlottery/Screens/admin_panel_screen.dart';
import 'package:startlottery/Utils/utils.dart';
import 'package:startlottery/components/custom_appbar.dart';
import 'package:startlottery/responsive.dart';

class ContactInfoScreen extends StatefulWidget {
  static const routeName = "/ContactInfoScreen";
  const ContactInfoScreen({Key? key}) : super(key: key);

  @override
  _ContactInfoScreenState createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();
  bool isFirstLoad = true;

  getWebsiteData() async {
    final DocumentSnapshot<Map<String, dynamic>> contentResponse =
        await FirebaseFirestore.instance
            .collection("websiteData")
            .doc("Phone")
            .get();

    _contactController.text = contentResponse["text"] ?? " ";
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
              height: 300,
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
                          "Contact Number",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Contact Number";
                            } else if (value.length < 10 || value.length > 10) {
                              return "Enter Valid Number";
                            } else {
                              return null;
                            }
                          },
                          controller: _contactController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Contact",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20)),
                            onPressed: () async {
                              try {
                                await FirebaseFirestore.instance
                                    .collection("websiteData")
                                    .doc("Phone")
                                    .delete();

                                Utils.showSnackBar(
                                    context, "Mobile Number Deleted",
                                    color: Colors.greenAccent);
                                _contactController.clear();
                                // await getWebsiteData();
                              } catch (e) {
                                Utils.showSnackBar(
                                    context, "Something Went Wrong",
                                    color: Colors.redAccent);
                              }
                            },
                            child: const Text("Remove ",
                                style: TextStyle(fontSize: 18))),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurpleAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20)),
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;

                              try {
                                await FirebaseFirestore.instance
                                    .collection("websiteData")
                                    .doc("Phone")
                                    .set({
                                  "text": _contactController.text,
                                  "date": DateTime.now()
                                });

                                await getWebsiteData();
                                Utils.showSnackBar(
                                    context, "Mobile Number Updated",
                                    color: Colors.greenAccent);
                              } catch (e) {
                                Utils.showSnackBar(
                                    context, "Something Went Wrong",
                                    color: Colors.redAccent);
                              }
                            },
                            child: const Text("Update ",
                                style: TextStyle(fontSize: 18))),
                      ],
                    )
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
