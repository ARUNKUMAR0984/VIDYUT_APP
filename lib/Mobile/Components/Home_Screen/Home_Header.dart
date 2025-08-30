import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class M_Home_Header extends StatelessWidget {
  const M_Home_Header({super.key});

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width * 0.9;
    final double containerHeight = MediaQuery.of(context).size.height * 0.40;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.shade300,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/Logo/image.png',
                fit: BoxFit.cover,
              ),
            ),
            // Content using Column for responsiveness
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  // Main Text
                  Expanded(
                    child: Center(
                      child: Text(
                        "First Time in India Largest Electricity Information Platform for B2B, D2C and C2C",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 4,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Bottom Text
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      "Produced by Madhu Powertech Private Limited",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 71, 71, 71),
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        shadows: const [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 4,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
