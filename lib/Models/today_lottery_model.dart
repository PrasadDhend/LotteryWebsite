import 'package:cloud_firestore/cloud_firestore.dart';

class TodayLotteryModel {
  final DateTime dateTime;
  final String id;

  TodayLotteryModel({required this.dateTime, required this.id});

  factory TodayLotteryModel.fromJSON(
      QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
    return TodayLotteryModel(
        dateTime: DateTime.parse(queryDocumentSnapshot.data()["id"]),
        id: queryDocumentSnapshot.data()["id"]);
  }
}
