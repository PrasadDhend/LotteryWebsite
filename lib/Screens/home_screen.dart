import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:startlottery/Models/lottery_brand_model.dart';
import 'package:startlottery/Models/lottery_model.dart';
import 'package:intl/intl.dart';
import 'package:startlottery/Models/today_lottery_model.dart';
import 'package:startlottery/Utils/utils.dart';
import 'package:startlottery/components/timer_widget.dart';
import 'package:startlottery/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodayLotteryModel> todaysLotteries = [];
  List<LotterBrandModel> lottries = [];
  bool isLoading = false;
  bool websiteLoading = false;
  bool isFirstLoad = true;
  DateTime? lotteryDate = DateTime.now();
  String? marqueText;
  double? speed;
  String terms = "";
  String mainHead = "";
  String title = "";
  String content = "";
  String phone = "";

  Future getWebsiteData() async {
    setState(() {
      websiteLoading = true;
    });
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
            .doc("terms")
            .get();
    final DocumentSnapshot<Map<String, dynamic>> phoneResponse =
        await FirebaseFirestore.instance
            .collection("websiteData")
            .doc("Phone")
            .get();
    await getMarqueeText();
    if (phoneResponse.exists) {
      phone = phoneResponse["text"] ?? " ";
    }
    terms = termsResponse["text"] ?? " ";
    title = titleResponse["text"] ?? " ";
    mainHead = mainHeadResponse["text"] ?? " ";
    content = contentResponse["text"] ?? " ";

    setState(() {
      websiteLoading = false;
    });
  }

  Future getMarqueeText() async {
    final DocumentSnapshot<Map<String, dynamic>> response =
        await FirebaseFirestore.instance
            .collection("websiteData")
            .doc("MarqueTag")
            .get();
    marqueText = response["text"];
    final String speedText = response["speed"];
    speed = Utils().setSpeed(speedText);
    setState(() {});
  }

  Future getTodayData(DateTime date) async {
    setState(() {
      isLoading = true;
    });
    todaysLotteries = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("lotteries")
        .doc(DateTime(date.year, date.month, date.day).toIso8601String())
        .collection("lottery")
        .get();
    if (querySnapshot.size != 0) {
      for (var item in querySnapshot.docs) {
        todaysLotteries.add(TodayLotteryModel.fromJSON(item));
      }
      await getLotteryData(date);
    }
  }

  Future getLotteryData(DateTime date) async {
    lottries = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot;
    await Future.forEach(todaysLotteries, (TodayLotteryModel element) async {
      querySnapshot = await FirebaseFirestore.instance
          .collection("lotteries")
          .doc(DateTime(date.year, date.month, date.day).toIso8601String())
          .collection("lottery")
          .doc(element.id)
          .collection("brands")
          .get();
      final List<LotteryModel> tempLottery = [];
      for (var item in querySnapshot.docs) {
        tempLottery.add(LotteryModel.fromJSON(item));
      }
      lottries.add(LotterBrandModel(
        dateTime: DateTime.parse(element.id),
        lottries: tempLottery,
      ));
    });

    isLoading = false;
    setState(() {});
  }

  Future pickDate() async {
    lotteryDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year, DateTime.january),
        lastDate: DateTime.now());
    lotteryDate ??= DateTime.now();
    setState(() {});
  }

  @override
  void didChangeDependencies() async {
    if (isFirstLoad) {
      await getWebsiteData();
      await getTodayData(lotteryDate!);
    }
    isFirstLoad = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: !websiteLoading
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 10),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        // borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Text(mainHead.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: Colors.yellowAccent,
                                      fontWeight: FontWeight.w900)),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          const TimerWidget(),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          ResponsiveBuilder(builder: (context, sizing) {
                            if (sizing.isMobile) {
                              return Column(
                                children: [
                                  Text(
                                    "Select Date",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: size.height * .02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () async => await pickDate(),
                                        icon: const Icon(Icons.calendar_today),
                                        label: Text(DateFormat.yMMMd()
                                            .format(lotteryDate!)),
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 16),
                                            primary: Colors.redAccent,
                                            backgroundColor: Colors.white,
                                            textStyle: const TextStyle(
                                              color: Colors.yellowAccent,
                                            )),
                                      ),
                                      SizedBox(
                                        width: size.width * .02,
                                      ),
                                      TextButton.icon(
                                        onPressed: () async {
                                          await getTodayData(lotteryDate!);
                                        },
                                        icon: const Icon(Icons.search),
                                        label: const Text("Search"),
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 16),
                                            primary: Colors.black,
                                            backgroundColor: Colors.white,
                                            textStyle: const TextStyle(
                                              color: Colors.yellowAccent,
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                            if (sizing.isDesktop) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Select Date",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: size.width * .02,
                                  ),
                                  TextButton.icon(
                                    onPressed: () async => await pickDate(),
                                    icon: const Icon(Icons.calendar_today),
                                    label: Text(DateFormat.yMMMd()
                                        .format(lotteryDate!)),
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 16),
                                        primary: Colors.redAccent,
                                        backgroundColor: Colors.white,
                                        textStyle: const TextStyle(
                                          color: Colors.yellowAccent,
                                        )),
                                  ),
                                  SizedBox(
                                    width: size.width * .02,
                                  ),
                                  TextButton.icon(
                                    onPressed: () async {
                                      await getTodayData(lotteryDate!);
                                    },
                                    icon: const Icon(Icons.search),
                                    label: const Text("Search"),
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 16),
                                        primary: Colors.black,
                                        backgroundColor: Colors.white,
                                        textStyle: const TextStyle(
                                          color: Colors.yellowAccent,
                                        )),
                                  ),
                                ],
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Select Date",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  width: size.width * .02,
                                ),
                                TextButton.icon(
                                  onPressed: () async => await pickDate(),
                                  icon: const Icon(Icons.calendar_today),
                                  label: Text(
                                      DateFormat.yMMMd().format(lotteryDate!)),
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                                      primary: Colors.redAccent,
                                      backgroundColor: Colors.white,
                                      textStyle: const TextStyle(
                                        color: Colors.yellowAccent,
                                      )),
                                ),
                                SizedBox(
                                  width: size.width * .02,
                                ),
                                TextButton.icon(
                                  onPressed: () async {
                                    await getTodayData(lotteryDate!);
                                  },
                                  icon: const Icon(Icons.search),
                                  label: const Text("Search"),
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                                      primary: Colors.black,
                                      backgroundColor: Colors.white,
                                      textStyle: const TextStyle(
                                        color: Colors.yellowAccent,
                                      )),
                                ),
                              ],
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          phone.isNotEmpty
                              ? ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurpleAccent,
                                  ),
                                  onPressed: () {
                                    launch("tel://$phone");
                                  },
                                  icon: const Icon(Icons.call),
                                  label: Text(phone))
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Responsive.isMobile(context)
                        ? size.width
                        : size.width * .5,
                    height: size.height * .05,
                    child: Marquee(
                      text: marqueText ?? " ",
                      blankSpace: size.width * .4,
                      velocity: speed == null ? 50 : speed!.toDouble(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  if (Responsive.isDesktop(context))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isLoading)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        !isLoading ||
                                lottries.isNotEmpty ||
                                todaysLotteries.isNotEmpty
                            ? DataTable(
                                dividerThickness: 2,
                                columnSpacing: 0,
                                headingRowColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => Colors.redAccent),
                                headingTextStyle: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                showBottomBorder: true,
                                columns: [
                                  lottries.isNotEmpty
                                      ? DataColumn(
                                          label: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .05,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text("Draw Time",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                        ))
                                      : DataColumn(label: Container())
                                ],
                                rows: lottries
                                    .map((e) => DataRow(cells: [
                                          DataCell(Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .05,
                                            child: Text(DateFormat("hh:mm a")
                                                .format(e.dateTime)),
                                          ))
                                        ]))
                                    .toList(),
                              )
                            : Container(),
                        !isLoading ||
                                lottries.isNotEmpty ||
                                todaysLotteries.isNotEmpty
                            ? DataTable(
                                columnSpacing: 0,
                                dividerThickness: 2,
                                headingRowColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => Colors.redAccent),
                                headingTextStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                showBottomBorder: true,
                                columns: lottries.isNotEmpty
                                    ? lottries[0]
                                        .lottries
                                        .map((e) => DataColumn(
                                            label: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .1,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    e.lotteryName,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ))))
                                        .toList()
                                    : [DataColumn(label: Container())],
                                rows: lottries
                                    .map(
                                      (brand) => DataRow(
                                          cells: brand.lottries
                                              .map((lottery) => DataCell(
                                                  SizedBox(
                                                      width: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width *
                                                          .1),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            lottery
                                                                .lotteryValue,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1),
                                                      ))))
                                              .toList()),
                                    )
                                    .toList())
                            : Container(),
                      ],
                    ),
                  if (Responsive.isMobile(context) ||
                      Responsive.isTablet(context))
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : !isLoading ||
                                lottries.isNotEmpty ||
                                todaysLotteries.isNotEmpty
                            ? Stack(
                                children: [
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      bottom: 0,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.arrow_left))),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.arrow_right))),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DataTable(
                                        dividerThickness: 2,
                                        columnSpacing:
                                            (MediaQuery.of(context).size.width /
                                                    10) *
                                                0.5,
                                        headingRowColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) => Colors.redAccent),
                                        headingTextStyle: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        showBottomBorder: true,
                                        columns: const [
                                          DataColumn(
                                            label: Text("Draw Time"),
                                          ),
                                        ],
                                        rows: lottries
                                            .map(
                                              (e) => DataRow(
                                                cells: [
                                                  DataCell(
                                                    Text(
                                                      DateFormat("hh:mm a")
                                                          .format(e.dateTime),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                              columnSpacing:
                                                  (MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          10) *
                                                      0.5,
                                              dividerThickness: 2,
                                              headingRowColor:
                                                  MaterialStateProperty.resolveWith(
                                                      (states) =>
                                                          Colors.redAccent),
                                              headingTextStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                              showBottomBorder: true,
                                              columns: lottries.isNotEmpty
                                                  ? lottries[0]
                                                      .lottries
                                                      .map((e) => DataColumn(
                                                          label:
                                                              Text(e.lotteryName)))
                                                      .toList()
                                                  : [DataColumn(label: Container())],
                                              rows: lottries
                                                  .map(
                                                    (brand) => DataRow(
                                                        cells: brand.lottries
                                                            .map((lottery) =>
                                                                DataCell(Text(
                                                                  lottery
                                                                      .lotteryValue,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subtitle1,
                                                                )))
                                                            .toList()),
                                                  )
                                                  .toList()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Container(),
                  HomeScreenBottomWidget(
                    terms: terms,
                  ),
                  Visibility(
                    visible: false,
                    child: Text(content),
                  )
                ],
              ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class HomeScreenBottomWidget extends StatelessWidget {
  final String terms;
  const HomeScreenBottomWidget({Key? key, required this.terms})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
      padding: const EdgeInsets.all(20),
      child: Text(
        terms,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.white, height: 1.3),
      ),
    );
  }
}
