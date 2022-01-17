import 'package:cloud_firestore/cloud_firestore.dart';

class BrandsModel {
  final String brandName;
  final DateTime createDate;
  final String id;

  BrandsModel({
    required this.id,
    required this.brandName,
    required this.createDate,
  });

  factory BrandsModel.fromJSON(QueryDocumentSnapshot queryDocumentSnapshot) {
    Map<String, dynamic> data =
        queryDocumentSnapshot.data()! as Map<String, dynamic>;
    Timestamp timestamp = data["createDate"];
    return BrandsModel(
        id: data["id"],
        brandName: data["brandName"],
        createDate: DateTime.fromMicrosecondsSinceEpoch(
            timestamp.microsecondsSinceEpoch));
  }
}
