import 'package:flutter/material.dart';
import 'package:xianinfotech_interview/widgets/textfield_widget.dart';

class AddItemsPage extends StatefulWidget {
  const AddItemsPage({super.key});

  @override
  State<AddItemsPage> createState() => _AddItemsPageState();
}

class _AddItemsPageState extends State<AddItemsPage> {
  TextEditingController itemcontroller = TextEditingController();
  TextEditingController ratecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController discountcontroller = TextEditingController();

  String selectedTax = "Without Tax";
  String selectedUnit = "Unit";
  String documentId = "";

  @override
  void initState() {
    super.initState();
    discountcontroller.text = "0"; // Default value for discount
  }

  @override
  void dispose() {
    itemcontroller.dispose();
    ratecontroller.dispose();
    quantitycontroller.dispose();
    discountcontroller.dispose();
    super.dispose();
  }

  int calculateSubtotal() {
    int rate = int.tryParse(ratecontroller.text) ?? 0;
    int quantity = int.tryParse(quantitycontroller.text) ?? 0;
    return rate * quantity;
  }

  double calculateDiscountAmount() {
    int discountPercentage = int.tryParse(discountcontroller.text) ?? 0;
    int subtotal = calculateSubtotal();
    return subtotal * discountPercentage / 100;
  }

  double calculateTotalAmount() {
    int subtotal = calculateSubtotal();
    double discount = calculateDiscountAmount();
    return subtotal - discount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add Items to Sale"),
        actions: const [
          Icon(Icons.settings),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            TextfieldWidget(
              controller: itemcontroller,
              label: "Item Name",
              hint: "e.g., Chocolate cake",
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: TextfieldWidget(
                    controller: quantitycontroller,
                    label: "Quantity",
                    hint: "Quantity",
                    onchanged: (p0) {
                      setState(() {}); // Trigger UI update on quantity change
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: DropdownButtonFormField(
                    value: selectedUnit,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        child: Text("Unit"),
                        value: "Unit",
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedUnit = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: TextfieldWidget(
                    controller: ratecontroller,
                    label: "Rate (Price/Unit)",
                    hint: "Rate (Price/Unit)",
                    onchanged: (p0) {
                      setState(() {}); // Trigger UI update on rate change
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: DropdownButtonFormField(
                    value: selectedTax,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        child: Text("Without Tax"),
                        value: "Without Tax",
                      ),
                      DropdownMenuItem(
                        child: Text("With Tax"),
                        value: "With Tax",
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedTax = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              "Totals & Taxes",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Subtotal (Rate x Qty)"),
                Text(calculateSubtotal().toString()),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Discount"),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 40,
                  child: TextfieldWidget(
                    controller: discountcontroller,
                    suffixicon: const Icon(Icons.percent),
                    onchanged: (p0) {
                      setState(() {}); // Trigger UI update on discount change
                    },
                  ),
                ),
                Text(calculateDiscountAmount().toStringAsFixed(2)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Amount",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  calculateTotalAmount().toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                fixedSize: Size(MediaQuery.of(context).size.width, 45),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFDD3867),
              ),
              onPressed: () {
                if (itemcontroller.text.isEmpty ||
                    quantitycontroller.text.isEmpty ||
                    ratecontroller.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill all fields"),
                    ),
                  );
                } else {
                  Map<String, dynamic> newItem = {
                    'itemname': itemcontroller.text,
                    'qty': quantitycontroller.text,
                    'rate': ratecontroller.text,
                    'discount': discountcontroller.text.isEmpty
                        ? '0'
                        : discountcontroller.text,
                  };

                  Navigator.pop(context, newItem);
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
