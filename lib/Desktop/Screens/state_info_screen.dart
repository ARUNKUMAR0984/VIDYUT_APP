import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/responsive_helper.dart';
import '../Components/unified_navigation.dart';

class D_StateInfoScreen extends StatefulWidget {
  const D_StateInfoScreen({super.key});

  @override
  State<D_StateInfoScreen> createState() => _D_StateInfoScreenState();
}

class _D_StateInfoScreenState extends State<D_StateInfoScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedState = 'All States';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // Unified Navigation
          UnifiedNavigation(
            currentPage: 'state',
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
                    'Power Infrastructure',
                    style: GoogleFonts.manrope(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 24, tablet: 28, desktop: 32),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Monitor power generation, transmission, and distribution across states',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Flow Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildFlowCard(
                          'Power Generation Flow',
                          'Explore the complete power supply chain from generation to distribution',
                          'Generator → Transmission → Distribution → Profile',
                          Icons.power_settings_new,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildFlowCard(
                          'State-Based Flow',
                          'Browse electricity information by state and explore mandal-level details',
                          'State → Districts → Mandals → Details',
                          Icons.map_outlined,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
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
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search power infrastructure by state...',
                        hintStyle: GoogleFonts.manrope(color: const Color(0xFF94A3B8)),
                        prefixIcon: const Icon(Ionicons.search_outline, color: Color(0xFF64748B)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // States Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper.getResponsiveColumns(context, mobile: 2, tablet: 3, desktop: 4),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: states.length,
                    itemBuilder: (context, index) {
                      final state = states[index];
                      return _buildStateCard(state);
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

  Widget _buildStateCard(Map<String, dynamic> state) {
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
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Ionicons.location_outline,
              color: const Color(0xFF3B82F6),
              size: 30,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            state['name'],
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            '${state['districts']} districts',
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              state['status'],
              style: GoogleFonts.manrope(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF10B981),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sample states data
  final List<Map<String, dynamic>> states = [
    {
      'name': 'Maharashtra',
      'districts': 36,
      'status': 'Active',
      'capital': 'Mumbai',
      'population': '11.4 Cr',
    },
    {
      'name': 'Delhi',
      'districts': 11,
      'status': 'Active',
      'capital': 'New Delhi',
      'population': '2.0 Cr',
    },
    {
      'name': 'Karnataka',
      'districts': 31,
      'status': 'Active',
      'capital': 'Bangalore',
      'population': '6.7 Cr',
    },
    {
      'name': 'Tamil Nadu',
      'districts': 38,
      'status': 'Active',
      'capital': 'Chennai',
      'population': '7.7 Cr',
    },
    {
      'name': 'Gujarat',
      'districts': 33,
      'status': 'Active',
      'capital': 'Gandhinagar',
      'population': '6.3 Cr',
    },
    {
      'name': 'Rajasthan',
      'districts': 33,
      'status': 'Active',
      'capital': 'Jaipur',
      'population': '7.3 Cr',
    },
    {
      'name': 'Uttar Pradesh',
      'districts': 75,
      'status': 'Active',
      'capital': 'Lucknow',
      'population': '20.4 Cr',
    },
    {
      'name': 'Punjab',
      'districts': 23,
      'status': 'Active',
      'capital': 'Chandigarh',
      'population': '2.8 Cr',
    },
    {
      'name': 'Haryana',
      'districts': 22,
      'status': 'Active',
      'capital': 'Chandigarh',
      'population': '2.5 Cr',
    },
    {
      'name': 'Kerala',
      'districts': 14,
      'status': 'Active',
      'capital': 'Thiruvananthapuram',
      'population': '3.5 Cr',
    },
    {
      'name': 'Telangana',
      'districts': 33,
      'status': 'Active',
      'capital': 'Hyderabad',
      'population': '3.5 Cr',
    },
    {
      'name': 'Andhra Pradesh',
      'districts': 26,
      'status': 'Active',
      'capital': 'Amaravati',
      'population': '4.9 Cr',
    },
  ];

  Widget _buildFlowCard(String title, String description, String flowPath, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Add navigation logic here
        print('Tapped on $title');
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon at the top center
            Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Title
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            // Description
            Text(
              description,
              style: GoogleFonts.manrope(
                fontSize: 14,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Flow path with arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  flowPath,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  color: color,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
