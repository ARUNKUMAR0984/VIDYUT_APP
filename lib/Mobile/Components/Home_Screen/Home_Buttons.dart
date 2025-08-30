import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class M_Home_Button extends StatelessWidget {
  const M_Home_Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                color: Color(0xff1C66F2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "Start Shopping",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
        GestureDetector(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                color: Color(0xff1C66F2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "Become a Seller",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
