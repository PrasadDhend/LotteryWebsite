import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startlottery/Models/lottery_brand_model.dart';

class LotteryModel {
  final String lotteryValue;
  final DateTime dateTime;
  final String lotteryName;

  LotteryModel({
    required this.lotteryValue,
    required this.dateTime,
    required this.lotteryName,
  });

  factory LotteryModel.fromJSON(
      QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
    final Timestamp timestamp = queryDocumentSnapshot["date"] as Timestamp;
    return LotteryModel(
        lotteryValue: queryDocumentSnapshot["value"],
        dateTime: DateTime.fromMicrosecondsSinceEpoch(
            timestamp.microsecondsSinceEpoch),
        lotteryName: queryDocumentSnapshot["brandName"]);
  }
}

class Lotteries {
  final List<LotterBrandModel> lotteryBrands = [
    LotterBrandModel(
      dateTime: DateTime(2021, 12, 1, 9, 00),
      lottries: [
        LotteryModel(
          lotteryValue: "32",
          dateTime: DateTime.now(),
          lotteryName: "Chetak",
        ),
        LotteryModel(
          lotteryValue: "45",
          dateTime: DateTime.now(),
          lotteryName: "Sangam",
        ),
        LotteryModel(
          lotteryValue: "95",
          dateTime: DateTime.now(),
          lotteryName: "Lottery2",
        ),
        LotteryModel(
          lotteryValue: "45",
          dateTime: DateTime.now(),
          lotteryName: "Lottery3",
        ),
        LotteryModel(
          lotteryValue: "45",
          dateTime: DateTime.now(),
          lotteryName: "Lottery3",
        ),
      ],
    ),
    LotterBrandModel(
      dateTime: DateTime(2021, 12, 1, 9, 30),
      lottries: [
        LotteryModel(
          lotteryValue: "65",
          dateTime: DateTime.now(),
          lotteryName: "Chetak",
        ),
        LotteryModel(
          lotteryValue: "75",
          dateTime: DateTime.now(),
          lotteryName: "Sangam",
        ),
        LotteryModel(
          lotteryValue: "35",
          dateTime: DateTime.now(),
          lotteryName: "Lottery2",
        ),
        LotteryModel(
          lotteryValue: "95",
          dateTime: DateTime.now(),
          lotteryName: "Lottery3",
        ),
        LotteryModel(
          lotteryValue: "95",
          dateTime: DateTime.now(),
          lotteryName: "Lottery3",
        ),
      ],
    ),
    LotterBrandModel(
      dateTime: DateTime(2021, 12, 1, 10, 00),
      lottries: [
        LotteryModel(
          lotteryValue: "75",
          dateTime: DateTime.now(),
          lotteryName: "Chetak",
        ),
        LotteryModel(
          lotteryValue: "85",
          dateTime: DateTime.now(),
          lotteryName: "Sangam",
        ),
        LotteryModel(
          lotteryValue: "96",
          dateTime: DateTime.now(),
          lotteryName: "Lottery2",
        ),
        LotteryModel(
          lotteryValue: "64",
          dateTime: DateTime.now(),
          lotteryName: "Lottery3",
        ),
        LotteryModel(
          lotteryValue: "64",
          dateTime: DateTime.now(),
          lotteryName: "Lottery3",
        ),
      ],
    ),
    LotterBrandModel(
      dateTime: DateTime(2021, 12, 1, 10, 00),
      lottries: [
        LotteryModel(
          lotteryValue: "78",
          dateTime: DateTime.now(),
          lotteryName: "Chetak",
        ),
        LotteryModel(
          lotteryValue: "98",
          dateTime: DateTime.now(),
          lotteryName: "Sangam",
        ),
        LotteryModel(
          lotteryValue: "36",
          dateTime: DateTime.now(),
          lotteryName: "Lottery2",
        ),
        LotteryModel(
          lotteryValue: "75",
          dateTime: DateTime.now(),
          lotteryName: "Lottery3",
        ),
        LotteryModel(
          lotteryValue: "75",
          dateTime: DateTime.now(),
          lotteryName: "Lottery3",
        ),
      ],
    ),
    LotterBrandModel(
      dateTime: DateTime(2021, 12, 1, 10, 00),
      lottries: [
        LotteryModel(
          lotteryValue: "12",
          dateTime: DateTime.now(),
          lotteryName: "Chetak",
        ),
        LotteryModel(
          lotteryValue: "01",
          dateTime: DateTime.now(),
          lotteryName: "Sangam",
        ),
        LotteryModel(
          lotteryValue: "52",
          dateTime: DateTime.now(),
          lotteryName: "Lottery2",
        ),
        LotteryModel(
          lotteryValue: "69",
          dateTime: DateTime.now(),
          lotteryName: "Lottery3",
        ),
        LotteryModel(
          lotteryValue: "69",
          dateTime: DateTime.now(),
          lotteryName: "Lottery3",
        ),
      ],
    )
  ];
}
