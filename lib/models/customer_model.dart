import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  String? name;
  String? invoice;
  String? date;
  String? total;
  String? balance;
  String? phone;

  CustomerModel(
      {required this.name,
      this.invoice,
      this.date,
      this.total,
      this.balance,
      this.phone});

  factory CustomerModel.fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CustomerModel(
      name: data?["name"],
      invoice: data?["invoice"],
      date: data?["date"],
      total: data?["total"],
      balance: data?["balance"],
      phone: data?["phone"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "invoice": invoice,
      "date": date,
      "total": total,
      "balance": balance,
      "phone": phone
    };
  }
}
