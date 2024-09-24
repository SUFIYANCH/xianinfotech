import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? itemname;
  String? qty;
  String? rate;
  String? discount;

  ItemModel({this.itemname, this.qty, this.rate, this.discount});

  factory ItemModel.fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ItemModel(
      itemname: data?["itemname"],
      qty: data?["qty"],
      rate: data?["rate"],
      discount: data?["discount"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "itemname": itemname,
      "qty": qty,
      "rate": rate,
      "discount": discount
    };
  }
}
