import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidyut_app/Mobile/Components/Home_Screen/Home_Buttons.dart';
import 'package:vidyut_app/Mobile/Components/Home_Screen/Home_Header.dart';
import 'package:vidyut_app/Mobile/Components/Home_Screen/Home_categories.dart';
import 'package:vidyut_app/Mobile/Components/container.dart';

import '../Components/Home_Screen/Home_bottom.dart';

class M_HomeScreen extends StatefulWidget {
  const M_HomeScreen({super.key});

  @override
  State<M_HomeScreen> createState() => _M_HomeScreenState();
}

class _M_HomeScreenState extends State<M_HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        titleSpacing: 0,
        title: Text(
          "Vidyut Nidhi",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black87),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            M_container(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            M_Home_Header(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            M_Home_Button(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Browse Categories",
                    style: GoogleFonts.inter(
                        fontSize: 25, fontWeight: FontWeight.w600)),
              ),
            ),
            M_Home_Categories(),
          ],
        ),
      ),
      bottomNavigationBar: M_BottomNavBar(),
    );
  }
}
