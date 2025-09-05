import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'home_screen.dart';
import 'search_products_screen.dart';
import 'browse_brands_screen.dart';
import 'state_info_screen.dart';
import 'power_generator_screen.dart';
import 'transmission_line_screen.dart';

class D_CompanyDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> company;
  
  const D_CompanyDetailsScreen({
    super.key,
    required this.company,
  });

  @override
  State<D_CompanyDetailsScreen> createState() => _D_CompanyDetailsScreenState();
}

class _D_CompanyDetailsScreenState extends State<D_CompanyDetailsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _sidebarSearchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _sidebarSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Column(
              children: [
                // Logo Section
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.flash_on,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Vidyut',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    controller: _sidebarSearchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Ionicons.search_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Navigation Links
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildNavItem(Ionicons.home_outline, 'Home'),
                        _buildNavItem(Ionicons.search_outline, 'Search Products'),
                        _buildNavItem(Icons.branding_watermark, 'Browse Brands'),
                        _buildNavItem(Ionicons.bag_outline, 'My Orders', badge: '3'),
                        _buildNavItem(Ionicons.storefront_outline, 'Sell'),
                        _buildNavItem(Ionicons.chatbubbles_outline, 'Messages'),
                        _buildNavItem(Ionicons.location_outline, 'State Info', isActive: true),
                        _buildNavItem(Icons.trending_up, 'Trending'),
                        
                        const SizedBox(height: 30),
                        
                        // Account Section
                        _buildNavItem(Ionicons.settings_outline, 'Settings'),
                        _buildNavItem(Icons.help, 'Help'),
                      ],
                    ),
                  ),
                ),
                
                // User Profile
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.red[600],
                        child: const Text(
                          'N',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'John Doe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'john@example.com',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Main Content
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Logo
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.purple[600],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.flash_on,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Vidyut',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        
                        const SizedBox(width: 20),
                        
                        // Main Search Bar
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search products...',
                              prefixIcon: const Icon(Ionicons.search_outline),
                              suffixIcon: Container(
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Ionicons.grid_outline,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 20),
                        
                        // Location
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Ionicons.location_outline, color: Colors.grey[600]),
                              const SizedBox(width: 8),
                              const Text('Deliver to: Set location'),
                            ],
                          ),
                        ),
                        
                        const SizedBox(width: 20),
                        
                        // Icons
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Ionicons.heart_outline_border),
                          onPressed: () {},
                        ),
                        
                        const SizedBox(width: 20),
                        
                        // Buttons
                        TextButton(
                          onPressed: () {},
                          child: const Text('Sign In'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Sign Up'),
                        ),
                        
                        const SizedBox(width: 20),
                        
                        // User Avatar
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue[600],
                          child: const Text(
                            'JD',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Main Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Navigation and Step Indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left Navigation
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const D_PowerGeneratorScreen()),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_back,
                                          color: Colors.blue[600],
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '← Back',
                                          style: TextStyle(
                                            color: Colors.blue[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const D_TransmissionLineScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Next: Transmission',
                                      style: TextStyle(
                                        color: Colors.blue[600],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  Text(
                                    'Start Over',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              
                              // Right Step Indicator
                              Row(
                                children: [
                                  for (int i = 1; i <= 6; i++) ...[
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: i == 1 ? Colors.green[600] : 
                                               i == 2 ? Colors.blue[600] : Colors.grey[300],
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$i',
                                          style: TextStyle(
                                            color: i <= 2 ? Colors.white : Colors.grey[600],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (i < 6) ...[
                                      const SizedBox(width: 8),
                                    ],
                                  ],
                                ],
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Company Overview Card (Blue Section)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: Colors.blue[600],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                // Center Icon
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey[600],
                                    size: 40,
                                  ),
                                ),
                                
                                const SizedBox(height: 24),
                                
                                // Company Name
                                Text(
                                  widget.company['name'],
                                  style: const TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                
                                const SizedBox(height: 16),
                                
                                // Subtitle
                                Text(
                                  'India\'s largest power generation company, committed to providing reliable and affordable electricity.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(0.9),
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                
                                const SizedBox(height: 32),
                                
                                // Bottom Tags
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildTag(Icons.power, widget.company['capacity']),
                                    const SizedBox(width: 24),
                                    _buildTag(Ionicons.location_outline, widget.company['location']),
                                    const SizedBox(width: 24),
                                    _buildTag(Ionicons.person_outline, widget.company['units']),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Company Website Link
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.language,
                                  color: Colors.blue[600],
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Website: www.ntpc.co.in',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Company Statistics Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.analytics,
                                    color: Colors.blue[600],
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Company Statistics',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 20),
                              
                              Row(
                                children: [
                                  // Total Plants Card
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.blue[200]!),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            '24',
                                            style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[700],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Total Plants',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  
                                  const SizedBox(width: 16),
                                  
                                  // Employees Card
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        color: Colors.green[50],
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.green[200]!),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            '18,000+',
                                            style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green[700],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Employees',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.green[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  
                                  const SizedBox(width: 16),
                                  
                                  // Annual Revenue Card
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        color: Colors.purple[50],
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.purple[200]!),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            '₹1,15,000 Crore',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple[700],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Annual Revenue',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.purple[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Detailed Information Sections
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Column: Company Information
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(32),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.business,
                                            color: Colors.blue[600],
                                            size: 24,
                                          ),
                                          const SizedBox(width: 12),
                                          const Text(
                                            'Company Information',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      
                                      const SizedBox(height: 24),
                                      
                                      // Details
                                      _buildInfoRow(Icons.calendar_today, 'Established: 1975'),
                                      _buildInfoRow(Ionicons.person_outline, 'Founder: Government of India'),
                                      _buildInfoRow(Ionicons.location_outline, 'Headquarters: New Delhi, India'),
                                      _buildInfoRow(Icons.phone, 'Phone: +91-11-2345-6789'),
                                      _buildInfoRow(Icons.email, 'Email: info@ntpc.co.in'),
                                    ],
                                  ),
                                ),
                              ),
                              
                              const SizedBox(width: 24),
                              
                              // Right Column: CEO Profile
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(32),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Row(
                                        children: [
                                          Icon(
                                            Ionicons.person_outline,
                                            color: Colors.blue[600],
                                            size: 24,
                                          ),
                                          const SizedBox(width: 12),
                                          const Text(
                                            'CEO Profile',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      
                                      const SizedBox(height: 24),
                                      
                                      // CEO Avatar
                                      Center(
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.grey[600],
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                      
                                      const SizedBox(height: 16),
                                      
                                      // CEO Name
                                      const Center(
                                        child: Text(
                                          'Mr. Gurdeep Singh',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      
                                      const SizedBox(height: 8),
                                      
                                      // CEO Title
                                      Center(
                                        child: Text(
                                          'Chief Executive Officer',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Company Updates & Announcements Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.newspaper,
                                    color: Colors.blue[600],
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Company Updates & Announcements',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 20),
                              
                              // Update Card
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.grey[200]!),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Company Info Row
                                    Row(
                                      children: [
                                        // Company Logo Placeholder
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.grey[600],
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.company['name'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Text(
                                                '1 day ago',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Achievement Badge
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.blue[600],
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: const Text(
                                            'achievement',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    const SizedBox(height: 16),
                                    
                                    // Announcement Title
                                    const Text(
                                      'NTPC Achieves 100% Plant Load Factor',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    
                                    const SizedBox(height: 8),
                                    
                                    // Announcement Description
                                    Text(
                                      'NTPC has achieved 100% Plant Load Factor across all its thermal power plants, setting a new benchmark in the industry.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                        height: 1.4,
                                      ),
                                    ),
                                    
                                    const SizedBox(height: 16),
                                    
                                    // Image Placeholder
                                    Container(
                                      width: double.infinity,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.grey[600],
                                        size: 48,
                                      ),
                                    ),
                                    
                                    const SizedBox(height: 16),
                                    
                                    // Interaction Row
                                    Row(
                                      children: [
                                        // Likes
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.thumb_up,
                                              color: Colors.grey[600],
                                              size: 18,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              '156',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        
                                        const Spacer(),
                                        
                                        // Comments
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.chat_bubble_outline,
                                              color: Colors.grey[600],
                                              size: 18,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              '34',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show support dialog or navigate to support
        },
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.chat_bubble_outline),
        label: const Text('Support'),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, {bool isActive = false, String? badge}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Stack(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.blue[600] : Colors.grey[600],
            ),
            if (badge != null)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.blue[600] : Colors.grey[600],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        tileColor: isActive ? Colors.blue[50] : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          if (title == 'Home') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_HomeScreen()),
            );
          } else if (title == 'Search Products') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
            );
          } else if (title == 'Browse Brands') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_BrowseBrandsScreen()),
            );
          } else if (title == 'State Info') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_StateInfoScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey[600],
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
