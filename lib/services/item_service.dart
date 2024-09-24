import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xianinfotech_interview/models/customer_model.dart';
import 'package:xianinfotech_interview/models/items_model.dart';

class ItemService {
  final CollectionReference<CustomerModel> customerCollection =
      FirebaseFirestore.instance.collection("customers").withConverter(
            fromFirestore: CustomerModel.fromFirebase,
            toFirestore: (CustomerModel value, options) => value.toFirestore(),
          );

  Stream<QuerySnapshot<ItemModel>> getItems(String customerid) {
    return customerCollection
        .doc(customerid)
        .collection("items")
        .withConverter(
          fromFirestore: ItemModel.fromFirebase,
          toFirestore: (ItemModel items, options) => items.toFirestore(),
        )
        .snapshots();
  }

  Stream<DocumentSnapshot<ItemModel>> getItem(
      String customerid, String itemId) {
    return customerCollection
        .doc(customerid)
        .collection("items")
        .withConverter(
          fromFirestore: ItemModel.fromFirebase,
          toFirestore: (ItemModel item, options) => item.toFirestore(),
        )
        .doc(itemId)
        .snapshots();
  }

  Future<DocumentReference<ItemModel>> addItem(String customerid, String name,
      String qty, String rate, String discount) {
    return customerCollection
        .doc(customerid)
        .collection("items")
        .withConverter(
          fromFirestore: ItemModel.fromFirebase,
          toFirestore: (ItemModel item, options) => item.toFirestore(),
        )
        .add(ItemModel(
            itemname: name, qty: qty, rate: rate, discount: discount));
  }
}
