import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:startlottery/Models/brands_model.dart';
import 'package:startlottery/Screens/admin_panel_screen.dart';
import 'package:startlottery/Utils/utils.dart';
import 'package:startlottery/responsive.dart';
import 'package:uuid/uuid.dart';

class ChangeBrandScreen extends StatefulWidget {
  static const routeName = "/ChangeBrandScreen";
  const ChangeBrandScreen({Key? key}) : super(key: key);

  @override
  _ChangeBrandScreenState createState() => _ChangeBrandScreenState();
}

class _ChangeBrandScreenState extends State<ChangeBrandScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final brandController = TextEditingController();
  bool isFirstLoad = true;
  bool isLoading = false;
  List<BrandsModel> brands = [];
  getBrands() async {
    isLoading = true;
    setState(() {});
    brands = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("lotteryBrands").get();

    for (var item in querySnapshot.docs) {
      brands.add(BrandsModel.fromJSON(item));
    }
    setState(() {
      isLoading = false;
    });
  }

  Future addBrand() async {
    if (brandController.text.isNotEmpty) {
      final String id = const Uuid().v4();
      await FirebaseFirestore.instance.collection("lotteryBrands").doc(id).set({
        "brandName": brandController.text,
        "createDate": DateTime.now(),
        "id": id
      });
      Navigator.of(context).pop();
    } else {
      Utils.showSnackBar(context, "Brand Name is required",
          color: Colors.redAccent);
    }
  }

  Future editBrand(String id) async {
    if (brandController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("lotteryBrands")
          .doc(id)
          .update({
        "brandName": brandController.text,
        "createDate": DateTime.now(),
      });
      Navigator.of(context).pop();
    } else {
      Utils.showSnackBar(context, "Brand Name is required",
          color: Colors.redAccent);
    }
  }

  Future deleteBrand(String id) async {
    if (brandController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("lotteryBrands")
          .doc(id)
          .delete();
      Navigator.of(context).pop();
    } else {
      Utils.showSnackBar(context, "Brand Name is required",
          color: Colors.redAccent);
    }
  }

  @override
  void didChangeDependencies() {
    if (isFirstLoad) {
      getBrands();
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            if (_scaffoldKey.currentState!.isDrawerOpen) {
              Navigator.of(context).pop();
            } else {
              _scaffoldKey.currentState!.openDrawer();
            }
          },
        ),
        backgroundColor: Colors.deepPurpleAccent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              DateFormat().format(DateTime.now()),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Next Draw ",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  // DateFormat().add_jm().format(DateTime.now()),
                  DateFormat("hh:mm a").format(Utils().nextDraw()),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
              child: Text(
                "Admin",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574?b=1&k=20&m=1300972574&s=170667a&w=0&h=2nBGC7tr0kWIU8zRQ3dMg-C5JLo9H2sNUuDjQ5mlYfo="),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add Brand"),
                  content: TextField(
                    controller: brandController,
                    decoration: InputDecoration(
                      hintText: "Brand Name",
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
                  actions: [
                    ElevatedButton(
                        onPressed: () async {
                          final dateTime = DateTime.now();
                          if (!DateTime(dateTime.year, dateTime.month,
                                  dateTime.day, 8, 45, 0, 0)
                              .difference(dateTime)
                              .isNegative) {
                            await addBrand();
                          } else if (DateTime(dateTime.year, dateTime.month,
                                  dateTime.day, 21, 00, 0, 0)
                              .difference(dateTime)
                              .isNegative) {
                            await addBrand();
                          } else {
                            Utils.showSnackBar(context,
                                "Add the Brand Before 8:45 AM or After 9:00 PM",
                                color: Colors.redAccent);
                          }
                          brandController.clear();
                        },
                        child: const Text("Add Brand"))
                  ],
                );
              });
        },
        child: const Center(
            child: Text(
          "Add New",
          textAlign: TextAlign.center,
        )),
      ),
      body: brands.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context)) CustomDrawer(size: size),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: Responsive.isDesktop(context)
                          ? size.width * .3
                          : Responsive.isTablet(context)
                              ? size.width * 0.5
                              : size.width,
                      child: ListView.builder(
                        itemCount: brands.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: IconButton(
                                onPressed: () async {
                                  brandController.clear();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Add Brand"),
                                          content: TextField(
                                            controller: brandController,
                                            decoration: InputDecoration(
                                              hintText: "Brand Name",
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.black),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.black),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.black),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.redAccent),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () async {
                                                  final dateTime =
                                                      DateTime.now();
                                                  if (!DateTime(
                                                          dateTime.year,
                                                          dateTime.month,
                                                          dateTime.day,
                                                          8,
                                                          45,
                                                          0,
                                                          0)
                                                      .difference(dateTime)
                                                      .isNegative) {
                                                    await editBrand(
                                                        brands[index].id);
                                                  } else if (DateTime(
                                                          dateTime.year,
                                                          dateTime.month,
                                                          dateTime.day,
                                                          21,
                                                          00,
                                                          0,
                                                          0)
                                                      .difference(dateTime)
                                                      .isNegative) {
                                                    await editBrand(
                                                        brands[index].id);
                                                  } else {
                                                    Utils.showSnackBar(context,
                                                        "Add the Brand Before 8:45 AM or After 9:00 PM",
                                                        color:
                                                            Colors.redAccent);
                                                  }
                                                  brandController.clear();
                                                },
                                                child: const Text("Add Brand"))
                                          ],
                                        );
                                      });
                                },
                                icon:
                                    const Icon(Icons.edit, color: Colors.white),
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Confirm"),
                                          content: const Text(
                                              "You are sure to Delete!"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel")),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  final dateTime =
                                                      DateTime.now();
                                                  if (!DateTime(
                                                          dateTime.year,
                                                          dateTime.month,
                                                          dateTime.day,
                                                          8,
                                                          45,
                                                          0,
                                                          0)
                                                      .difference(dateTime)
                                                      .isNegative) {
                                                    await deleteBrand(
                                                        brands[index].id);
                                                  } else if (DateTime(
                                                          dateTime.year,
                                                          dateTime.month,
                                                          dateTime.day,
                                                          21,
                                                          00,
                                                          0,
                                                          0)
                                                      .difference(dateTime)
                                                      .isNegative) {
                                                    await deleteBrand(
                                                        brands[index].id);
                                                  } else {
                                                    Utils.showSnackBar(context,
                                                        "Add the Brand Before 8:45 AM or After 9:00 PM",
                                                        color:
                                                            Colors.redAccent);
                                                  }
                                                },
                                                child: const Text("Yes"))
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              tileColor: Colors.deepPurpleAccent,
                              title: Center(
                                child: Text(
                                  brands[index].brandName.toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
