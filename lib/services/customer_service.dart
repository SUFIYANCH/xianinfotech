import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xianinfotech_interview/models/customer_model.dart';

class CustomerService {
  final CollectionReference<CustomerModel> customerCollection =
      FirebaseFirestore.instance.collection("customers").withConverter(
            fromFirestore: CustomerModel.fromFirebase,
            toFirestore: (CustomerModel value, options) => value.toFirestore(),
          );
  Future<DocumentReference<CustomerModel>> addCustomer(
    String name,
    String balance,
    String total,
    String invoice,
    String date,
    String phone,
  ) {
    return customerCollection.add(CustomerModel(
        name: name,
        balance: balance,
        total: total,
        invoice: invoice,
        phone: phone,
        date: date));
  }

  Stream<QuerySnapshot<CustomerModel>> getCustomers() {
    return customerCollection.snapshots();
  }
}
