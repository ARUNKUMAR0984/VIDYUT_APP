import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/responsive_helper.dart';
import '../Components/unified_navigation.dart';
import 'home_screen.dart';
import 'search_products_screen.dart';
import 'orders_screen.dart';
import 'wishlist_screen.dart';
import 'cart_screen.dart';
import 'b2b_leads_screen.dart';
import 'state_info_screen.dart';
import 'login_screen.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen>
    with SingleTickerProviderStateMixin {
  bool _isSidebarVisible = true;
  late TabController _tabController;
  int _selectedTabIndex = 0;
  
  // Profile & Settings Controllers
  final _formKey = GlobalKey<FormState>();
  final _legalBusinessNameController = TextEditingController();
  final _gstinController = TextEditingController();
  final _supportPhoneController = TextEditingController();
  final _businessEmailController = TextEditingController();
  final _businessAddressController = TextEditingController();
  
  // Custom Fields
  List<CustomField> _customFields = [
    CustomField(
      id: '1',
      label: 'Business Type',
      type: FieldType.dropdown,
      options: ['Manufacturer', 'Distributor', 'Retailer', 'Wholesaler'],
    ),
  ];
  
  // Preferences
  bool _emailNotifications = true;
  bool _autoQuote = true;
  bool _leadAlerts = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _legalBusinessNameController.dispose();
    _gstinController.dispose();
    _supportPhoneController.dispose();
    _businessEmailController.dispose();
    _businessAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
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
          currentPage: 'seller',
          isMobile: true,
        ),
        
        // Content
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF3B82F6).withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.flash_on,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'Vidyut',
                            style: GoogleFonts.manrope(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
                            case 'home':
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const D_HomeScreen()),
                              );
                              break;
                            case 'orders':
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const OrdersScreen()),
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
                            case 'help':
                              _showHelpDialog();
                              break;
                            case 'logout':
                              _showLogoutDialog();
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            value: 'home',
                            child: Row(
                              children: [
                                Icon(Ionicons.home_outline, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text('Home', style: GoogleFonts.manrope(fontSize: 14)),
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
                            value: 'help',
                            child: Row(
                              children: [
                                Icon(Icons.help, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text('Help', style: GoogleFonts.manrope(fontSize: 14)),
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
                          backgroundColor: const Color(0xFF3B82F6),
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
              // Mobile Tab Bar
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildMobileTab('Dashboard', 0),
                    _buildMobileTab('Products', 1),
                    _buildMobileTab('Stock', 2),
                    _buildMobileTab('B2B Leads', 3),
                    _buildMobileTab('Analytics', 4),
                    _buildMobileTab('Plans', 5),
                    _buildMobileTab('Profile', 6),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Mobile Content
        Expanded(
          child: _buildTabContent(),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        // Unified Navigation
        UnifiedNavigation(
          currentPage: 'seller',
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
          currentPage: 'seller',
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
                width: isMobile ? 40 : 48,
                height: isMobile ? 40 : 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
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
                  fontSize: isMobile ? 20 : 26,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
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
                // Main Navigation
                _buildNavItem(Ionicons.home_outline, 'Home', -2),
                _buildNavItem(Ionicons.search_outline, 'Search Products', -2),
                _buildNavItem(Ionicons.bag_outline, 'My Orders', -2),
                _buildNavItem(Ionicons.heart_outline, 'Wishlist', -2),
                _buildNavItem(Ionicons.cart_outline, 'Shopping Cart', -2),
                
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                
                // Seller Dashboard Navigation
                Text(
                  'Seller Dashboard',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 10),
                
                _buildNavItem(Ionicons.grid_outline, 'Dashboard', 0),
                _buildNavItem(Icons.inventory, 'Products', 1),
                _buildNavItem(Icons.assessment, 'Stock & Pricing', 2),
                _buildNavItem(Icons.people, 'Buyer Leads', 3),
                _buildNavItem(Icons.analytics, 'Analytics', 4),
                _buildNavItem(Icons.upgrade, 'Upgrade Plan', 5),
                _buildNavItem(Ionicons.person_outline, 'Profile & Reviews', 6),
                
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                
                // Additional Navigation
                _buildNavItem(Ionicons.storefront_outline, 'Sell', -2),
                _buildNavItem(Icons.groups_2, 'B2B Leads', -2),
                _buildNavItem(Ionicons.chatbubbles_outline, 'Messages', -2),
                _buildNavItem(Ionicons.location_outline, 'State Info', -2),
                _buildNavItem(Icons.trending_up, 'Trending', -2),
                
                const SizedBox(height: 30),
                
                // Account Section
                _buildNavItem(Ionicons.settings_outline, 'Settings', -1),
                _buildNavItem(Icons.help, 'Help & Support', -1),
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
                             Container(
                 width: isMobile ? 32 : 40,
                 height: isMobile ? 32 : 40,
                 decoration: BoxDecoration(
                   gradient: const LinearGradient(
                     colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                     begin: Alignment.topLeft,
                     end: Alignment.bottomRight,
                   ),
                   borderRadius: BorderRadius.circular(12),
                   boxShadow: [
                     BoxShadow(
                       color: const Color(0xFF3B82F6).withOpacity(0.3),
                       spreadRadius: 0,
                       blurRadius: 8,
                       offset: const Offset(0, 2),
                     ),
                   ],
                 ),
                 child: Center(
                   child: Text(
                     'JD',
                     style: GoogleFonts.manrope(
                       color: Colors.white,
                       fontWeight: FontWeight.w700,
                       fontSize: isMobile ? 12 : 14,
                     ),
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
                         color: const Color(0xFF1E293B),
                         fontSize: isMobile ? 12 : 14,
                       ),
                     ),
                     Text(
                       'Premium Seller',
                       style: GoogleFonts.manrope(
                         fontSize: isMobile ? 10 : 12,
                         color: const Color(0xFF10B981),
                         fontWeight: FontWeight.w500,
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
                IconButton(
                  icon: const Icon(Ionicons.menu_outline),
                  onPressed: () {
                    setState(() {
                      _isSidebarVisible = !_isSidebarVisible;
                    });
                  },
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Seller Dashboard',
                      style: GoogleFonts.manrope(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 20, tablet: 24, desktop: 28),
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    Text(
                      'Manage your products, leads, and business',
                      style: GoogleFonts.manrope(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              if (!ResponsiveHelper.isMobile(context)) ...[
                // Desktop Tab Bar
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: false,
                      indicator: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: const Color(0xFF64748B),
                      labelStyle: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      unselectedLabelStyle: GoogleFonts.manrope(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      tabs: const [
                        Tab(text: 'Dashboard'),
                        Tab(text: 'Products'),
                        Tab(text: 'B2B Leads'),
                        Tab(text: 'Plans'),
                        Tab(text: 'Profile'),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        
        // Main Content
        Expanded(
          child: _buildTabContent(),
        ),
      ],
    );
  }

  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildDashboard(),
        _buildProducts(),
        _buildB2BLeads(),
        _buildPlans(),
        _buildProfileReviews(),
      ],
    );
  }

  Widget _buildMobileTab(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
            _tabController.animateTo(index);
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: isSelected 
              ? const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
            color: isSelected ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0),
              width: 1.5,
            ),
            boxShadow: isSelected ? [
              BoxShadow(
                color: const Color(0xFF3B82F6).withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: Text(
            title,
            style: GoogleFonts.manrope(
              color: isSelected ? Colors.white : const Color(0xFF64748B),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, int tabIndex) {
    final isActive = _selectedTabIndex == tabIndex;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF3B82F6).withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF64748B),
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.manrope(
            color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF64748B),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
        onTap: () {
          if (tabIndex >= 0) {
            // Handle dashboard tabs
            setState(() {
              _selectedTabIndex = tabIndex;
              _tabController.animateTo(tabIndex);
            });
          } else if (tabIndex == -1) {
            // Handle settings and help
            _handleSettingsHelpNavigation(title);
          } else if (tabIndex == -2) {
            // Handle main navigation
            _handleMainNavigation(title);
          }
        },
      ),
    );
  }

  void _handleMainNavigation(String title) {
    switch (title) {
      case 'Home':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const D_HomeScreen()),
        );
        break;
      case 'Search Products':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
        );
        break;
      case 'My Orders':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrdersScreen()),
        );
        break;
      case 'Wishlist':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WishlistScreen()),
        );
        break;
      case 'Shopping Cart':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartScreen()),
        );
        break;
      case 'Sell':
        // Already in seller dashboard
        break;
      case 'B2B Leads':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const B2BLeadsScreen()),
        );
        break;
      case 'Messages':
        _showMessagesDialog();
        break;
      case 'State Info':
                 Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => const D_StateInfoScreen()),
         );
        break;
      case 'Trending':
        _showTrendingDialog();
        break;
    }
  }

  void _handleSettingsHelpNavigation(String title) {
    switch (title) {
      case 'Settings':
        _showSettingsDialog();
        break;
      case 'Help & Support':
        _showHelpDialog();
        break;
    }
  }

  // Dashboard Tab
  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 20, desktop: 24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Cards
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              double childAspectRatio;
              
              if (constraints.maxWidth < 768) {
                crossAxisCount = 2;
                childAspectRatio = 1.4;
              } else if (constraints.maxWidth < 1024) {
                crossAxisCount = 3;
                childAspectRatio = 1.6;
              } else {
                crossAxisCount = 4;
                childAspectRatio = 1.8;
              }
              
              return GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: childAspectRatio,
                children: [
                  _buildStatCard('Total B2B Leads', '24', Icons.description_outlined, Colors.blue[600]!),
                  _buildStatCard('Sales (7d)', '50', Icons.shopping_bag_outlined, Colors.green[600]!),
                  _buildStatCard('Earnings (7d)', '₹1,42,700', Icons.currency_rupee, Colors.purple[600]!),
                  _buildStatCard('Products', '15', Icons.inventory_2_outlined, Colors.orange[600]!),
                ],
              );
            },
          ),
          
          const SizedBox(height: 24),
          
                     // Recent Activity Section
           Text(
             'Recent B2B Leads',
             style: GoogleFonts.manrope(
               fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 20, tablet: 22, desktop: 24),
               fontWeight: FontWeight.w700,
               color: const Color(0xFF1E293B),
             ),
           ),
          const SizedBox(height: 16),
          
          Container(
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
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'Buyer #${1001 + index} requested quote',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    'Product: LED Panel 18W • Qty: ${50 + (index * 10)} • ${index == 0 ? '2 hours ago' : '${index + 1} hours ago'}',
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF64748B),
                      fontSize: 13,
                    ),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _showResponseDialog('Buyer #${1001 + index}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Respond',
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Quick Actions
          Text(
            'Quick Actions',
            style: GoogleFonts.manrope(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 20, tablet: 22, desktop: 24),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              double childAspectRatio;
              
              if (constraints.maxWidth < 768) {
                crossAxisCount = 2;
                childAspectRatio = 1.4;
              } else if (constraints.maxWidth < 1024) {
                crossAxisCount = 3;
                childAspectRatio = 1.6;
              } else {
                crossAxisCount = 4;
                childAspectRatio = 1.8;
              }
              
              return GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: childAspectRatio,
                children: [
                  _buildQuickActionCard('Add Product', Icons.add_box, Colors.green[600]!),
                  _buildQuickActionCard('View Analytics', Icons.analytics, Colors.purple[600]!),
                  _buildQuickActionCard('Manage Stock', Icons.inventory_2, Colors.orange[600]!),
                  _buildQuickActionCard('View B2B Leads', Icons.people, Colors.blue[600]!),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // Header with icon and trend indicator
          Row(
            children: [
              // Icon container
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const Spacer(),
              // Trend indicator
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Value
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: ResponsiveHelper.isMobile(context) ? 22 : 26,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          // Title
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: ResponsiveHelper.isMobile(context) ? 13 : 14,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Navigate to respective sections
        if (title == 'Add Product') {
          setState(() {
            _selectedTabIndex = 1;
            _tabController.animateTo(1);
          });
        } else if (title == 'View Analytics') {
          setState(() {
            _selectedTabIndex = 4;
            _tabController.animateTo(4);
          });
        } else if (title == 'Manage Stock') {
          setState(() {
            _selectedTabIndex = 2;
            _tabController.animateTo(2);
          });
        } else if (title == 'View B2B Leads') {
          setState(() {
            _selectedTabIndex = 3;
            _tabController.animateTo(3);
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(24),
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: color.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Icon(
                icon,
                color: color,
                size: ResponsiveHelper.isMobile(context) ? 32 : 36,
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: ResponsiveHelper.isMobile(context) ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showResponseDialog(String buyerName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Respond to $buyerName',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Your Quote (₹)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: GoogleFonts.manrope()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Response sent to $buyerName!', style: GoogleFonts.manrope()),
                    backgroundColor: Colors.green[600],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: Text('Send Response', style: GoogleFonts.manrope(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Products Tab
  Widget _buildProducts() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 20, desktop: 24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Actions
          Row(
            children: [
              Expanded(
                child: Text(
                  'Product Management',
                  style: GoogleFonts.manrope(
                    fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 20, tablet: 24, desktop: 28),
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddProductDialog(),
                icon: const Icon(Icons.add),
                label: Text('Add Product', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => _showBulkUploadDialog(),
                icon: const Icon(Icons.file_upload),
                label: Text('Bulk Upload', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue[800],
                  side: BorderSide(color: Colors.blue[800]!),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Product List
          Container(
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
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
              itemBuilder: (context, index) {
                final products = [
                  {'name': 'LED Bulb 9W', 'stock': 120, 'price': 299, 'image': 'assets/images/lights/philips_bulb_single_white_bg.jpeg'},
                  {'name': 'MCB 16A', 'stock': 85, 'price': 450, 'image': 'assets/images/circuit-breakers/electric_mcb_60w_single_white_bg.jpeg'},
                  {'name': 'Wire 2.5mm', 'stock': 200, 'price': 120, 'image': 'assets/images/wires-and-cables/wires1.jpeg'},
                  {'name': 'Tube Light 60W', 'stock': 95, 'price': 180, 'image': 'assets/images/lights/tube_lights_60w_single_white_bg.jpeg'},
                  {'name': 'Circuit Breaker', 'stock': 150, 'price': 320, 'image': 'assets/images/circuit-breakers/circuit_breakers_single_white_bg.jpeg'},
                  {'name': 'Event Light 60W', 'stock': 75, 'price': 250, 'image': 'assets/images/lights/event_lights_60w_single_white_bg.jpeg'},
                  {'name': 'Switch Socket', 'stock': 180, 'price': 150, 'image': 'assets/images/switches/switch1.jpeg'},
                  {'name': 'Cable Wire', 'stock': 300, 'price': 80, 'image': 'assets/images/wires-and-cables/wires2.jpeg'},
                  {'name': 'Panel Board', 'stock': 45, 'price': 1200, 'image': 'assets/images/panels/panel1.jpeg'},
                  {'name': 'Safety Equipment', 'stock': 60, 'price': 350, 'image': 'assets/images/safety/safety1.jpeg'},
                ];
                
                final product = products[index % products.length];
                
                return ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product['image'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.image, color: Colors.grey[400]),
                          );
                        },
                      ),
                    ),
                  ),
                  title: Text(
                    product['name'] as String,
                    style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Stock: ${product['stock']} • Price: ₹${product['price']}',
                    style: GoogleFonts.manrope(color: Colors.grey[600]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _showEditProductDialog(product),
                        icon: Icon(Icons.edit, color: Colors.blue[600]),
                        tooltip: 'Edit',
                      ),
                      IconButton(
                        onPressed: () => _showDeleteProductDialog(product['name'] as String),
                        icon: Icon(Icons.delete_outline, color: Colors.red[600]),
                        tooltip: 'Delete',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    final descriptionController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add New Product',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: priceController,
                        decoration: InputDecoration(
                          labelText: 'Price (₹)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: stockController,
                        decoration: InputDecoration(
                          labelText: 'Stock',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate, color: Colors.grey[400], size: 32),
                      const SizedBox(height: 8),
                      Text(
                        'Add Product Image',
                        style: GoogleFonts.manrope(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: GoogleFonts.manrope()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product added successfully!', style: GoogleFonts.manrope()),
                    backgroundColor: Colors.green[600],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: Text('Add Product', style: GoogleFonts.manrope(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showEditProductDialog(Map<String, dynamic> product) {
    final nameController = TextEditingController(text: product['name']);
    final priceController = TextEditingController(text: product['price'].toString());
    final stockController = TextEditingController(text: product['stock'].toString());
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Product',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: priceController,
                        decoration: InputDecoration(
                          labelText: 'Price (₹)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: stockController,
                        decoration: InputDecoration(
                          labelText: 'Stock',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      product['image'] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(Icons.image, color: Colors.grey[400]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: GoogleFonts.manrope()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product updated successfully!', style: GoogleFonts.manrope()),
                    backgroundColor: Colors.green[600],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: Text('Update Product', style: GoogleFonts.manrope(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteProductDialog(String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Product',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to delete "$productName"? This action cannot be undone.',
            style: GoogleFonts.manrope(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: GoogleFonts.manrope()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product deleted successfully!', style: GoogleFonts.manrope()),
                    backgroundColor: Colors.red[600],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[600]),
              child: Text('Delete', style: GoogleFonts.manrope(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showBulkUploadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Bulk Upload Products',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[50],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_upload, color: Colors.grey[400], size: 32),
                    const SizedBox(height: 8),
                    Text(
                      'Upload CSV/Excel File',
                      style: GoogleFonts.manrope(color: Colors.grey[600]),
                    ),
                    Text(
                      'Max file size: 5MB',
                      style: GoogleFonts.manrope(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Download template',
                style: GoogleFonts.manrope(
                  color: Colors.blue[800],
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: GoogleFonts.manrope()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('File uploaded successfully!', style: GoogleFonts.manrope()),
                    backgroundColor: Colors.green[600],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: Text('Upload', style: GoogleFonts.manrope(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }


  // B2B Leads Tab
  Widget _buildB2BLeads() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 20, desktop: 24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Buyer Leads',
            style: GoogleFonts.manrope(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 20, tablet: 24, desktop: 28),
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 24),
          
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final leads = [
                {'id': '1001', 'product': 'Copper Wire', 'qty': 200, 'target': 240},
                {'id': '1002', 'product': 'LED Bulb 9W', 'qty': 150, 'target': 299},
                {'id': '1003', 'product': 'MCB 32A', 'qty': 75, 'target': 450},
                {'id': '1004', 'product': 'Circuit Breaker', 'qty': 100, 'target': 320},
                {'id': '1005', 'product': 'Tube Light 60W', 'qty': 80, 'target': 180},
                {'id': '1006', 'product': 'Switch Socket', 'qty': 120, 'target': 150},
                {'id': '1007', 'product': 'Cable Wire', 'qty': 300, 'target': 80},
                {'id': '1008', 'product': 'Event Light 60W', 'qty': 60, 'target': 250},
                {'id': '1009', 'product': 'Panel Board', 'qty': 25, 'target': 1200},
                {'id': '1010', 'product': 'Safety Equipment', 'qty': 40, 'target': 350},
                {'id': '1011', 'product': 'Motor 5HP', 'qty': 15, 'target': 8500},
                {'id': '1012', 'product': 'Transformer', 'qty': 8, 'target': 15000},
              ];
              
              final lead = leads[index];
              
              return Container(
                padding: const EdgeInsets.all(16),
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
                    Row(
                      children: [
                        Icon(Icons.mail_outline, color: Colors.blue[600]),
                        const SizedBox(width: 8),
                        Text(
                          'Lead #${lead['id']} • ${lead['product']}',
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'New',
                            style: GoogleFonts.manrope(
                              color: Colors.orange[800],
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Qty: ${lead['qty']} • Target Price: ₹${lead['target']}',
                      style: GoogleFonts.manrope(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _showQuoteDialog(lead),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue[800],
                              side: BorderSide(color: Colors.blue[800]!),
                            ),
                            child: Text('Send Quote', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _showMessageDialog(lead),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[800],
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Message', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  // Plans Tab
  Widget _buildPlans() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 20, desktop: 24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upgrade Your Plan',
            style: GoogleFonts.manrope(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 20, tablet: 24, desktop: 28),
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose the perfect plan to grow your business',
            style: GoogleFonts.manrope(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          
          Row(
            children: [
              Expanded(
                child: _buildPlanCard(
                  'Free',
                  '₹0',
                  '/month',
                  [
                    'Basic product listing',
                    'Limited leads (10/month)',
                    'Basic analytics',
                    'Email support',
                  ],
                  false,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPlanCard(
                  'Plus',
                  '₹999',
                  '/month',
                  [
                    'Priority product listing',
                    'More leads (50/month)',
                    'Advanced analytics',
                    'Phone & email support',
                    'Featured seller badge',
                  ],
                  true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPlanCard(
                  'Pro',
                  '₹2,999',
                  '/month',
                  [
                    'Top placement in search',
                    'Unlimited leads',
                    'Premium analytics',
                    '24/7 priority support',
                    'Verified seller badge',
                    'Custom branding',
                  ],
                  false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(String name, String price, String period, List<String> benefits, bool isHighlighted) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHighlighted ? Colors.blue[800]! : Colors.grey[200]!,
          width: isHighlighted ? 2 : 1,
        ),
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
        children: [
          if (isHighlighted)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Most Popular',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (isHighlighted) const SizedBox(height: 16),
          Text(
            name,
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                price,
                style: GoogleFonts.manrope(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              Text(
                period,
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...benefits.map((benefit) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green[600],
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    benefit,
                    style: GoogleFonts.manrope(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Upgraded to $name plan!', style: GoogleFonts.manrope()),
                    backgroundColor: Colors.green[600],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isHighlighted ? Colors.blue[800] : Colors.grey[100],
                foregroundColor: isHighlighted ? Colors.white : Colors.grey[800],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                isHighlighted ? 'Choose Plan' : 'Current Plan',
                style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Profile & Settings Tab
  Widget _buildProfileReviews() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 20, desktop: 24)),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Profile & Settings',
              style: GoogleFonts.manrope(
                fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 24, tablet: 28, desktop: 32),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage your business information and preferences',
              style: GoogleFonts.manrope(
                fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 14, tablet: 16, desktop: 18),
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 32),
            
            // Business Information Section
            _buildBusinessInformationSection(),
            const SizedBox(height: 32),
            
            // Custom Profile Fields Section
            _buildCustomProfileFieldsSection(),
            const SizedBox(height: 32),
            
            // Preferences Section
            _buildPreferencesSection(),
            const SizedBox(height: 32),
            
            // Save Button
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessInformationSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.business,
                  color: Color(0xFF3B82F6),
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Business Information',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Legal Business Name
          _buildTextField(
            controller: _legalBusinessNameController,
            label: 'Legal Business Name',
            isRequired: true,
            hintText: 'Enter your legal business name',
          ),
          const SizedBox(height: 16),
          
          // GSTIN and Support Phone Row
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _gstinController,
                  label: 'GSTIN',
                  hintText: 'Enter GSTIN number',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _supportPhoneController,
                  label: 'Support Phone',
                  isRequired: true,
                  hintText: 'Enter support phone number',
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Business Email
          _buildTextField(
            controller: _businessEmailController,
            label: 'Business Email',
            hintText: 'Enter business email address',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          
          // Business Address
          _buildTextField(
            controller: _businessAddressController,
            label: 'Business Address',
            hintText: 'Enter your business address',
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomProfileFieldsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Color(0xFF10B981),
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Custom Profile Fields',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _addCustomField,
                icon: const Icon(Icons.add, size: 16),
                label: Text(
                  'Add Field',
                  style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Custom Fields',
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          
          // Custom Fields List
          ..._customFields.map((field) => _buildCustomFieldCard(field)),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.settings,
                  color: Color(0xFF3B82F6),
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Preferences',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Email Notifications
          _buildPreferenceItem(
            title: 'Email Notifications',
            description: 'Receive notifications for new leads and orders',
            value: _emailNotifications,
            onChanged: (value) {
              setState(() {
                _emailNotifications = value;
              });
            },
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          
          // Auto-Quote
          _buildPreferenceItem(
            title: 'Auto-Quote',
            description: 'Automatically generate quotes for standard products',
            value: _autoQuote,
            onChanged: (value) {
              setState(() {
                _autoQuote = value;
              });
            },
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          
          // Lead Alerts
          _buildPreferenceItem(
            title: 'Lead Alerts',
            description: 'Get instant alerts for new B2B inquiries',
            value: _leadAlerts,
            onChanged: (value) {
              setState(() {
                _leadAlerts = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF3B82F6),
            activeTrackColor: const Color(0xFF3B82F6).withOpacity(0.3),
            inactiveThumbColor: const Color(0xFF9CA3AF),
            inactiveTrackColor: const Color(0xFFE2E8F0),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomFieldCard(CustomField field) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  field.label,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _getFieldTypeLabel(field.type),
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: Color(0xFF64748B),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _deleteCustomField(field.id),
                child: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFFEF4444),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Options: ${field.options.join(', ')}',
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => _editCustomFieldOptions(field),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.settings_outlined,
                      size: 14,
                      color: Color(0xFF3B82F6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Edit Options',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: const Color(0xFF3B82F6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    bool isRequired = false,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF374151),
            ),
            children: isRequired
                ? [
                    TextSpan(
                      text: ' *',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFFEF4444),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.manrope(
              color: const Color(0xFF9CA3AF),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Save Changes',
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  String _getFieldTypeLabel(FieldType type) {
    switch (type) {
      case FieldType.text:
        return 'Text';
      case FieldType.dropdown:
        return 'Dropdown';
      case FieldType.checkbox:
        return 'Checkbox';
      case FieldType.radio:
        return 'Radio';
    }
  }

  void _addCustomField() {
    showDialog(
      context: context,
      builder: (context) => _AddCustomFieldDialog(
        onAdd: (field) {
          setState(() {
            _customFields.add(field);
          });
        },
      ),
    );
  }

  void _deleteCustomField(String fieldId) {
    setState(() {
      _customFields.removeWhere((field) => field.id == fieldId);
    });
  }

  void _editCustomFieldOptions(CustomField field) {
    showDialog(
      context: context,
      builder: (context) => _EditOptionsDialog(
        field: field,
        onSave: (updatedField) {
          setState(() {
            final index = _customFields.indexWhere((f) => f.id == field.id);
            if (index != -1) {
              _customFields[index] = updatedField;
            }
          });
        },
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically save to your backend
      // Including business information, custom fields, and preferences
      print('Saving profile with preferences:');
      print('Email Notifications: $_emailNotifications');
      print('Auto-Quote: $_autoQuote');
      print('Lead Alerts: $_leadAlerts');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile and preferences updated successfully!',
            style: GoogleFonts.manrope(),
          ),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
    }
  }

  Widget _buildCertificationItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.verified, color: Colors.green[600], size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                ),
                Text(
                  description,
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
    );
  }

  void _showQuoteDialog(Map<String, dynamic> lead) {
    final quoteController = TextEditingController();
    final messageController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Send Quote for ${lead['product']}',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: quoteController,
                decoration: InputDecoration(
                  labelText: 'Your Quote (₹)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: messageController,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: GoogleFonts.manrope()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Quote sent to Lead #${lead['id']}!', style: GoogleFonts.manrope()),
                    backgroundColor: Colors.green[600],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: Text('Send Quote', style: GoogleFonts.manrope(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showMessageDialog(Map<String, dynamic> lead) {
    final messageController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Message Lead #${lead['id']}',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: messageController,
            decoration: InputDecoration(
              labelText: 'Your Message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            maxLines: 4,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: GoogleFonts.manrope()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Message sent to Lead #${lead['id']}!', style: GoogleFonts.manrope()),
                    backgroundColor: Colors.green[600],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: Text('Send Message', style: GoogleFonts.manrope(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showMessagesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Messages',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 400,
            height: 300,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Text(
                            'B${index + 1}',
                            style: GoogleFonts.manrope(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          'Buyer #${1001 + index}',
                          style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          'Latest message: ${index == 0 ? "Interested in LED bulbs" : "Quote request for MCB"}',
                          style: GoogleFonts.manrope(color: Colors.grey[600]),
                        ),
                        trailing: Text(
                          '${index + 1}h ago',
                          style: GoogleFonts.manrope(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: GoogleFonts.manrope()),
            ),
          ],
        );
      },
    );
  }

  void _showTrendingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Trending Products',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 400,
            height: 300,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      final trendingProducts = [
                        'LED Bulb 9W',
                        'MCB 32A',
                        'Copper Wire 2.5mm',
                        'Circuit Breaker',
                        'Tube Light 60W',
                        'Switch Socket',
                        'Cable Wire',
                        'Panel Board',
                      ];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange[100],
                          child: Text(
                            '${index + 1}',
                            style: GoogleFonts.manrope(
                              color: Colors.orange[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          trendingProducts[index],
                          style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          '${(index + 1) * 50} searches today',
                          style: GoogleFonts.manrope(color: Colors.grey[600]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: GoogleFonts.manrope()),
            ),
          ],
        );
      },
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Settings',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.notifications, color: Colors.blue[600]),
                  title: Text('Notifications', style: GoogleFonts.manrope()),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.language, color: Colors.blue[600]),
                  title: Text('Language', style: GoogleFonts.manrope()),
                  trailing: Text('English', style: GoogleFonts.manrope(color: Colors.grey[600])),
                ),
                ListTile(
                  leading: Icon(Icons.security, color: Colors.blue[600]),
                  title: Text('Privacy', style: GoogleFonts.manrope()),
                ),
                ListTile(
                  leading: Icon(Ionicons.log_out_outline, color: Colors.red[600]),
                  title: Text('Logout', style: GoogleFonts.manrope(color: Colors.red[600])),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: GoogleFonts.manrope()),
            ),
          ],
        );
      },
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Help & Support',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.help_outline, color: Colors.blue[600]),
                  title: Text('FAQ', style: GoogleFonts.manrope()),
                ),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.blue[600]),
                  title: Text('Contact Support', style: GoogleFonts.manrope()),
                ),
                ListTile(
                  leading: Icon(Icons.book, color: Colors.blue[600]),
                  title: Text('User Guide', style: GoogleFonts.manrope()),
                ),
                ListTile(
                  leading: Icon(Icons.feedback, color: Colors.blue[600]),
                  title: Text('Feedback', style: GoogleFonts.manrope()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: GoogleFonts.manrope()),
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
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.manrope(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: GoogleFonts.manrope()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[600]),
              child: Text('Logout', style: GoogleFonts.manrope(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

// Custom Field Model
class CustomField {
  final String id;
  final String label;
  final FieldType type;
  final List<String> options;

  CustomField({
    required this.id,
    required this.label,
    required this.type,
    required this.options,
  });
}

enum FieldType {
  text,
  dropdown,
  checkbox,
  radio,
}

// Add Custom Field Dialog
class _AddCustomFieldDialog extends StatefulWidget {
  final Function(CustomField) onAdd;

  const _AddCustomFieldDialog({required this.onAdd});

  @override
  State<_AddCustomFieldDialog> createState() => _AddCustomFieldDialogState();
}

class _AddCustomFieldDialogState extends State<_AddCustomFieldDialog> {
  final _labelController = TextEditingController();
  FieldType _selectedType = FieldType.text;
  final List<String> _options = [''];

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add Custom Field',
        style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _labelController,
            decoration: const InputDecoration(
              labelText: 'Field Label',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<FieldType>(
            value: _selectedType,
            decoration: const InputDecoration(
              labelText: 'Field Type',
              border: OutlineInputBorder(),
            ),
            items: FieldType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(_getFieldTypeLabel(type)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
          ),
          if (_selectedType == FieldType.dropdown) ...[
            const SizedBox(height: 16),
            Text(
              'Options:',
              style: GoogleFonts.manrope(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            ..._options.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Option ${entry.key + 1}',
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _options[entry.key] = value;
                        },
                      ),
                    ),
                    if (_options.length > 1)
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            _options.removeAt(entry.key);
                          });
                        },
                      ),
                  ],
                ),
              );
            }),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _options.add('');
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Option'),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_labelController.text.isNotEmpty) {
              widget.onAdd(CustomField(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                label: _labelController.text,
                type: _selectedType,
                options: _selectedType == FieldType.dropdown ? _options.where((o) => o.isNotEmpty).toList() : [],
              ));
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  String _getFieldTypeLabel(FieldType type) {
    switch (type) {
      case FieldType.text:
        return 'Text';
      case FieldType.dropdown:
        return 'Dropdown';
      case FieldType.checkbox:
        return 'Checkbox';
      case FieldType.radio:
        return 'Radio';
    }
  }
}

// Edit Options Dialog
class _EditOptionsDialog extends StatefulWidget {
  final CustomField field;
  final Function(CustomField) onSave;

  const _EditOptionsDialog({
    required this.field,
    required this.onSave,
  });

  @override
  State<_EditOptionsDialog> createState() => _EditOptionsDialogState();
}

class _EditOptionsDialogState extends State<_EditOptionsDialog> {
  late List<String> _options;

  @override
  void initState() {
    super.initState();
    _options = List.from(widget.field.options);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Edit Options',
        style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Field: ${widget.field.label}',
            style: GoogleFonts.manrope(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          ..._options.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: entry.value),
                      decoration: InputDecoration(
                        hintText: 'Option ${entry.key + 1}',
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _options[entry.key] = value;
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        _options.removeAt(entry.key);
                      });
                    },
                  ),
                ],
              ),
            );
          }),
          TextButton.icon(
            onPressed: () {
              setState(() {
                _options.add('');
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Option'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave(CustomField(
              id: widget.field.id,
              label: widget.field.label,
              type: widget.field.type,
              options: _options.where((o) => o.isNotEmpty).toList(),
            ));
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
