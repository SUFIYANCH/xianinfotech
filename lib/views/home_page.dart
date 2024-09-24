import 'package:flutter/material.dart';
import 'package:xianinfotech_interview/services/customer_service.dart';
import 'package:xianinfotech_interview/views/sale_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe4f0fd),
      appBar: AppBar(
          leading: const Icon(
            Icons.home,
            color: Colors.blue,
          ),
          title: const Text("xianinfotech LLP"),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 2, color: Color(0xfff57593)),
                              borderRadius: BorderRadius.circular(30)),
                          foregroundColor: const Color(0xfff57593),
                          backgroundColor: const Color(0xfffcdbe1),
                          fixedSize: Size.fromWidth(
                              MediaQuery.sizeOf(context).width / 2.22)),
                      onPressed: () {},
                      child: const Text("Transaction Details"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 2, color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(30)),
                          foregroundColor: Colors.grey,
                          fixedSize: Size.fromWidth(
                              MediaQuery.sizeOf(context).width / 2.2)),
                      onPressed: () {},
                      child: const Text("Party Details"),
                    ),
                  ],
                ),
                const SizedBox(height: 8)
              ],
            ),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Quick Links",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.add_box_outlined),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Add Txn",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.receipt_outlined),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Sale Report",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.settings),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Txn Settings",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.arrow_circle_right_outlined),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Show All",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(Icons.search),
                        SizedBox(width: 8),
                        Text("Search for a transaction")
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(Icons.filter_alt_outlined))
                  ]),
            ),
            const SizedBox(height: 12),
            StreamBuilder(
                stream: CustomerService().getCustomers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    final customers = snapshot.data!.docs;
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            customers[index]
                                                .data()
                                                .name
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text("SALE",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green)),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("#23-24-0116",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey)),
                                        Text(
                                            customers[index]
                                                .data()
                                                .date
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                        Text(
                                          customers[index]
                                              .data()
                                              .total
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Balance",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                        Text(
                                          customers[index]
                                              .data()
                                              .balance
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.print_outlined,
                                              color: Colors.grey,
                                            )),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.share_outlined,
                                              color: Colors.grey,
                                            )),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.more_vert_outlined,
                                              color: Colors.grey,
                                            )),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: customers.length);
                  } else {
                    return const Center(child: Text("No sales found"));
                  }
                }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFF3416A),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const StadiumBorder(),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SalePage(),
              ));
        },
        icon: const Icon(Icons.add),
        label: const Text("Add New Sale"),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontSize: 10),
          unselectedLabelStyle: const TextStyle(fontSize: 8),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: "DASHBOARD"),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: "ITEMS"),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "MENU"),
            BottomNavigationBarItem(
                icon: Icon(Icons.workspace_premium_outlined),
                label: "GET PREMIUM"),
          ]),
    );
  }
}
