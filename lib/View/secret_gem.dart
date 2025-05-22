import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
import 'package:silm_track_app_new/Resources/BottomNavBar/bottomnavbar.dart';

class SecretGem extends StatefulWidget {
  const SecretGem({super.key});

  @override
  State<SecretGem> createState() => _SecretGemState();
}

class _SecretGemState extends State<SecretGem> {
  final auth = FirebaseAuth.instance;
  int initialTabIndex = 0;
  int dataLength = 0;

  @override
  void initState() {
    super.initState();
    _getDataLength();
  }

  Future<void> _getDataLength() async {
    final userId = auth.currentUser!.uid;
    final fireStore = FirebaseFirestore.instance
        .collection("routine_foods")
        .doc(userId)
        .collection("data");

    final snapshot = await fireStore.get();
    setState(() {
      dataLength = snapshot.docs.length;

      if (dataLength > 35) {
        initialTabIndex = 2; // Week 5 & 6
      } else if (dataLength > 18) {
        initialTabIndex = 1; // Week 3 & 4
      } else {
        initialTabIndex = 0; // Week 1 & 2
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TableRow tableRow = const TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Protein",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "State",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "(g)",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Micronutrients(Calories)",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.lite_20_green,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset("assets/images/splash_image.png"),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'This is a sample paragraph created for test purposes. It contains exactly fifty words, '
                'which makes it suitable for use in any Flutter application.',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 3,
                initialIndex: initialTabIndex,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: "Week 1 & 2"),
                        Tab(text: "Week 3 & 4"),
                        Tab(text: "Week 5 & 6"),
                      ],
                      indicatorColor: AppColors.lite_green,
                      labelColor: Colors.black,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildWeekTab(tableRow),
                          _buildWeek3And4Tab(tableRow),
                          _buildWeek5And6Tab(tableRow),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  Widget _buildWeekTab(TableRow tableRow) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.check_box_outlined, color: AppColors.lite_green),
                SizedBox(width: 10),
                Text(
                  "Unlimited access to all features",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(40),
              elevation: 10,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(color: AppColors.lite_green),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Table(
                children: <TableRow>[
                  tableRow,
                  tableRow,
                  tableRow,
                  tableRow,
                  tableRow,
                  tableRow,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeek3And4Tab(TableRow tableRow) {
    if (dataLength > 14) {
      return _buildWeekTab(tableRow);
    } else {
      return const Center(child: Text("Complete Week 1 & 2"));
    }
  }

  Widget _buildWeek5And6Tab(TableRow tableRow) {
    if (dataLength > 35) {
      return _buildWeekTab(tableRow);
    } else {
      return const Center(child: Text("Complete Week 3 & 4"));
    }
  }
}
