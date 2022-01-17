import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:startlottery/Models/lottery_brand_model.dart';
import 'package:startlottery/Models/lottery_model.dart';
import 'package:startlottery/Models/today_lottery_model.dart';
import 'package:startlottery/Screens/admin_panel_screen.dart';
import 'package:startlottery/components/custom_appBar.dart';
import 'package:startlottery/responsive.dart';
import 'package:table_calendar/table_calendar.dart';

class PreviousResultScreen extends StatefulWidget {
  static const routeName = "/PreviousResultScreen";
  const PreviousResultScreen({Key? key}) : super(key: key);

  @override
  _PreviousResultScreenState createState() => _PreviousResultScreenState();
}

class _PreviousResultScreenState extends State<PreviousResultScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<TodayLotteryModel> todaysLotteries = [];
  List<LotterBrandModel> lottries = [];
  bool isLoading = false;
  bool isFirstLoad = true;
  DateTime? lotteryDate = DateTime.now();

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
      await getTodayData(lotteryDate!);
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Select Date",
                          style: Theme.of(context).textTheme.headline6!,
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
                              label:
                                  Text(DateFormat.yMMMd().format(lotteryDate!)),
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 30),
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
                                      vertical: 20, horizontal: 30),
                                  primary: Colors.black,
                                  backgroundColor: Colors.white,
                                  textStyle: const TextStyle(
                                    color: Colors.yellowAccent,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(50),
                      child: TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: lotteryDate!,
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
                                                            fontWeight:
                                                                FontWeight
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
                                                child: Text("Edit",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
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
                                              child: IconButton(
                                                  onPressed: () async {
                                                    int inde =
                                                        lottries.indexOf(e);
                                                    final List<LotteryModel>
                                                        temps =
                                                        lottries[inde].lottries;
                                                    await resultForm(
                                                        _scaffoldKey,
                                                        temps,
                                                        lottries[inde]
                                                            .dateTime);
                                                  },
                                                  icon: const Icon(Icons.edit)),
                                            ))
                                          ]))
                                      .toList(),
                                )
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
                                            icon:
                                                const Icon(Icons.arrow_left))),
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon:
                                                const Icon(Icons.arrow_right))),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        DataTable(
                                          dividerThickness: 2,
                                          columnSpacing: (MediaQuery.of(context)
                                                      .size
                                                      .width /
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
                                                headingTextStyle:
                                                    Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Future resultForm(GlobalKey<ScaffoldState> _scaffoldKey,
      List<LotteryModel> lottries, DateTime date) async {
    final _formKey = GlobalKey<FormState>();
    List<TextEditingController> controllers = [];
    for (var i = 0; i < lottries.length; i++) {
      controllers.add(TextEditingController());
    }
    showDialog(
        context: _scaffoldKey.currentState!.context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Lottery Numbers",
              style: Theme.of(context).textTheme.headline5,
            ),
            content: SizedBox(
              width: double.minPositive,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: lottries.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              lottries[index].lotteryName + ":",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 150,
                              height: 50,
                              child: Card(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Lottery No. ";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: controllers[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Lottery No.",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.redAccent),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();
                    for (var i = 0; i < controllers.length; i++) {
                      await FirebaseFirestore.instance
                          .collection("lotteries")
                          .doc(DateTime(lotteryDate!.year, lotteryDate!.month,
                                  lotteryDate!.day)
                              .toIso8601String())
                          .collection("lottery")
                          .doc(date.toIso8601String())
                          .collection("brands")
                          .doc(lottries[i].lotteryName)
                          .update({
                        "brandName": lottries[i].lotteryName,
                        "date": date,
                        "value": controllers[i].text
                      });
                    }
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10)),
                  child: Text("Upload Result",
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Colors.white))),
            ],
          );
        });
  }
}
