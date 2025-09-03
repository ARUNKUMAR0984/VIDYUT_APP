import 'package:flutter/material.dart';
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
import '../Components/responsive_helper.dart';

class D_HomeScreen extends StatefulWidget {
  const D_HomeScreen({super.key});

  @override
  State<D_HomeScreen> createState() => _D_HomeScreenState();
}

class _D_HomeScreenState extends State<D_HomeScreen> {
  bool _isSidebarVisible = true;
  int _currentSlideIndex = 0;
  late PageController _pageController;

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
        // Mobile Header
        Container(
          padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 12, tablet: 16, desktop: 20)),
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
                        style: GoogleFonts.inter(
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
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
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
                                Icon(Icons.person, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text('My Profile', style: GoogleFonts.inter(fontSize: 14)),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'orders',
                            child: Row(
                              children: [
                                Icon(Icons.shopping_bag, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text('My Orders', style: GoogleFonts.inter(fontSize: 14)),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'wishlist',
                            child: Row(
                              children: [
                                Icon(Icons.favorite, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text('Wishlist', style: GoogleFonts.inter(fontSize: 14)),
                              ],
                            ),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem<String>(
                            value: 'settings',
                            child: Row(
                              children: [
                                Icon(Icons.settings, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text('Settings', style: GoogleFonts.inter(fontSize: 14)),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'logout',
                            child: Row(
                              children: [
                                Icon(Icons.logout, color: Colors.red[600], size: 20),
                                const SizedBox(width: 12),
                                Text('Logout', style: GoogleFonts.inter(fontSize: 14, color: Colors.red[600])),
                              ],
                            ),
                          ),
                        ],
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blue[800],
                          child: Text(
                            'JD',
                            style: GoogleFonts.inter(
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
              // Mobile Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[600], size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Search for electrical products...',
                        style: GoogleFonts.inter(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
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
    return Row(
      children: [
        // Tablet Sidebar
        Container(
          width: 200,
          color: Colors.white,
          child: _buildSidebar(context, isMobile: false),
        ),
        // Tablet Main Content
        Expanded(
          child: _buildMainContent(context),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Desktop Sidebar
        Container(
          width: 280,
          color: Colors.white,
          child: _buildSidebar(context, isMobile: false),
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
                style: GoogleFonts.inter(
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
                _buildNavItem(Icons.home, 'Home'),
                _buildNavItem(Icons.search, 'Search Products'),
                _buildNavItem(Icons.shopping_bag, 'My Orders'),
                _buildNavItem(Icons.favorite, 'Wishlist'),
                _buildNavItem(Icons.shopping_cart, 'Shopping Cart'),
                _buildNavItem(Icons.store, 'Sell'),
                _buildNavItem(Icons.groups_2, 'B2B Leads'),
                _buildNavItem(Icons.message, 'Messages'),
                _buildNavItem(Icons.location_on, 'State Info'),
                _buildNavItem(Icons.trending_up, 'Trending'),
                
                const SizedBox(height: 30),
                
                // Account Section
                _buildNavItem(Icons.settings, 'Settings'),
                _buildNavItem(Icons.help, 'Help'),
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
                  style: GoogleFonts.inter(
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
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                        fontSize: isMobile ? 12 : 14,
                      ),
                    ),
                    Text(
                      'john.doe@email.com',
                      style: GoogleFonts.inter(
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
                  icon: const Icon(Icons.menu),
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
                      style: GoogleFonts.inter(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 20, tablet: 24, desktop: 28),
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    Text(
                      'Your trusted electrical products marketplace',
                      style: GoogleFonts.inter(
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
                        Icon(Icons.search, color: Colors.grey[600], size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Search for electrical products...',
                            style: GoogleFonts.inter(
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
                    style: GoogleFonts.inter(
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
                    style: GoogleFonts.inter(
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
                          Icon(Icons.person, color: Colors.grey[600], size: 20),
                          const SizedBox(width: 12),
                          Text(
                            'My Profile',
                            style: GoogleFonts.inter(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'orders',
                      child: Row(
                        children: [
                          Icon(Icons.shopping_bag, color: Colors.grey[600], size: 20),
                          const SizedBox(width: 12),
                          Text(
                            'My Orders',
                            style: GoogleFonts.inter(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'wishlist',
                      child: Row(
                        children: [
                          Icon(Icons.favorite, color: Colors.grey[600], size: 20),
                          const SizedBox(width: 12),
                          Text(
                            'Wishlist',
                            style: GoogleFonts.inter(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'settings',
                      child: Row(
                        children: [
                          Icon(Icons.settings, color: Colors.grey[600], size: 20),
                          const SizedBox(width: 12),
                          Text(
                            'Settings',
                            style: GoogleFonts.inter(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: Colors.red[600], size: 20),
                          const SizedBox(width: 12),
                          Text(
                            'Logout',
                            style: GoogleFonts.inter(
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
                      style: GoogleFonts.inter(
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
            style: GoogleFonts.inter(
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
            style: GoogleFonts.inter(
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
                                text: "India's Largest\n",
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              TextSpan(
                                text: "Electricity ",
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[600],
                                ),
                              ),
                              TextSpan(
                                text: "Information\n",
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple[600],
                                ),
                              ),
                              TextSpan(
                                text: "Platform for B2B, D2C and C2C",
                                style: GoogleFonts.inter(
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
                          style: GoogleFonts.inter(
                            fontSize: 12,
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
                                  text: "India's Largest\n",
                                  style: GoogleFonts.inter(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                TextSpan(
                                  text: "Electricity ",
                                  style: GoogleFonts.inter(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[600],
                                  ),
                                ),
                                TextSpan(
                                  text: "Information\n",
                                  style: GoogleFonts.inter(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple[600],
                                  ),
                                ),
                                TextSpan(
                                  text: "Platform for B2B, D2C and C2C",
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
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
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.grey[500],
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
            style: GoogleFonts.inter(
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
            style: GoogleFonts.inter(
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

  Widget _buildCategoriesGrid(BuildContext context) {
    final categories = [
      {'name': 'Wires & Cables', 'icon': Icons.cable, 'color': Colors.blue[600]!, 'image': 'assets/images/Categories/plug.png'},
      {'name': 'Switches', 'icon': Icons.toggle_on, 'color': Colors.green[600]!, 'image': 'assets/images/Categories/meters.png'},
      {'name': 'Lights', 'icon': Icons.lightbulb, 'color': Colors.orange[600]!, 'image': 'assets/images/Categories/blubs.jpeg'},
      {'name': 'Motors', 'icon': Icons.settings, 'color': Colors.purple[600]!, 'image': 'assets/images/Categories/industry.png'},
      {'name': 'Panels', 'icon': Icons.dashboard, 'color': Colors.red[600]!, 'image': 'assets/images/Categories/energy.png'},
      {'name': 'Tools', 'icon': Icons.build, 'color': Colors.teal[600]!, 'image': 'assets/images/Categories/batteries.png'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveHelper.getResponsiveColumns(context, mobile: 2, tablet: 3, desktop: 6),
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
            padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 12, tablet: 16, desktop: 20)),
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
                          color: category['color'] as Color,
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
                style: GoogleFonts.inter(
                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
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
    ];

    return SizedBox(
      height: ResponsiveHelper.isMobile(context) ? 180 : 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: ResponsiveHelper.isMobile(context) ? 150 : 180,
            margin: const EdgeInsets.only(right: 16),
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
                                style: GoogleFonts.inter(
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
                                style: GoogleFonts.inter(
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
                          style: GoogleFonts.inter(
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
                              style: GoogleFonts.inter(
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
          );
        },
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final stats = [
      {'number': '10K+', 'label': 'Products'},
      {'number': '500+', 'label': 'Suppliers'},
      {'number': '50K+', 'label': 'Customers'},
      {'number': '99%', 'label': 'Satisfaction'},
      {'number': '120+', 'label': 'Cities Covered'},
      {'number': '24x7', 'label': 'Support'},
      {'number': '1.2M+', 'label': 'Monthly Views'},
      {'number': '4.8/5', 'label': 'Average Rating'},
    ];

    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 20, tablet: 24, desktop: 32)),
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Trusted by Thousands',
            style: GoogleFonts.inter(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 18, tablet: 20, desktop: 24),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
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
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                child: Column(
                  children: [
                    Text(
                      stat['number'] as String,
                      style: GoogleFonts.inter(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 22, tablet: 26, desktop: 30),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      stat['label'] as String,
                      style: GoogleFonts.inter(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          // CTA row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.blue[800]),
                child: Text('Explore Products', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white70)),
                child: Text('Become a Seller', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white)),
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
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
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
          style: GoogleFonts.inter(
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
            style: GoogleFonts.inter(
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
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Manage your notification preferences',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
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
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Control your privacy settings',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Privacy settings coming soon!', style: GoogleFonts.inter()),
                      backgroundColor: Colors.blue[800],
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.blue[800]),
                title: Text(
                  'Help & Support',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Get help and contact support',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Help center coming soon!', style: GoogleFonts.inter()),
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
                style: GoogleFonts.inter(
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
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          content: Text(
            'Are you sure you want to logout? You will need to sign in again to access your account.',
            style: GoogleFonts.inter(color: Colors.grey[700]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
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
                    content: Text('Logged out successfully!', style: GoogleFonts.inter()),
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
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToCategoryProducts(String categoryName) {
    // Navigate to search products screen with the selected category
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => D_SearchProductsScreen(selectedCategory: categoryName),
      ),
    );
  }
}
