import 'package:startlottery/Models/lottery_model.dart';

class LotterBrandModel {
  final DateTime dateTime;
  final List<LotteryModel> lottries;

  LotterBrandModel({
    required this.lottries,
    required this.dateTime,
  });

  // factory LotterBrandModel.fromJSON(
  //     QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
  //   return LotterBrandModel(
  //     lottries: lottries,
  //     dateTime: DateTime.parse(queryDocumentSnapshot.id),
  //   );
  // }
}
