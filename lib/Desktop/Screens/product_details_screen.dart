import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reviews_screen.dart';
import 'search_products_screen.dart';
import 'home_screen.dart';
import 'browse_brands_screen.dart';
import 'state_info_screen.dart';
import 'cart_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final List<Map<String, dynamic>> allProducts;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.allProducts,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedQuantity = 1;
  int selectedImageIndex = 0;
  bool isFavorite = false;

  // Product images for gallery
  List<String> get productImages => [
        widget.product['image'],
        widget.product['image'],
        widget.product['image'],
        widget.product['image'],
      ];

  // Product specifications
  Map<String, String> get productSpecifications => {
        'Brand': widget.product['seller'],
        'Category': widget.product['category'].toString().toUpperCase(),
        'Material': _getMaterialByCategory(widget.product['category']),
        'Warranty': _getWarrantyByCategory(widget.product['category']),
        'Voltage': _getVoltageByCategory(widget.product['category']),
        'Power Rating': _getPowerRatingByCategory(widget.product['category']),
        'Certification': 'BIS Certified',
        'Country of Origin': 'India',
      };

  // Product reviews
  List<Map<String, dynamic>> get productReviews => [
        {
          'user': 'Rahul Sharma',
          'rating': 5.0,
          'date': '2 days ago',
          'comment': 'Excellent quality product. Fast delivery and great customer service.',
          'verified': true,
        },
        {
          'user': 'Priya Patel',
          'rating': 4.5,
          'date': '1 week ago',
          'comment': 'Good product, works as expected. Would recommend to others.',
          'verified': true,
        },
        {
          'user': 'Amit Kumar',
          'rating': 4.0,
          'date': '2 weeks ago',
          'comment': 'Decent product for the price. Delivery was on time.',
          'verified': false,
        },
      ];

  // Similar products
  List<Map<String, dynamic>> get similarProducts => widget.allProducts
      .where((product) =>
          product['category'] == widget.product['category'] &&
          product['id'] != widget.product['id'])
      .take(4)
      .toList();

  String _getMaterialByCategory(String category) {
    switch (category.toLowerCase()) {
      case 'light':
        return 'LED/Plastic';
      case 'wire':
        return 'Copper/PVC';
      case 'motor':
        return 'Steel/Copper';
      case 'switch':
        return 'Plastic/Metal';
      case 'circuit':
        return 'Plastic/Metal';
      case 'panel':
        return 'Steel/Plastic';
      case 'tool':
        return 'Steel/Plastic';
      case 'safety':
        return 'Rubber/Plastic';
      case 'transformer':
        return 'Steel/Copper';
      case 'conduit':
        return 'PVC/Metal';
      default:
        return 'Standard';
    }
  }

  String _getWarrantyByCategory(String category) {
    switch (category.toLowerCase()) {
      case 'light':
        return '2 Years';
      case 'wire':
        return '5 Years';
      case 'motor':
        return '3 Years';
      case 'switch':
        return '1 Year';
      case 'circuit':
        return '2 Years';
      case 'panel':
        return '3 Years';
      case 'tool':
        return '1 Year';
      case 'safety':
        return '2 Years';
      case 'transformer':
        return '5 Years';
      case 'conduit':
        return '3 Years';
      default:
        return '1 Year';
    }
  }

  String _getVoltageByCategory(String category) {
    switch (category.toLowerCase()) {
      case 'light':
        return '220V AC';
      case 'wire':
        return '440V AC';
      case 'motor':
        return '415V AC';
      case 'switch':
        return '240V AC';
      case 'circuit':
        return '415V AC';
      case 'panel':
        return '415V AC';
      case 'tool':
        return '220V AC';
      case 'safety':
        return '240V AC';
      case 'transformer':
        return '11kV/415V';
      case 'conduit':
        return 'N/A';
      default:
        return '220V AC';
    }
  }

  String _getPowerRatingByCategory(String category) {
    switch (category.toLowerCase()) {
      case 'light':
        return '9W LED';
      case 'wire':
        return '2.5 sq.mm';
      case 'motor':
        return '5 HP';
      case 'switch':
        return '16A';
      case 'circuit':
        return '32A';
      case 'panel':
        return '100A';
      case 'tool':
        return '1000W';
      case 'safety':
        return 'N/A';
      case 'transformer':
        return '100kVA';
      case 'conduit':
        return 'N/A';
      default:
        return 'Standard';
    }
  }

  final Map<String, String> _sellerPhoneMap = const {
    'ElectroMart': '+919999000001',
    'Power Solutions': '+919999000002',
    'Cable World': '+919999000003',
    'Electrical Store': '+919999000004',
    'Fan Hub': '+919999000005',
    'Wire Solutions': '+919999000006',
    'Bright Lights Co': '+919999000007',
    'Starlite': '+919999000008',
    'Breaker Mart': '+919999000009',
    'Conduit Depot': '+919999000010',
    'Tool House': '+919999000011',
    'Motor Sales': '+919999000012',
    'Panel Point': '+919999000013',
    'SecureWear': '+919999000014',
    'Solar Shop': '+919999000015',
  };

  final Map<String, String> _sellerWebsiteMap = const {
    'ElectroMart': 'https://electromart.com/',
    'Power Solutions': 'https://www.powersolutions.co.in/',
    'Cable World': 'https://example.com/cable-world',
    'Electrical Store': 'https://example.com/electrical-store',
    'Fan Hub': 'https://example.com/fan-hub',
    'Wire Solutions': 'https://example.com/wire-solutions',
    'Bright Lights Co': 'https://example.com/bright-lights',
    'Starlite': 'https://example.com/starlite',
    'Breaker Mart': 'https://example.com/breaker-mart',
    'Conduit Depot': 'https://example.com/conduit-depot',
    'Tool House': 'https://example.com/tool-house',
    'Motor Sales': 'https://example.com/motor-sales',
    'Panel Point': 'https://example.com/panel-point',
    'SecureWear': 'https://example.com/securewear',
    'Solar Shop': 'https://example.com/solar-shop',
  };

  String _phoneForSeller() {
    final String seller = (widget.product['seller'] ?? '').toString();
    final String phone = (widget.product['phone'] ?? _sellerPhoneMap[seller] ?? '+911234567890').toString();
    return phone;
  }

  void _contactSeller() {
    launchUrl(Uri.parse('tel:${_phoneForSeller()}'));
  }

  void _launchWhatsApp() {
    final String message = Uri.encodeComponent('Hi, I am interested in ${widget.product['name']}');
    final Uri wa = Uri.parse('https://wa.me/${_phoneForSeller().replaceAll('+', '')}?text=$message');
    launchUrl(wa, mode: LaunchMode.externalApplication);
  }

  Widget _buildNavItem(IconData icon, String title, {bool isActive = false, String? badge}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: ListTile(
        leading: Stack(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.blue[800] : Colors.grey[600],
              size: 24,
            ),
            if (badge != null)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    badge,
                    style: GoogleFonts.manrope(
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
          style: GoogleFonts.manrope(
            color: isActive ? Colors.blue[800] : Colors.grey[700],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        onTap: () {
          if (title == 'Home') {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const D_HomeScreen()),
              (route) => false,
            );
          } else if (title == 'Search Products') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
            );
          } else if (title == 'Browse Brands') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const D_BrowseBrandsScreen()),
            );
          } else if (title == 'State Info') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const D_StateInfoScreen()),
            );
          } else if (title == 'Shopping Cart') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Row(
        children: [
          // Left Sidebar Navigation
          Container(
            width: 280,
            color: Colors.white,
            child: Column(
              children: [
                // Logo Section
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'V',
                            style: GoogleFonts.manrope(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Vidyut Nidhi',
                        style: GoogleFonts.manrope(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: GoogleFonts.manrope(color: Colors.grey[500]),
                      prefixIcon: Icon(Ionicons.search_outline, color: Colors.blue[800]),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close, color: Colors.grey[600]),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Navigation Links
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildNavItem(Ionicons.home_outline, 'Home'),
                        _buildNavItem(Ionicons.search_outline, 'Search Products'),
                        _buildNavItem(Icons.branding_watermark, 'Browse Brands'),
                        _buildNavItem(Ionicons.cart_outline, 'Shopping Cart', badge: '3'),
                        _buildNavItem(Ionicons.bag_outline, 'My Orders', badge: '3'),
                        _buildNavItem(Ionicons.storefront_outline, 'Sell'),
                        _buildNavItem(Ionicons.chatbubbles_outline, 'Messages'),
                        _buildNavItem(Ionicons.location_outline, 'State Info'),
                        _buildNavItem(Icons.trending_up, 'Trending'),
                        
                        const SizedBox(height: 30),
                        
                        // Account Section
                        _buildNavItem(Icons.login, 'Sign In'),
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey[400],
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Guest User',
                                  style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Sign in for better experience',
                                  style: GoogleFonts.manrope(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[800],
                                foregroundColor: Colors.white,
                                textStyle: GoogleFonts.manrope(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text('Sign In'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.blue[800],
                                side: BorderSide(color: Colors.blue[800]!),
                                textStyle: GoogleFonts.manrope(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text('Sign Up'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          '← Back to Products',
                          style: GoogleFonts.manrope(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
                      const SizedBox(width: 8),
                      Text(
                        widget.product['category'].toString().toUpperCase(),
                        style: GoogleFonts.manrope(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
                      const SizedBox(width: 8),
                      Text(
                        widget.product['name'],
                        style: GoogleFonts.manrope(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Product Gallery and Info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Images
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            // Main Image
                            Container(
                              height: 400,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  productImages[selectedImageIndex],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[100],
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 80,
                                        color: Colors.grey[400],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 20),
                            
                            // Thumbnail Images
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                productImages.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImageIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: selectedImageIndex == index
                                            ? Colors.blue[800]!
                                            : Colors.grey[200]!,
                                        width: selectedImageIndex == index ? 2 : 1,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        productImages[index],
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[100],
                                            child: Icon(
                                              Icons.image_not_supported,
                                              size: 30,
                                              color: Colors.grey[400],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 40),
                      
                      // Product Information
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Title
                            Text(
                              widget.product['name'],
                              style: GoogleFonts.manrope(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Brand
                            Row(
                              children: [
                                Text(
                                  'by ',
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      final String seller = (widget.product['seller'] ?? '').toString();
                                      final String url = _sellerWebsiteMap[seller] ?? 'https://example.com';
                                      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                                    },
                                    child: Text(
                                      widget.product['seller'],
                                      style: GoogleFonts.manrope(
                                        fontSize: 16,
                                        color: const Color(0xFF1D4ED8),
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Rating
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < 4 ? Icons.star : Icons.star_border,
                                      color: Colors.amber,
                                      size: 20,
                                    );
                                  }),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '4.0',
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '(128 reviews)',
                                  style: GoogleFonts.manrope(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Price
                            Row(
                              children: [
                                Text(
                                  '₹${widget.product['price'].toString().replaceAll('₹', '')}',
                                  style: GoogleFonts.manrope(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '₹${(double.parse(widget.product['price'].replaceAll(RegExp(r'[^\d.]'), '')) * 1.2).round()}',
                                  style: GoogleFonts.manrope(
                                    fontSize: 18,
                                    color: Colors.grey[500],
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '20% OFF',
                                    style: GoogleFonts.manrope(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Service Guarantees
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue[200]!),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.verified, color: Colors.blue[800], size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Service Guarantees',
                                        style: GoogleFonts.manrope(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(Icons.local_shipping, color: Colors.green[600], size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Free Delivery',
                                              style: GoogleFonts.manrope(
                                                fontSize: 12,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(Icons.assignment_return, color: Colors.orange[600], size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Easy Returns',
                                              style: GoogleFonts.manrope(
                                                fontSize: 12,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(Icons.security, color: Colors.green[600], size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Genuine Product',
                                              style: GoogleFonts.manrope(
                                                fontSize: 12,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(Icons.support_agent, color: Colors.blue[600], size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              '24/7 Support',
                                              style: GoogleFonts.manrope(
                                                fontSize: 12,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Quantity Selector
                            Text(
                              'Quantity',
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]!),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (selectedQuantity > 1) {
                                            setState(() {
                                              selectedQuantity--;
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.remove, color: Colors.blue[800]),
                                      ),
                                      Container(
                                        width: 50,
                                        alignment: Alignment.center,
                                        child: Text(
                                          selectedQuantity.toString(),
                                          style: GoogleFonts.manrope(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedQuantity++;
                                          });
                                        },
                                        icon: Icon(Icons.add, color: Colors.blue[800]),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '${widget.product['stock']} available',
                                  style: GoogleFonts.manrope(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 32),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: _contactSeller,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.blue[800],
                                      side: BorderSide(color: Colors.blue[800]!),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      textStyle: GoogleFonts.manrope(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('Contact Seller'),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _launchWhatsApp,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF25D366),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      textStyle: GoogleFonts.manrope(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('WhatsApp'),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return WriteReviewDialog(product: widget.product);
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                  label: Text(
                                    'Write a Review',
                                    style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                    side: BorderSide(color: Colors.blue[800]!),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Specifications Section
                  Text(
                    'Specifications',
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: productSpecifications.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  entry.key,
                                  style: GoogleFonts.manrope(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  entry.value,
                                  style: GoogleFonts.manrope(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Description Section
                  Text(
                    'Description',
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Text(
                      (widget.product['description'] ?? 'No description available.') as String,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: Colors.grey[800],
                        height: 1.6,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Customer Reviews Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Customer Reviews',
                        style: GoogleFonts.manrope(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewsScreen(product: widget.product),
                            ),
                          );
                        },
                        child: Text(
                          'View All Reviews',
                          style: GoogleFonts.manrope(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: productReviews.map((review) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue[100],
                                    child: Text(
                                      review['user'][0],
                                      style: GoogleFonts.manrope(
                                        color: Colors.blue[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              review['user'],
                                              style: GoogleFonts.manrope(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            if (review['verified'])
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.green[50],
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  'Verified',
                                                  style: GoogleFonts.manrope(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green[700],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Row(
                                              children: List.generate(5, (index) {
                                                return Icon(
                                                  index < review['rating'] ? Icons.star : Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 16,
                                                );
                                              }),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              review['date'],
                                              style: GoogleFonts.manrope(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                review['comment'],
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Similar Products Section
                  Text(
                    'SIMILAR PRODUCTS YOU MIGHT LIKE',
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: similarProducts.length,
                    itemBuilder: (context, index) {
                      final product = similarProducts[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  color: Colors.grey[100],
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: Image.asset(
                                    product['image'],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[100],
                                        child: Icon(
                                          Icons.image_not_supported,
                                          size: 40,
                                          color: Colors.grey[400],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    style: GoogleFonts.manrope(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '₹${product['price']}',
                                    style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetailsScreen(
                                              product: product,
                                              allProducts: widget.allProducts,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue[800],
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        textStyle: GoogleFonts.manrope(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                      child: const Text('View Product'),
                                    ),
                                  ),
                                ],
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

class WriteReviewDialog extends StatefulWidget {
  final Map<String, dynamic> product;
  
  const WriteReviewDialog({
    super.key,
    required this.product,
  });

  @override
  State<WriteReviewDialog> createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends State<WriteReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _commentController = TextEditingController();
  int _rating = 0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Text(
                    'Write a Review',
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Product Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.image,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product['name'],
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[900],
                            ),
                          ),
                          Text(
                            widget.product['description'],
                            style: GoogleFonts.manrope(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Rating
              Text(
                'Your Rating',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    child: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                  );
                }),
              ),
              
              const SizedBox(height: 24),
              
              // Review Title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Review Title',
                  labelStyle: GoogleFonts.manrope(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a review title';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Review Comment
              TextFormField(
                controller: _commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Your Review',
                  labelStyle: GoogleFonts.manrope(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please write your review';
                  }
                  if (value.length < 10) {
                    return 'Review must be at least 10 characters long';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              
              // Submit Button
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitReview,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Submit Review',
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitReview() {
    if (_formKey.currentState!.validate() && _rating > 0) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate review submission
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isSubmitting = false;
        });
        
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Thank you for your review!', style: GoogleFonts.manrope()),
            backgroundColor: Colors.green[600],
          ),
        );
      });
    } else if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a rating', style: GoogleFonts.manrope()),
          backgroundColor: Colors.red[600],
        ),
      );
    }
  }
}
