import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_products_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';
import 'checkout_screen.dart';
import 'notifications_screen.dart';
import 'seller_dashboard_screen.dart';
import 'b2b_leads_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'user_profile_screen.dart';
import 'cart_screen.dart';
import 'wishlist_screen.dart';
import 'browse_brands_screen.dart';
import 'state_info_screen.dart';
import 'product_details_screen.dart';
import 'admin_login_screen.dart';
import 'seller_onboarding_screen.dart';
import 'payment_screen.dart';
import 'order_tracking_screen.dart';
import '../Components/responsive_helper.dart';
import '../Components/unified_navigation.dart';

class D_HomeScreen extends StatefulWidget {
  const D_HomeScreen({super.key});

  @override
  State<D_HomeScreen> createState() => _D_HomeScreenState();
}

class _D_HomeScreenState extends State<D_HomeScreen> {
  bool _isSidebarVisible = true;
  int _currentSlideIndex = 0;
  late PageController _pageController;
  final ScrollController _categoriesScrollController = ScrollController();
  bool _categoriesAutoScrollRunning = false;
  final ScrollController _featuredScrollController = ScrollController();
  bool _featuredAutoScrollRunning = false;
  final List<Map<String, Object>> _categories = [
    {'name': 'Wires & Cables', 'icon': Icons.cable, 'color': Colors.blue, 'image': 'assets/images/Categories/plug.png'},
    {'name': 'Switches', 'icon': Ionicons.toggle_outline, 'color': Colors.green, 'image': 'assets/images/Categories/meters.png'},
    {'name': 'Lights', 'icon': Ionicons.bulb_outline, 'color': Colors.orange, 'image': 'assets/images/Categories/blubs.jpeg'},
    {'name': 'Motors', 'icon': Ionicons.settings_outline, 'color': Colors.purple, 'image': 'assets/images/Categories/electric_motors_with_white_bg.jpeg'},
    {'name': 'Panels', 'icon': Ionicons.grid_outline, 'color': Colors.red, 'image': 'assets/images/Categories/solar.png'},
    {'name': 'Safety Tools', 'icon': Icons.build, 'color': Colors.teal, 'image': 'assets/images/Categories/image.png'},
  ];

  // Slideshow images
  final List<String> _slideshowImages = [
    'assets/images/lights/philips_bulb_single_white_bg.jpeg',
    'assets/images/circuit-breakers/electric_mcb_60w_single_white_bg.jpeg',
    'assets/images/wires-and-cables/wires1.jpeg',
    'assets/images/lights/tube_lights_60w_single_white_bg.jpeg',
    'assets/images/circuit-breakers/circuit_breakers_single_white_bg.jpeg',
    'assets/images/lights/event_lights_60w_single_white_bg.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startSlideshow();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _categoriesScrollController.dispose();
    _featuredScrollController.dispose();
    super.dispose();
  }

