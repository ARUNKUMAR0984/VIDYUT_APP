import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/responsive_helper.dart';
import 'admin_login_screen.dart';
import 'product_control_screen.dart';
import 'seller_control_screen.dart';
import 'buyer_control_screen.dart';
import 'content_management_screen.dart';
import 'orders_payments_screen.dart';
import 'analytics_reports_screen.dart';
import 'simulation_mode_screen.dart';
import 'messaging_screen.dart';
import 'platform_config_screen.dart';
import 'security_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;
  bool _isSidebarVisible = true;

  final List<AdminModule> _modules = [
    AdminModule(
      title: 'Dashboard',
      icon: Icons.dashboard_outlined,
      color: Colors.blue,
      screen: null, // Will show overview
    ),
    AdminModule(
      title: 'Product Control',
      icon: Icons.inventory_2_outlined,
      color: Colors.green,
      screen: const ProductControlScreen(),
    ),
    AdminModule(
      title: 'Seller Control',
      icon: Icons.business_outlined,
      color: Colors.orange,
      screen: const SellerControlScreen(),
    ),
    AdminModule(
      title: 'Buyer Control',
      icon: Icons.people_outline,
      color: Colors.purple,
      screen: const BuyerControlScreen(),
    ),
    AdminModule(
      title: 'Content Management',
      icon: Icons.content_copy_outlined,
      color: Colors.teal,
      screen: const ContentManagementScreen(),
    ),
    AdminModule(
      title: 'Orders & Payments',
      icon: Icons.payment_outlined,
      color: Colors.red,
      screen: const OrdersPaymentsScreen(),
    ),
    AdminModule(
      title: 'Analytics & Reports',
      icon: Icons.analytics_outlined,
      color: Colors.indigo,
      screen: const AnalyticsReportsScreen(),
    ),
    AdminModule(
      title: 'Simulation Mode',
      icon: Icons.sim_card_outlined,
      color: Colors.pink,
      screen: const SimulationModeScreen(),
    ),
    AdminModule(
      title: 'Messaging',
      icon: Icons.message_outlined,
      color: Colors.cyan,
      screen: const MessagingScreen(),
    ),
    AdminModule(
      title: 'Platform Config',
      icon: Icons.settings_outlined,
      color: Colors.grey,
      screen: const PlatformConfigScreen(),
    ),
    AdminModule(
      title: 'Security',
      icon: Icons.security_outlined,
      color: Colors.brown,
      screen: const SecurityScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Row(
        children: [
          // Sidebar
          if (_isSidebarVisible) _buildSidebar(),
          // Main Content
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: _selectedIndex == 0
                      ? _buildDashboardOverview()
                      : _modules[_selectedIndex].screen ?? Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!),
              ),
            ),
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
                    Icons.admin_panel_settings,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin Portal',
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900],
                        ),
                      ),
                      Text(
                        'Superuser Access',
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
          // Navigation Menu
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _modules.length,
              itemBuilder: (context, index) {
                final module = _modules[index];
                final isSelected = _selectedIndex == index;
                
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: ListTile(
                    leading: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? module.color.withOpacity(0.1)
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        module.icon,
                        color: isSelected ? module.color : Colors.grey[600],
                        size: 20,
                      ),
                    ),
                    title: Text(
                      module.title,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? module.color : Colors.grey[700],
                      ),
                    ),
                    selected: isSelected,
                    selectedTileColor: module.color.withOpacity(0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Logout Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
                  );
                },
                icon: const Icon(Icons.logout, size: 18),
                label: Text(
                  'Logout',
                  style: GoogleFonts.manrope(fontSize: 14),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red[600],
                  side: BorderSide(color: Colors.red[200]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Toggle Sidebar Button
          IconButton(
            onPressed: () {
              setState(() {
                _isSidebarVisible = !_isSidebarVisible;
              });
            },
            icon: Icon(
              _isSidebarVisible ? Icons.menu_open : Icons.menu,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(width: 16),
          // Page Title
          Text(
            _selectedIndex == 0 ? 'Dashboard Overview' : _modules[_selectedIndex].title,
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const Spacer(),
          // Admin Info
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Super Admin',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardOverview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue[600]!,
                  Colors.blue[800]!,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Admin Portal',
                  style: GoogleFonts.manrope(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Full control over the Vidyut platform',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildQuickStat('Total Users', '12,450', Icons.people, Colors.white),
                    const SizedBox(width: 20),
                    _buildQuickStat('Active Sellers', '1,250', Icons.business, Colors.white),
                    const SizedBox(width: 20),
                    _buildQuickStat('Products', '45,600', Icons.inventory_2, Colors.white),
                    const SizedBox(width: 20),
                    _buildQuickStat('Revenue', '₹2.5M', Icons.currency_rupee, Colors.white),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Modules Grid
          Text(
            'Admin Modules',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.getResponsiveColumns(
                context,
                mobile: 1,
                tablet: 2,
                desktop: 3,
              ),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: _modules.length - 1, // Exclude dashboard
            itemBuilder: (context, index) {
              final module = _modules[index + 1];
              return _buildModuleCard(module, index + 1);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard(AdminModule module, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: module.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                module.icon,
                color: module.color,
                size: 24,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              module.title,
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getModuleDescription(module.title),
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  'Access Module',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: module.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: module.color,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getModuleDescription(String title) {
    switch (title) {
      case 'Product Control':
        return 'Manage products, approve/reject, bulk operations';
      case 'Seller Control':
        return 'KYC approval, seller management, tier control';
      case 'Buyer Control':
        return 'User management, profile control, account actions';
      case 'Content Management':
        return 'CMS, homepage sections, static pages';
      case 'Orders & Payments':
        return 'Transaction management, refunds, commissions';
      case 'Analytics & Reports':
        return 'Global metrics, performance dashboards';
      case 'Simulation Mode':
        return 'Impersonate users, audit trail';
      case 'Messaging':
        return 'Push notifications, campaigns, disputes';
      case 'Platform Config':
        return 'Brand settings, feature toggles, KYC config';
      case 'Security':
        return 'Role management, sub-admins, access control';
      default:
        return 'Admin module functionality';
    }
  }
}

class AdminModule {
  final String title;
  final IconData icon;
  final Color color;
  final Widget? screen;

  AdminModule({
    required this.title,
    required this.icon,
    required this.color,
    this.screen,
  });
}
