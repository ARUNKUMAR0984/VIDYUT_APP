import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class M_container extends StatelessWidget {
  const M_container({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double padd_left = (MediaQuery.of(context).size.width * 0.05) as double;
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: padd_left),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.50,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
              child: Row(
            children: [
              Text(
                "Hyderabad,500098",
                style: GoogleFonts.manrope(),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
