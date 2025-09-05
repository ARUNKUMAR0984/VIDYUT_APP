import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/responsive_helper.dart';
import '../Components/unified_navigation.dart';

class BrowseBrandScreen extends StatelessWidget {
  const BrowseBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // Unified Navigation
          UnifiedNavigation(
            currentPage: 'brand',
            isMobile: ResponsiveHelper.isMobile(context),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 20, desktop: 24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Browse Brands',
                    style: GoogleFonts.manrope(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 24, tablet: 28, desktop: 32),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Discover top electrical brands and their products',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Brands Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper.getResponsiveColumns(context, mobile: 2, tablet: 3, desktop: 4),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      final brands = [
                        {'name': 'Philips', 'logo': 'assets/images/brands/philips.png', 'products': 45},
                        {'name': 'Havells', 'logo': 'assets/images/brands/havells.png', 'products': 38},
                        {'name': 'Crompton', 'logo': 'assets/images/brands/crompton.png', 'products': 42},
                        {'name': 'Bajaj', 'logo': 'assets/images/brands/bajaj.png', 'products': 35},
                        {'name': 'Anchor', 'logo': 'assets/images/brands/anchor.png', 'products': 28},
                        {'name': 'Finolex', 'logo': 'assets/images/brands/finolex.png', 'products': 31},
                        {'name': 'Polycab', 'logo': 'assets/images/brands/polycab.png', 'products': 33},
                        {'name': 'Legrand', 'logo': 'assets/images/brands/legrand.png', 'products': 26},
                        {'name': 'Schneider', 'logo': 'assets/images/brands/schneider.png', 'products': 29},
                        {'name': 'Syska', 'logo': 'assets/images/brands/syska.png', 'products': 22},
                        {'name': 'Wipro', 'logo': 'assets/images/brands/wipro.png', 'products': 25},
                        {'name': 'Orient', 'logo': 'assets/images/brands/orient.png', 'products': 19},
                      ];
                      
                      final brand = brands[index % brands.length];
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFF1F5F9),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1E293B).withOpacity(0.04),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.business,
                                color: const Color(0xFF64748B),
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              brand['name'] as String,
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${brand['products']} products',
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

