import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xianinfotech_interview/services/customer_service.dart';
import 'package:xianinfotech_interview/services/item_service.dart';
import 'package:xianinfotech_interview/views/add_items_page.dart';
import 'package:xianinfotech_interview/widgets/textfield_widget.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  TextEditingController customerController = TextEditingController();
  TextEditingController billingnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int selectedChip = 0;
  List<Map<String, dynamic>> itemsList = [];
  String currentDate = DateFormat("dd-MM-yyyy").format(DateTime.now());

  void addItem(Map<String, dynamic> item) {
    setState(() {
      itemsList.add(item);
    });
  }

  int getTotalQty() {
    int totalQty = 0;
    for (var item in itemsList) {
      totalQty += int.parse(item['qty']);
    }
    return totalQty;
  }

  int getSubtotal() {
    int subtotal = 0;
    for (var item in itemsList) {
      int qty = int.parse(item['qty']);
      int rate = int.parse(item['rate']);
      subtotal += qty * rate;
    }
    return subtotal;
  }

  int getTotalAmount() {
    int total = 0;
    for (var item in itemsList) {
      int qty = int.parse(item['qty']);
      int rate = int.parse(item['rate']);
      int discount = int.parse(item['discount']);
      int subtotal = qty * rate;
      total += subtotal - (subtotal * discount ~/ 100);
    }
    return total;
  }

  int getTotalDiscount() {
    int totalDiscount = 0;
    for (var item in itemsList) {
      int qty = int.parse(item['qty']);
      int rate = int.parse(item['rate']);
      int discount = int.parse(item['discount']);
      int itemSubtotal = qty * rate;
      totalDiscount += (itemSubtotal * discount ~/ 100);
    }
    return totalDiscount;
  }

  @override
  void dispose() {
    super.dispose();
    customerController.dispose();
    billingnameController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sale"),
        actions: [
          ChoiceChip(
            onSelected: (value) {
              setState(() {
                selectedChip = 0;
              });
            },
            label: const Text("Credit"),
            selected: selectedChip == 0,
            labelStyle: selectedChip == 0
                ? const TextStyle(color: Colors.white)
                : const TextStyle(color: Colors.black),
            showCheckmark: false,
            selectedColor: Colors.green,
          ),
          ChoiceChip(
            onSelected: (value) {
              setState(() {
                selectedChip = 1;
              });
            },
            label: const Text("Cash"),
            selected: selectedChip == 1,
            labelStyle: selectedChip == 1
                ? const TextStyle(color: Colors.white)
                : const TextStyle(color: Colors.black),
            showCheckmark: false,
            selectedColor: Colors.green,
          ),
          const SizedBox(width: 16),
          const Icon(Icons.settings),
          const SizedBox(width: 8)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invoice No",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "23-24-0116",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Date",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        currentDate,
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  Text("Firm Name: "),
                  Text("xianinfotech LLP",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 30),
              TextfieldWidget(
                controller: customerController,
                hint: "Customer",
                label: "Customer",
              ),
              const SizedBox(height: 20),
              TextfieldWidget(
                controller: billingnameController,
                hint: "Billing Name (Optional)",
                label: "Billing Name (Optional)",
              ),
              const SizedBox(height: 20),
              TextfieldWidget(
                controller: phoneController,
                hint: "Phone Number",
                label: "Phone Number",
              ),
              const SizedBox(height: 20),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = itemsList[index];
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item["itemname"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                item["rate"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Item Subtotal"),
                              Text(
                                  "${item['qty']} x ${item['rate']} = ${int.parse(item['qty']) * int.parse(item['rate'])}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Discount(%)"),
                              Text(item['discount']),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: itemsList.length),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Total Discount(%)"),
                Text(getTotalDiscount().toString())
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Qty"),
                  Text(getTotalQty().toString()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Subtotal"),
                  Text(getSubtotal().toString()),
                ],
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      fixedSize:
                          Size.fromWidth(MediaQuery.of(context).size.width)),
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    final newItem = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddItemsPage()));
                    if (newItem != null) {
                      addItem(newItem);
                    }
                  },
                  label: const Text("Add Items (Optional)")),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    getTotalAmount().toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      fixedSize: Size(MediaQuery.sizeOf(context).width, 45),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(),
                      backgroundColor: Colors.blue),
                  onPressed: () {
                    if (customerController.text.isEmpty ||
                        phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please fill all fields")));
                    } else {
                      CustomerService()
                          .addCustomer(
                        customerController.text,
                        getTotalAmount().toString(),
                        getTotalAmount().toString(),
                        "23-24-0116",
                        currentDate,
                        phoneController.text,
                      )
                          .then((customerDocRef) {
                        for (var item in itemsList) {
                          ItemService().addItem(
                            customerDocRef.id,
                            item["itemname"],
                            item["qty"],
                            item["rate"],
                            item["discount"],
                          );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Sale saved successfully")));
                      });
                      Navigator.pop(context);
                      itemsList.clear();
                      customerController.clear();
                      billingnameController.clear();
                      phoneController.clear();
                    }
                  },
                  child: const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}