  void _startSlideshow() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (_currentSlideIndex < _slideshowImages.length - 1) {
          _currentSlideIndex++;
        } else {
          _currentSlideIndex = 0;
        }
        _pageController.animateToPage(
          _currentSlideIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startSlideshow();
      }
    });
  }

  // Slideshow scrolling disabled for categories

  // Slideshow scrolling disabled for featured products

  int get _featuredProductsCount => 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ResponsiveHelper.buildResponsiveLayout(
        context: context,
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        // Unified Navigation
        UnifiedNavigation(
          currentPage: 'home',
          isMobile: true,
        ),
        
        // Content
        Expanded(
          child: Column(
            children: [
              // Logo and Menu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.flash_on,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Vidyut',
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Ionicons.search_outline),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Ionicons.cart_outline),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CartScreen()),
                          );
                        },
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'profile':
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const UserProfileScreen()),
                              );
                              break;
                            case 'orders':
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CartScreen()),
                              );
                              break;
                            case 'wishlist':
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const WishlistScreen()),
                              );
                              break;
                            case 'settings':
                              _showSettingsDialog();
                              break;
                            case 'logout':
                              _showLogoutDialog();
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            value: 'profile',
                            child: Row(
                              children: [
                                Icon(Ionicons.person_outline, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text('My Profile', style: GoogleFonts.manrope(fontSize: 14)),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'orders',
                            child: Row(
                              children: [
                                Icon(Ionicons.bag_outline, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text('My Orders', style: GoogleFonts.manrope(fontSize: 14)),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'wishlist',
                            child: Row(
                              children: [
                                Icon(Ionicons.heart_outline, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text('Wishlist', style: GoogleFonts.manrope(fontSize: 14)),
                              ],
                            ),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem<String>(
                            value: 'settings',
                            child: Row(
                              children: [
                                Icon(Ionicons.settings_outline, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text('Settings', style: GoogleFonts.manrope(fontSize: 14)),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'logout',
                            child: Row(
                              children: [
                                Icon(Ionicons.log_out_outline, color: Colors.red[600], size: 20),
                                const SizedBox(width: 12),
                                Text('Logout', style: GoogleFonts.manrope(fontSize: 14, color: Colors.red[600])),
                              ],
                            ),
                          ),
                        ],
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blue[800],
                          child: Text(
                            'JD',
                            style: GoogleFonts.manrope(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Mobile Search Bar (same style/behavior as search page)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF1F5F9), width: 1),
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
                  decoration: InputDecoration(
                    hintText: 'Search products, brands, or sellers...',
                    hintStyle: GoogleFonts.manrope(color: const Color(0xFF94A3B8)),
                    prefixIcon: const Icon(Ionicons.search_outline, color: Color(0xFF64748B)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  onSubmitted: (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const D_SearchProductsScreen(),
                      ),
                    );
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const D_SearchProductsScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // Mobile Content
        Expanded(
          child: _buildMobileContent(context),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        // Unified Navigation
        UnifiedNavigation(
          currentPage: 'home',
          isMobile: false,
        ),
        // Tablet Main Content
        Expanded(
          child: _buildMainContent(context),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        // Unified Navigation
        UnifiedNavigation(
          currentPage: 'home',
          isMobile: false,
        ),
        // Desktop Main Content
        Expanded(
          child: _buildMainContent(context),
        ),
      ],
    );
  }

  Widget _buildSidebar(BuildContext context, {required bool isMobile}) {
    return Column(
      children: [
        // Logo
        Container(
          padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 16, desktop: 20)),
          child: Row(
            children: [
              Container(
                width: isMobile ? 32 : 40,
                height: isMobile ? 32 : 40,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    Icons.flash_on,
                    color: Colors.white,
                    size: isMobile ? 18 : 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Vidyut',
                style: GoogleFonts.manrope(
                  fontSize: isMobile ? 18 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
        ),
        
        const Divider(),
        
        // Navigation Links
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildNavItem(Ionicons.home_outline, 'Home'),
                _buildNavItem(Ionicons.search_outline, 'Search Products'),
                _buildNavItem(Ionicons.bag_outline, 'My Orders'),
                _buildNavItem(Ionicons.heart_outline, 'Wishlist'),
                _buildNavItem(Ionicons.cart_outline, 'Shopping Cart'),
                _buildNavItem(Ionicons.storefront_outline, 'Sell'),
                _buildNavItem(Icons.groups_2, 'B2B Leads'),
                _buildNavItem(Ionicons.chatbubbles_outline, 'Messages'),
                _buildNavItem(Ionicons.location_outline, 'State Info'),
                _buildNavItem(Icons.trending_up, 'Trending'),
                
                const SizedBox(height: 30),
                
                // Account Section
                _buildNavItem(Ionicons.settings_outline, 'Settings'),
                _buildNavItem(Icons.help, 'Help'),
                
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                
                // Admin Access
                _buildAdminNavItem(),
              ],
            ),
          ),
        ),
        
        // User Profile
        Container(
          padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 16, desktop: 20)),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: isMobile ? 16 : 20,
                backgroundColor: Colors.blue[800],
                child: Text(
                  'JD',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 12 : 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                        fontSize: isMobile ? 12 : 14,
                      ),
                    ),
                    Text(
                      'john.doe@email.com',
                      style: GoogleFonts.manrope(
                        fontSize: isMobile ? 10 : 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 20, desktop: 20)),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              if (ResponsiveHelper.isMobile(context)) ...[
                // Mobile menu button
                IconButton(
                  icon: const Icon(Ionicons.menu_outline),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Vidyut Nidhi',
                      style: GoogleFonts.manrope(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 20, tablet: 24, desktop: 28),
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    Text(
                      'Your trusted electrical products marketplace',
                      style: GoogleFonts.manrope(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              if (!ResponsiveHelper.isMobile(context)) ...[
                // Desktop Search Bar
                Flexible(
                  child: Container(
                    width: ResponsiveHelper.getResponsiveWidth(context, mobile: 200, tablet: 300, desktop: 400),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Ionicons.search_outline, color: Colors.grey[600], size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Search for electrical products...',
                            style: GoogleFonts.manrope(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // Buttons
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // User Avatar with dropdown
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'profile':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UserProfileScreen()),
                        );
                        break;
                      case 'orders':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CartScreen()),
                        );
                        break;
                      case 'wishlist':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const WishlistScreen()),
                        );
                        break;
                      case 'settings':
                        _showSettingsDialog();
                        break;
                      case 'logout':
                        _showLogoutDialog();
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      value: 'profile',
                      child: Row(
                        children: [
                          Icon(Ionicons.person_outline, color: Colors.grey[600], size: 20),
                          const SizedBox(width: 12),
                          Text(
                            'My Profile',
                            style: GoogleFonts.manrope(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'orders',
                      child: Row(
                        children: [
                          Icon(Ionicons.bag_outline, color: Colors.grey[600], size: 20),
                          const SizedBox(width: 12),
                          Text(
                            'My Orders',
                            style: GoogleFonts.manrope(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'wishlist',
                      child: Row(
                        children: [
                          Icon(Ionicons.heart_outline, color: Colors.grey[600], size: 20),
                          const SizedBox(width: 12),
                          Text(
                            'Wishlist',
                            style: GoogleFonts.manrope(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'settings',
                      child: Row(
                        children: [
                          Icon(Ionicons.settings_outline, color: Colors.grey[600], size: 20),
                          const SizedBox(width: 12),
                          Text(
                            'Settings',
                            style: GoogleFonts.manrope(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Ionicons.log_out_outline, color: Colors.red[600], size: 20),
                          const SizedBox(width: 12),
                          Text(
                            'Logout',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: Colors.red[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue[800],
                    child: Text(
                      'JD',
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        
        // Main Content
        Expanded(
          child: _buildMainContentBody(context),
        ),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 20, desktop: 40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // Categories Section
          Text(
            'Categories',
            style: GoogleFonts.manrope(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 18, tablet: 20, desktop: 24),
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          _buildCategoriesGrid(context),
          
          const SizedBox(height: 32),
          
          // Featured Products
          Text(
            'Featured Products',
            style: GoogleFonts.manrope(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 18, tablet: 20, desktop: 24),
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          _buildFeaturedProducts(context),
          
          const SizedBox(height: 32),
          
          // Stats Section
          _buildStatsSection(context),
        ],
      ),
    );
  }

  Widget _buildMainContentBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 20, desktop: 40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Platform Banner Section
          ResponsiveHelper.isMobile(context) 
            ? Column(
                children: [
                  // Mobile Platform Banner
                  Container(
                    width: double.infinity,
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
                        // Main Title
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "India's First\n",
                                style: GoogleFonts.manrope(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              TextSpan(
                                text: "Electricity ",
                                style: GoogleFonts.manrope(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[600],
                                ),
                              ),
                              TextSpan(
                                text: "Information\n",
                                style: GoogleFonts.manrope(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple[600],
                                ),
                              ),
                              TextSpan(
                                text: "Platform for B2B, D2C and C2C",
                                style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Produced by Madhu Powertech Private Limited',
                          style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Statistics
                        _buildMobileStats(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Mobile Product Showcase
                  _buildMobileProductShowcase(),
                ],
              )
            : Row(
                children: [
                  // Left Side - Text and Statistics
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(40),
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
                          // Main Title
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "India's First\n",
                                  style: GoogleFonts.manrope(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                TextSpan(
                                  text: "Electricity ",
                                  style: GoogleFonts.manrope(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[600],
                                  ),
                                ),
                                TextSpan(
                                  text: "Information\n",
                                  style: GoogleFonts.manrope(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple[600],
                                  ),
                                ),
                                TextSpan(
                                  text: "Platform for B2B, D2C and C2C",
                                  style: GoogleFonts.manrope(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Produced by Madhu Powertech Private Limited',
                            style: GoogleFonts.manrope(
                              fontSize: 18,
                          
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Statistics
                          _buildDesktopStats(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  // Right Side - Product Showcase
                  Expanded(
                    flex: 2,
                    child: _buildDesktopProductShowcase(),
                  ),
                ],
              ),
          
          const SizedBox(height: 60),
          
          // Categories Section
          Text(
            'Categories',
            style: GoogleFonts.manrope(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 18, tablet: 20, desktop: 24),
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 20),
          _buildCategoriesGrid(context),
          
          const SizedBox(height: 60),
          
          // Featured Products
          Text(
            'Featured Products',
            style: GoogleFonts.manrope(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 18, tablet: 20, desktop: 24),
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 20),
          _buildFeaturedProducts(context),
          
          const SizedBox(height: 60),
          
          // Stats Section
          _buildStatsSection(context),
        ],
      ),
    );
  }

  Widget _buildCategoriesCarousel(BuildContext context) {
    final cardWidth = ResponsiveHelper.isMobile(context) ? 220.0 : 240.0;

    // Revert to grid view rendering for categories (no slideshow)
    return _buildCategoriesGrid(context);
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    final categories = _categories;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveHelper.getResponsiveColumns(
          context,
          mobile: 2,
          tablet: 3,
          desktop: 6,
        ),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: ResponsiveHelper.isMobile(context) ? 1.2 : 1.0,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            _navigateToCategoryProducts(category['name'] as String);
          },
          child: Container(
            padding: EdgeInsets.all(
              ResponsiveHelper.getResponsivePadding(
                context,
                mobile: 12,
                tablet: 16,
                desktop: 20,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: ResponsiveHelper.isMobile(context) ? 40 : 50,
                  height: ResponsiveHelper.isMobile(context) ? 40 : 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      category['image'] as String,
                      width: ResponsiveHelper.isMobile(context) ? 40 : 50,
                      height: ResponsiveHelper.isMobile(context) ? 40 : 50,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: (category['color'] as Color).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            category['icon'] as IconData,
                            color: Colors.white,
                            size: ResponsiveHelper.isMobile(context) ? 20 : 24,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  category['name'] as String,
                  style: GoogleFonts.manrope(
                    fontSize: ResponsiveHelper.getResponsiveFontSize(
                      context,
                      mobile: 12,
                      tablet: 14,
                      desktop: 16,
                    ),
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[900],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    final products = [
      {
        'name': 'LED Bulb 9W',
        'price': '₹299',
        'rating': 4.5,
        'image': 'assets/images/lights/philips_bulb_single_white_bg.jpeg',
        'discount': '20% OFF',
      },
      {
        'name': 'MCB 16A',
        'price': '₹450',
        'rating': 4.8,
        'image': 'assets/images/circuit-breakers/electric_mcb_60w_single_white_bg.jpeg',
        'discount': '15% OFF',
      },
      {
        'name': 'Wire 2.5mm',
        'price': '₹120/m',
        'rating': 4.3,
        'image': 'assets/images/wires-and-cables/wires1.jpeg',
        'discount': '10% OFF',
      },
      {
        'name': 'Tube Light 60W',
        'price': '₹180',
        'rating': 4.6,
        'image': 'assets/images/lights/tube_lights_60w_single_white_bg.jpeg',
        'discount': '25% OFF',
      },
      {
        'name': 'Circuit Breaker',
        'price': '₹320',
        'rating': 4.7,
        'image': 'assets/images/circuit-breakers/circuit_breakers_single_white_bg.jpeg',
        'discount': '12% OFF',
      },
      {
        'name': 'Event Light 60W',
        'price': '₹250',
        'rating': 4.4,
        'image': 'assets/images/lights/event_lights_60w_single_white_bg.jpeg',
        'discount': '18% OFF',
      },
      {
        'name': 'LED Street Light',
        'price': '₹1,499',
        'rating': 4.5,
        'image': 'assets/images/lights/street_light_60w_single_white_bg.jpeg',
        'discount': '22% OFF',
      },
      {
        'name': 'Three-Core Cable',
        'price': '₹240/m',
        'rating': 4.2,
        'image': 'assets/images/wires-and-cables/wires2.jpeg',
        'discount': '8% OFF',
      },
      {
        'name': 'Industrial Motor 2HP',
        'price': '₹8,990',
        'rating': 4.6,
        'image': 'assets/images/motors/motor1.jpeg',
        'discount': '14% OFF',
      },
      {
        'name': 'Distribution Panel',
        'price': '₹12,500',
        'rating': 4.7,
        'image': 'assets/images/panels/panel1.jpeg',
        'discount': '16% OFF',
      },
      {
        'name': 'Solar Charge Controller',
        'price': '₹1,899',
        'rating': 4.4,
        'image': 'assets/images/transformer/solar_controller.jpeg',
        'discount': '10% OFF',
      },
      {
        'name': 'Insulated Screwdriver Set',
        'price': '₹399',
        'rating': 4.3,
        'image': 'assets/images/tools/tool1.jpeg',
        'discount': '19% OFF',
      },
      {
        'name': 'PVC Conduit 25mm',
        'price': '₹45/m',
        'rating': 4.1,
        'image': 'assets/images/conduits/conduit1.jpeg',
        'discount': '9% OFF',
      },
      {
        'name': 'Safety Gloves',
        'price': '₹199',
        'rating': 4.2,
        'image': 'assets/images/safety/safety1.jpeg',
        'discount': '11% OFF',
      },
    ];

    return SizedBox(
      height: ResponsiveHelper.isMobile(context) ? 180 : 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              // Create a product map with all necessary fields for ProductDetailsScreen
              final productData = {
                'name': product['name'],
                'price': product['price'],
                'rating': product['rating'],
                'image': product['image'],
                'discount': product['discount'],
                'seller': 'ElectroMart', // Default seller for featured products
                'category': _getCategoryFromProduct(product['name'] as String),
                'description': _getProductDescription(product['name'] as String),
                'specifications': _getProductSpecifications(product['name'] as String),
              };
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    product: productData,
                    allProducts: products.map((p) => {
                      'name': p['name'],
                      'price': p['price'],
                      'rating': p['rating'],
                      'image': p['image'],
                      'discount': p['discount'],
                      'seller': 'ElectroMart',
                      'category': _getCategoryFromProduct(p['name'] as String),
                    }).toList(),
                  ),
                ),
              );
            },
            child: Container(
              width: ResponsiveHelper.isMobile(context) ? 150 : 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      color: Colors.grey[100],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(
                        product['image'] as String,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image,
                              color: Colors.grey[400],
                              size: ResponsiveHelper.isMobile(context) ? 25 : 35,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Product Info
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 6, tablet: 8, desktop: 10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product['name'] as String,
                                style: GoogleFonts.manrope(
                                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 11, tablet: 13, desktop: 15),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[900],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red[100],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                product['discount'] as String,
                                style: GoogleFonts.manrope(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          product['price'] as String,
                          style: GoogleFonts.manrope(
                            fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 11, tablet: 13, desktop: 15),
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: ResponsiveHelper.isMobile(context) ? 10 : 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              product['rating'].toString(),
                              style: GoogleFonts.manrope(
                                fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 9, tablet: 11, desktop: 11),
                                color: Colors.grey[600],
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
          );
        },
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final stats = [
      {'number': '10K+', 'label': 'Products', 'targetValue': 10000, 'icon': Icons.inventory_2_outlined},
      {'number': '500+', 'label': 'Suppliers', 'targetValue': 500, 'icon': Icons.business_outlined},
      {'number': '50K+', 'label': 'Customers', 'targetValue': 50000, 'icon': Icons.people_outline},
      {'number': '99%', 'label': 'Satisfaction', 'targetValue': 99, 'icon': Icons.sentiment_very_satisfied_outlined},
      {'number': '120+', 'label': 'Cities Covered', 'targetValue': 120, 'icon': Icons.location_city_outlined},
      {'number': '24x7', 'label': 'Support', 'targetValue': 24, 'icon': Icons.support_agent_outlined},
      {'number': '1.2M+', 'label': 'Monthly Views', 'targetValue': 1200000, 'icon': Icons.visibility_outlined},
      {'number': '4.8/5', 'label': 'Average Rating', 'targetValue': 4.8, 'icon': Icons.star_outline},
    ];

    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 20, tablet: 24, desktop: 32)),
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Animated title
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1000),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: Text(
                    'Trusted by Thousands',
                    style: GoogleFonts.manrope(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 18, tablet: 20, desktop: 24),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.getResponsiveColumns(context, mobile: 2, tablet: 4, desktop: 4),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: stats.length,
            itemBuilder: (context, index) {
              final stat = stats[index];
              return _buildAnimatedStatCard(context, stat, index);
            },
          ),
          const SizedBox(height: 16),
          // CTA row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const D_SearchProductsScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.blue[800]),
                child: Text('Explore Products', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SellerOnboardingScreen(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white70)),
                child: Text('Become a Seller', style: GoogleFonts.manrope(fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileStats() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatItem(
                Icons.people,
                '2,500+',
                'Suppliers',
                Colors.blue[600]!,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatItem(
                Icons.inventory,
                '10,000+',
                'Products',
                Colors.green[600]!,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatItem(
                Icons.location_city,
                '500+',
                'Cities Served',
                Colors.orange[600]!,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(), // Empty space for alignment
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            Icons.people,
            '2,500+',
            'Suppliers',
            Colors.blue[600]!,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildStatItem(
            Icons.inventory,
            '10,000+',
            'Products',
            Colors.green[600]!,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildStatItem(
            Icons.location_city,
            '500+',
            'Cities Served',
            Colors.orange[600]!,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String number, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            number,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMobileProductShowcase() {
    return Container(
      height: 180,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(

        children: [

          // Product Grid
          Expanded(
            child: _buildProductGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopProductShowcase() {
    return Container(
      height: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [

          // Right Content - Product Image
          Expanded(
            flex: 1,
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Main Product Image
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          // Slideshow
                          PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentSlideIndex = index;
                              });
                            },
                            itemCount: _slideshowImages.length,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                _slideshowImages[index],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.grey[100]!,
                                          Colors.grey[200]!,
                                        ],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 60,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          // Slide indicators
                          Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _slideshowImages.length,
                                (index) => Container(
                                  width: 12,
                                  height: 12,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentSlideIndex == index
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
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
    );
  }

  Widget _buildProductGrid() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Slideshow
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentSlideIndex = index;
                });
              },
              itemCount: _slideshowImages.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  _slideshowImages[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image,
                        color: Colors.grey[400],
                        size: 80,
                      ),
                    );
                  },
                );
              },
            ),
            // Slide indicators
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slideshowImages.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentSlideIndex == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? Colors.blue[800] : Colors.grey[600],
          size: 20,
        ),
        title: Text(
          title,
          style: GoogleFonts.manrope(
            color: isActive ? Colors.blue[800] : Colors.grey[700],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        onTap: () {
          if (title == 'Search Products') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
            );
          } else if (title == 'My Orders') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrdersScreen()),
            );
          } else if (title == 'User Profile' || title == 'Profile') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          } else if (title == 'Shopping Cart' || title == 'Checkout') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CheckoutScreen()),
            );
          } else if (title == 'Notifications') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationsScreen()),
            );
          } else if (title == 'Browse Brands') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const D_BrowseBrandsScreen()),
            );
          } else if (title == 'Sell') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SellerDashboardScreen()),
            );
          } else if (title == 'B2B Leads') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const B2BLeadsScreen()),
            );
          } else if (title == 'State Info') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const D_StateInfoScreen()),
            );
          } else if (title == 'Sign In') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        },
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Settings',
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.blue[800]),
                title: Text(
                  'Notifications',
                  style: GoogleFonts.manrope(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Manage your notification preferences',
                  style: GoogleFonts.manrope(fontSize: 12, color: Colors.grey[600]),
                ),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.blue[800],
                ),
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: Colors.blue[800]),
                title: Text(
                  'Privacy',
                  style: GoogleFonts.manrope(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Control your privacy settings',
                  style: GoogleFonts.manrope(fontSize: 12, color: Colors.grey[600]),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Privacy settings coming soon!', style: GoogleFonts.manrope()),
                      backgroundColor: Colors.blue[800],
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.blue[800]),
                title: Text(
                  'Help & Support',
                  style: GoogleFonts.manrope(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Get help and contact support',
                  style: GoogleFonts.manrope(fontSize: 12, color: Colors.grey[600]),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Help center coming soon!', style: GoogleFonts.manrope()),
                      backgroundColor: Colors.blue[800],
                    ),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: GoogleFonts.manrope(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          content: Text(
            'Are you sure you want to logout? You will need to sign in again to access your account.',
            style: GoogleFonts.manrope(color: Colors.grey[700]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.manrope(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logged out successfully!', style: GoogleFonts.manrope()),
                    backgroundColor: Colors.green[600],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToCategoryProducts(String categoryName) {
    // Map home categories to search page categories
    final Map<String, String> mapToSearchCategory = {
      'Wires & Cables': 'Wires & Cables',
      'Switches': 'Switches & Sockets',
      'Lights': 'LED Lights',
      'Motors': 'Pumps',
      'Panels': 'Fans',
      'Safety Tools': 'Tools',
    };

    final String mapped = mapToSearchCategory[categoryName] ?? categoryName;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => D_SearchProductsScreen(selectedCategory: mapped),
      ),
    );
  }

  // Helper methods for product data
  String _getCategoryFromProduct(String productName) {
    if (productName.toLowerCase().contains('bulb') || 
        productName.toLowerCase().contains('light') || 
        productName.toLowerCase().contains('tube')) {
      return 'lights';
    } else if (productName.toLowerCase().contains('mcb') || 
               productName.toLowerCase().contains('circuit') || 
               productName.toLowerCase().contains('breaker')) {
      return 'circuit-breakers';
    } else if (productName.toLowerCase().contains('wire') || 
               productName.toLowerCase().contains('cable')) {
      return 'wires-and-cables';
    } else if (productName.toLowerCase().contains('motor')) {
      return 'motors';
    } else if (productName.toLowerCase().contains('panel')) {
      return 'panels';
    } else if (productName.toLowerCase().contains('solar') || 
               productName.toLowerCase().contains('controller')) {
      return 'transformer';
    } else if (productName.toLowerCase().contains('screwdriver') || 
               productName.toLowerCase().contains('tool')) {
      return 'tools';
    } else if (productName.toLowerCase().contains('conduit')) {
      return 'conduits';
    } else if (productName.toLowerCase().contains('glove') || 
               productName.toLowerCase().contains('safety')) {
      return 'safety';
    } else {
      return 'lights'; // Default category
    }
  }

  String _getProductDescription(String productName) {
    if (productName.toLowerCase().contains('bulb')) {
      return 'High-quality LED bulb with excellent energy efficiency and long lifespan. Perfect for residential and commercial lighting applications.';
    } else if (productName.toLowerCase().contains('mcb')) {
      return 'Miniature Circuit Breaker designed for electrical protection. Features reliable tripping mechanism and compact design for easy installation.';
    } else if (productName.toLowerCase().contains('wire')) {
      return 'Premium quality electrical wire with excellent conductivity and durability. Suitable for various electrical installations and applications.';
    } else if (productName.toLowerCase().contains('tube')) {
      return 'Energy-efficient tube light providing bright and uniform illumination. Ideal for offices, shops, and commercial spaces.';
    } else if (productName.toLowerCase().contains('motor')) {
      return 'Industrial-grade motor with high efficiency and reliable performance. Suitable for various industrial applications and heavy-duty operations.';
    } else if (productName.toLowerCase().contains('panel')) {
      return 'Distribution panel designed for safe and organized electrical distribution. Features high-quality components and easy maintenance access.';
    } else if (productName.toLowerCase().contains('solar')) {
      return 'Solar charge controller for efficient battery charging and protection. Features advanced MPPT technology and comprehensive safety features.';
    } else if (productName.toLowerCase().contains('screwdriver')) {
      return 'Professional insulated screwdriver set for safe electrical work. Features ergonomic handles and high-quality steel construction.';
    } else if (productName.toLowerCase().contains('conduit')) {
      return 'PVC conduit pipe for electrical cable protection. Features excellent durability, weather resistance, and easy installation.';
    } else if (productName.toLowerCase().contains('glove')) {
      return 'Electrical safety gloves providing protection against electrical hazards. Features excellent insulation properties and comfortable fit.';
    } else {
      return 'High-quality electrical product designed for reliable performance and safety. Suitable for various electrical applications and installations.';
    }
  }

  Map<String, String> _getProductSpecifications(String productName) {
    if (productName.toLowerCase().contains('bulb')) {
      return {
        'Power': '9W',
        'Voltage': '220-240V AC',
        'Luminous Flux': '800 lm',
        'Color Temperature': '6500K (Daylight)',
        'Lifespan': '25,000 hours',
        'Base Type': 'B22',
        'Dimmable': 'No',
        'Certification': 'BIS Certified',
      };
    } else if (productName.toLowerCase().contains('mcb')) {
      return {
        'Current Rating': '16A',
        'Voltage': '240V AC',
        'Breaking Capacity': '6kA',
        'Type': 'Type C',
        'Poles': 'Single Pole',
        'Mounting': 'DIN Rail',
        'Certification': 'BIS Certified',
        'Brand': 'ElectroMart',
      };
    } else if (productName.toLowerCase().contains('wire')) {
      return {
        'Conductor': 'Copper',
        'Cross Section': '2.5 sq mm',
        'Voltage': '1100V',
        'Insulation': 'PVC',
        'Sheath': 'PVC',
        'Standards': 'IS 694',
        'Certification': 'BIS Certified',
        'Color': 'Red/Black',
      };
    } else {
      return {
        'Brand': 'ElectroMart',
        'Category': 'Electrical',
        'Certification': 'BIS Certified',
        'Warranty': '1 Year',
        'Country of Origin': 'India',
        'Material': 'Premium Quality',
        'Voltage': '220-240V AC',
        'Standards': 'IS Standards',
      };
    }
  }

  Widget _buildAnimatedStatCard(BuildContext context, Map<String, dynamic> stat, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + (index * 200)), // Staggered animation
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)), // Slide up animation
          child: Opacity(
            opacity: value,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06 + (value * 0.04)), // Subtle hover effect
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1 * value),
                      blurRadius: 8 * value,
                      offset: Offset(0, 4 * value),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                child: Column(
                  children: [
                    // Animated icon
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 1200 + (index * 150)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, iconValue, child) {
                        return Transform.scale(
                          scale: 0.5 + (0.5 * iconValue),
                          child: Opacity(
                            opacity: iconValue,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                stat['icon'] as IconData,
                                color: Colors.white,
                                size: ResponsiveHelper.getResponsiveFontSize(context, mobile: 20, tablet: 24, desktop: 28),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    // Animated counter
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 1500 + (index * 100)),
                      tween: Tween(begin: 0.0, end: stat['targetValue'] as double),
                      builder: (context, animatedValue, child) {
                        String displayValue;
                        if (stat['label'] == 'Products') {
                          displayValue = '${(animatedValue / 1000).toStringAsFixed(0)}K+';
                        } else if (stat['label'] == 'Suppliers') {
                          displayValue = '${animatedValue.toStringAsFixed(0)}+';
                        } else if (stat['label'] == 'Customers') {
                          displayValue = '${(animatedValue / 1000).toStringAsFixed(0)}K+';
                        } else if (stat['label'] == 'Satisfaction') {
                          displayValue = '${animatedValue.toStringAsFixed(0)}%';
                        } else if (stat['label'] == 'Cities Covered') {
                          displayValue = '${animatedValue.toStringAsFixed(0)}+';
                        } else if (stat['label'] == 'Support') {
                          displayValue = '24x7';
                        } else if (stat['label'] == 'Monthly Views') {
                          displayValue = '${(animatedValue / 1000000).toStringAsFixed(1)}M+';
                        } else if (stat['label'] == 'Average Rating') {
                          displayValue = '${animatedValue.toStringAsFixed(1)}/5';
                        } else {
                          displayValue = stat['number'] as String;
                        }
                        
                        return Transform.scale(
                          scale: 0.8 + (0.2 * value), // Scale animation
                          child: Text(
                            displayValue,
                            style: GoogleFonts.manrope(
                              fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 22, tablet: 26, desktop: 30),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 6),
                    // Animated label
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 1000 + (index * 150)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, labelValue, child) {
                        return Transform.translate(
                          offset: Offset(0, 20 * (1 - labelValue)),
                          child: Opacity(
                            opacity: labelValue,
                            child: Text(
                              stat['label'] as String,
                              style: GoogleFonts.manrope(
                                fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdminNavItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.admin_panel_settings,
            color: Colors.red[600],
            size: 20,
          ),
        ),
        title: Text(
          'Admin Portal',
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.red[600],
          ),
        ),
        subtitle: Text(
          'Superuser Access',
          style: GoogleFonts.manrope(
            fontSize: 12,
            color: Colors.red[400],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminLoginScreen(),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: Colors.red[25],
      ),
    );
  }
}
