import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'search_products_screen.dart';
import 'wishlist_screen.dart';
import 'cart_screen.dart';
import 'state_info_screen.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen>
    with SingleTickerProviderStateMixin {
  bool _isSidebarVisible = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  Widget _navItem(IconData icon, String title, {bool isActive = false, String? badge}) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.blue[800] : Colors.grey[600], size: 20),
      title: Text(title, style: GoogleFonts.inter(color: isActive ? Colors.blue[800] : Colors.grey[700], fontWeight: isActive ? FontWeight.w600 : FontWeight.w500)),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.red[500], borderRadius: BorderRadius.circular(10)),
              child: Text(badge, style: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            )
          : null,
      onTap: () {
        if (title == 'Home') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const D_HomeScreen()),
            (route) => false,
          );
        } else if (title == 'Search Products') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()));
        } else if (title == 'Wishlist') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const WishlistScreen()));
        } else if (title == 'Shopping Cart') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
        } else if (title == 'State Info') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const D_StateInfoScreen()));
        }
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          if (_isSidebarVisible)
            Container(
              width: 280,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(children: [
                      Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.blue[800], borderRadius: BorderRadius.circular(8)), child: const Center(child: Icon(Icons.flash_on, color: Colors.white))),
                      const SizedBox(width: 12),
                      Text('Vidyut', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                    ]),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _navItem(Icons.home, 'Home'),
                        _navItem(Icons.search, 'Search Products'),
                        _navItem(Icons.favorite, 'Wishlist', badge: '2'),
                        _navItem(Icons.shopping_cart, 'Shopping Cart', badge: '3'),
                        _navItem(Icons.store, 'Sell', isActive: true),
                        _navItem(Icons.message, 'Messages', badge: '5'),
                        _navItem(Icons.location_on, 'State Info'),
                        _navItem(Icons.trending_up, 'Trending'),
                        const Divider(height: 32),
                        _navItem(Icons.settings, 'Settings'),
                        _navItem(Icons.help, 'Help'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
                  child: Row(children: [
                    IconButton(
                      icon: Icon(_isSidebarVisible ? Icons.menu_open : Icons.menu, color: Colors.blue[800]),
                      onPressed: () => setState(() => _isSidebarVisible = !_isSidebarVisible),
                    ),
                    const SizedBox(width: 8),
                    Text('Seller Center', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    // Tab buttons mirroring TabBar
                    ToggleButtons(
                      isSelected: List.generate(7, (i) => i == _tabController.index),
                      onPressed: (i) => setState(() => _tabController.index = i),
                      borderRadius: BorderRadius.circular(6),
                      children: const [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Dashboard')),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Products')),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Stock')),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Leads')),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Analytics')),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Plans')),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Profile')),
                      ],
                    ),
                  ]),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildDashboard(),
                      _buildProducts(),
                      _buildStockPricing(),
                      _buildLeads(),
                      _buildAnalytics(),
                      _buildPlans(),
                      _buildProfileReviews(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 1) Dashboard
  Widget _buildDashboard() {
    Widget card(String title, String value, Color color, IconData icon) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.15), child: Icon(icon, color: color)),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: GoogleFonts.inter(color: Colors.grey[600])),
              Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18)),
            ]),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            childAspectRatio: 2.8,
            children: [
              card('Leads (7d)', '24', Colors.blue, Icons.inbox),
              card('Sales (7d)', '58', Colors.green, Icons.shopping_bag),
              card('Earnings (7d)', '₹1,42,300', Colors.purple, Icons.currency_rupee),
            ],
          ),
          const SizedBox(height: 20),
          Text('Recent Leads', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: 8,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                return ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: Text('Buyer #${i + 1} requested quote'),
                  subtitle: const Text('Product: LED Panel 18W • Qty: 50'),
                  trailing: TextButton(onPressed: () {}, child: const Text('Respond')),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // 2) Products CRUD (simplified placeholders)
  Widget _buildProducts() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(children: [
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Add Product')),
            const SizedBox(width: 12),
            OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.file_upload), label: const Text('Bulk Upload')),
          ]),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Container(width: 48, height: 48, color: Colors.grey[200], child: const Icon(Icons.image)),
                  title: Text('Product ${i + 1}', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Stock: 120 • Price: ₹499'),
                  trailing: Wrap(spacing: 8, children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline)),
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 3) Stock & Pricing
  Widget _buildStockPricing() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              title: Text('Item ${i + 1}'),
              subtitle: Row(children: [
                Expanded(child: TextFormField(decoration: const InputDecoration(labelText: 'Stock'))),
                const SizedBox(width: 12),
                Expanded(child: TextFormField(decoration: const InputDecoration(labelText: 'Price (₹)'))),
              ]),
              trailing: ElevatedButton(onPressed: () {}, child: const Text('Save')),
            ),
          );
        },
      ),
    );
  }

  // 4) Leads inbox
  Widget _buildLeads() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: 12,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) => ListTile(
          leading: const Icon(Icons.mail_outline),
          title: Text('Lead #${1000 + i} • Copper Wire'),
          subtitle: const Text('Qty: 200 • Target: ₹240'),
          trailing: Wrap(spacing: 8, children: [
            OutlinedButton(onPressed: () {}, child: const Text('Quote')),
            ElevatedButton(onPressed: () {}, child: const Text('Message')),
          ]),
        ),
      ),
    );
  }

  // 5) Analytics (placeholders)
  Widget _buildAnalytics() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top-selling Products (30d)', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: const [
                ListTile(title: Text('LED Bulb 9W'), trailing: Text('1,240 units')),
                ListTile(title: Text('MCB 32A'), trailing: Text('870 units')),
                ListTile(title: Text('Copper Wire 2.5 sq.mm'), trailing: Text('650 units')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 6) Plans (Upgrade)
  Widget _buildPlans() {
    Widget plan(String name, String price, List<String> benefits, {bool highlight = false}) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: highlight ? Colors.blue[800]! : Colors.grey[200]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
              Text(price, style: GoogleFonts.inter(color: Colors.blue[800], fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              ...benefits.map((b) => Row(children: [const Icon(Icons.check, size: 16, color: Colors.green), const SizedBox(width: 6), Expanded(child: Text(b))])),
              const SizedBox(height: 12),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Choose'))),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Row(children: [
          plan('Free', '₹0/mo', const ['Basic listing', 'Limited leads']),
          const SizedBox(width: 12),
          plan('Plus', '₹999/mo', const ['Priority listing', 'More leads', 'Basic analytics'], highlight: true),
          const SizedBox(width: 12),
          plan('Pro', '₹2,999/mo', const ['Top placement', 'Unlimited leads', 'Advanced analytics']),
        ]),
      ]),
    );
  }

  // 7) Profile & Reviews
  Widget _buildProfileReviews() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    CircleAvatar(radius: 24, backgroundColor: Colors.blue[100], child: const Icon(Icons.storefront, color: Colors.blue)),
                    const SizedBox(width: 12),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('ElectroMax Industries', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                      Row(children: const [Icon(Icons.verified, color: Colors.blue, size: 16), SizedBox(width: 4), Text('Verified')]),
                    ])
                  ]),
                  const SizedBox(height: 12),
                  Text('Certifications', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  const Text('• BIS Certified\n• ISO 9001:2015'),
                ]),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Reviews
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Recent Reviews', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  ...List.generate(4, (i) => ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: Text('Buyer ${i + 1}'),
                        subtitle: const Text('Great quality and prompt shipping.'),
                        trailing: Row(mainAxisSize: MainAxisSize.min, children: List.generate(5, (s) => const Icon(Icons.star, size: 16, color: Colors.amber))),
                      )),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


