import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:startlottery/Screens/admin_panel_screen.dart';
import 'package:startlottery/Utils/utils.dart';
import 'package:startlottery/components/custom_appBar.dart';
import 'package:startlottery/constants.dart';
import 'package:startlottery/responsive.dart';

class ScrollBannerScreen extends StatefulWidget {
  static const routeName = '/scroll_banner';
  const ScrollBannerScreen({Key? key}) : super(key: key);

  @override
  _ScrollBannerScreenState createState() => _ScrollBannerScreenState();
}

class _ScrollBannerScreenState extends State<ScrollBannerScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _textController = TextEditingController();
  bool isFirstLoad = true;
  String? marqueText;
  String speed = speeds[0];

  Future getMarqueeText() async {
    final DocumentSnapshot<Map<String, dynamic>> response =
        await FirebaseFirestore.instance
            .collection("websiteData")
            .doc("MarqueTag")
            .get();
    setState(() {
      marqueText = response["text"];
    });
  }

  @override
  void didChangeDependencies() async {
    if (isFirstLoad) {
      await getMarqueeText();
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
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width:
                    Responsive.isMobile(context) ? size.width : size.width * .5,
                height: size.height * .05,
                child: Center(
                  child: Text(
                    marqueText ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 500,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Add text here",
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: DropdownButton<String>(
                        hint: Text(
                          speeds.first,
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: speed,
                        underline: Container(),
                        items: speeds.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          speed = value.toString();
                          setState(() {});
                        },
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurpleAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20)),
                        onPressed: () async {
                          if (_textController.text.isNotEmpty &&
                              _textController.text.length > 3 &&
                              speed != speeds[0]) {
                            await FirebaseFirestore.instance
                                .collection("websiteData")
                                .doc("MarqueTag")
                                .set({
                              "text": _textController.text,
                              "speed": speed,
                              "date": DateTime.now(),
                            });
                            _textController.clear();
                            speed = speeds[0];
                            setState(() {});
                          } else {
                            Utils.showSnackBar(
                                context, "Please enter text and select speed",
                                color: Colors.redAccent);
                          }
                        },
                        child: const Text("Update ",
                            style: TextStyle(fontSize: 18)))
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
