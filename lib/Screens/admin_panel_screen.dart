import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:startlottery/Models/brands_model.dart';
import 'package:startlottery/Models/lottery_brand_model.dart';
import 'package:startlottery/Models/lottery_model.dart';
import 'package:startlottery/Models/today_lottery_model.dart';
import 'package:startlottery/Utils/utils.dart';
import 'package:startlottery/components/custom_appBar.dart';
import 'package:startlottery/components/other_management_widget.dart';
import 'package:startlottery/components/result_management_widget.dart';
import 'package:startlottery/components/text_management_widget.dart';
import 'package:startlottery/constants.dart';
import 'package:startlottery/responsive.dart';

class AdminPanelScreen extends StatefulWidget {
  static const routeName = "/AdminPanelScreen";
  const AdminPanelScreen({Key? key}) : super(key: key);

  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  List<TodayLotteryModel> todaysLotteries = [];
  List<LotterBrandModel> lottries = [];
  bool isLoading = false;
  bool isFirstLoad = true;
  Future getTodayData() async {
    setState(() {
      isLoading = true;
    });
    todaysLotteries = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("lotteries")
        .doc(DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .toIso8601String())
        .collection("lottery")
        .get();
    if (querySnapshot.size != 0) {
      for (var item in querySnapshot.docs) {
        todaysLotteries.add(TodayLotteryModel.fromJSON(item));
      }
      await getLotteryData();
    }
  }

  Future getLotteryData() async {
    lottries = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot;
    await Future.forEach(todaysLotteries, (TodayLotteryModel element) async {
      querySnapshot = await FirebaseFirestore.instance
          .collection("lotteries")
          .doc(DateTime(
                  DateTime.now().year, DateTime.now().month, DateTime.now().day)
              .toIso8601String())
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

  String selectedTime = timeIntervals.first;
  // String selectedTicket = tickets.first;
  DateTime date = DateTime.now();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() async {
    if (isFirstLoad) {
      await getTodayData();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context)) CustomDrawer(size: size),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.deepPurpleAccent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Pick A Time"),
                              content: StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.deepPurpleAccent)),
                                  child: DropdownButton<String>(
                                    hint: Text(timeIntervals.first),
                                    value: selectedTime,
                                    underline: Container(),
                                    items: timeIntervals.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      selectedTime = value.toString();
                                      setState(() {});
                                    },
                                  ),
                                );
                              }),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      final time =
                                          await Utils().setTime(selectedTime);
                                      if (time == null) return;

                                      date = time;
                                      Navigator.of(context).pop();
                                      QuerySnapshot querySnapshot =
                                          await FirebaseFirestore.instance
                                              .collection("lotteryBrands")
                                              .get();
                                      List<BrandsModel> brands = [];
                                      for (var item in querySnapshot.docs) {
                                        brands.add(BrandsModel.fromJSON(item));
                                      }
                                      await resultForm(_scaffoldKey, brands);
                                    },
                                    child: const Text("Result"))
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.upload),
                    label: const Text("Upload Result"),
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                                            FontWeight.bold))),
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
                                            .map((lottery) => DataCell(SizedBox(
                                                width: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .1),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      lottery.lotteryValue,
                                                      style: Theme.of(context)
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
                                                        label: Text(
                                                            e.lotteryName)))
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
        ],
      ),
    );
  }

  Future resultForm(
      GlobalKey<ScaffoldState> _scaffoldKey, List<BrandsModel> brands) async {
    final _formKey = GlobalKey<FormState>();
    List<TextEditingController> controllers = [];
    for (var i = 0; i < brands.length; i++) {
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
                      itemCount: brands.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              brands[index].brandName + ":",
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
                          .doc(DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day)
                              .toIso8601String())
                          .collection("lottery")
                          .doc(date.toIso8601String())
                          .set({"id": date.toIso8601String()});
                      await FirebaseFirestore.instance
                          .collection("lotteries")
                          .doc(DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day)
                              .toIso8601String())
                          .collection("lottery")
                          .doc(date.toIso8601String())
                          .collection("brands")
                          .doc(brands[i].brandName)
                          .set({
                        "brandName": brands[i].brandName,
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

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: Responsive.isDesktop(context)
            ? size.width * .2
            : Responsive.isTablet(context)
                ? size.width * .5
                : size.width * .7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 50),
              width: double.infinity,
              color: Colors.deepPurpleAccent,
              child: Text(
                "Dashboard",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            const ResultManagementWidget(),
            const TextManagementWidget(),
            const OtherManagementWidget(),
          ],
        ),
      ),
    );
  }
}


// Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(color: Colors.deepPurpleAccent)),
//                         child: DropdownButton<String>(
//                           hint: Text(timeIntervals.first),
//                           value: selectedTime,
//                           underline: Container(),
//                           items: timeIntervals.map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             selectedTime = value.toString();
//                             setState(() {});
//                           },
//                         ),
//                       ),

// if (_textController.text.isNotEmpty) {
//                             FirebaseFirestore.instance
//                                 .collection("websiteData")
//                                 .doc("MarqueTag")
//                                 .set({
//                                   "text": _textController.text,
//                                   "speed": speed,
                                  
//                                 });
//                           }