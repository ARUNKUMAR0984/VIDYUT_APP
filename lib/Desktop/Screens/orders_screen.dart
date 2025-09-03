import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Models/buyer_models.dart';
import 'home_screen.dart';
import 'search_products_screen.dart';
import 'seller_dashboard_screen.dart';
import 'state_info_screen.dart';
import 'wishlist_screen.dart';
import 'cart_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isSidebarVisible = true;
  String _monthFilter = 'All';
  String _categoryFilter = 'All';
  String _sellerFilter = 'All';

  late List<Order> _orders;

  @override
  void initState() {
    super.initState();
    _orders = _sampleOrders();
  }

  List<Order> get filteredOrders {
    return _orders.where((o) {
      final monthOk = _monthFilter == 'All' ||
          _monthFilter == '${o.createdAt.year}-${o.createdAt.month.toString().padLeft(2, '0')}';
      final sellerOk = _sellerFilter == 'All' || o.seller == _sellerFilter;
      // category filter skipped in sample; can be derived from items
      final categoryOk = _categoryFilter == 'All';
      return monthOk && sellerOk && categoryOk;
    }).toList();
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
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildNavItem(Icons.home, 'Home'),
                        _buildNavItem(Icons.search, 'Search Products'),
                        _buildNavItem(Icons.favorite, 'Wishlist', badge: '2'),
                        _buildNavItem(Icons.shopping_cart, 'Shopping Cart', badge: '3'),
                        _buildNavItem(Icons.shopping_bag, 'My Orders', isActive: true, badge: '3'),
                        _buildNavItem(Icons.store, 'Sell'),
                        _buildNavItem(Icons.message, 'Messages', badge: '5'),
                        _buildNavItem(Icons.location_on, 'State Info'),
                        _buildNavItem(Icons.trending_up, 'Trending'),
                        const Divider(height: 32),
                        _buildNavItem(Icons.settings, 'Settings'),
                        _buildNavItem(Icons.help, 'Help'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Main content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with menu toggle
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
                  child: Row(children: [
                    IconButton(
                      icon: Icon(_isSidebarVisible ? Icons.menu_open : Icons.menu, color: Colors.blue[800]),
                      onPressed: () => setState(() => _isSidebarVisible = !_isSidebarVisible),
                    ),
                    const SizedBox(width: 8),
                    Text('My Orders', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[900])),
                  ]),
                ),

                // Filters
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      _buildDropdown('Month', _monthFilter, _monthOptions(), (v) => setState(() => _monthFilter = v)),
                      const SizedBox(width: 12),
                      _buildDropdown('Category', _categoryFilter, const ['All'], (v) => setState(() => _categoryFilter = v)),
                      const SizedBox(width: 12),
                      _buildDropdown('Seller', _sellerFilter, const ['All', 'ElectroMax Industries', 'LightTech Solutions'], (v) => setState(() => _sellerFilter = v)),
                    ],
                  ),
                ),

                const Divider(height: 1),

                // List
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return ListTile(
                        title: Text('Order #${order.id}', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                        subtitle: Text('${order.seller} • ${order.createdAt.toLocal()}\nTotal: ₹${order.totalAmount.toStringAsFixed(0)}', style: GoogleFonts.inter(color: Colors.grey[700])),
                        isThreeLine: true,
                        trailing: _buildStatusChip(order.status),
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, {bool isActive = false, String? badge}) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.blue[800] : Colors.grey[600], size: 20),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: isActive ? Colors.blue[800] : Colors.grey[700],
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
          );
        } else if (title == 'Wishlist') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WishlistScreen()),
          );
        } else if (title == 'Sell') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SellerDashboardScreen()),
          );
        } else if (title == 'Shopping Cart') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartScreen()),
          );
        } else if (title == 'Messages') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Messages coming soon', style: GoogleFonts.inter())),
          );
        } else if (title == 'State Info') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const D_StateInfoScreen()),
          );
        }
      },
    );
  }

  Widget _buildDropdown(String label, String value, List<String> options, ValueChanged<String> onChanged) {
    return Row(
      children: [
        Text('$label: ', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        const SizedBox(width: 6),
        DropdownButton<String>(
          value: value,
          items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => onChanged(v ?? value),
        ),
      ],
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    Color color;
    String text;
    switch (status) {
      case OrderStatus.placed:
        color = Colors.grey;
        text = 'Placed';
        break;
      case OrderStatus.accepted:
        color = Colors.blue;
        text = 'Accepted';
        break;
      case OrderStatus.shipped:
        color = Colors.orange;
        text = 'Shipped';
        break;
      case OrderStatus.completed:
        color = Colors.green;
        text = 'Completed';
        break;
    }
    return Chip(label: Text(text, style: GoogleFonts.inter(color: Colors.white)), backgroundColor: color);
  }

  List<String> _monthOptions() {
    final now = DateTime.now();
    return [
      'All',
      for (int i = 0; i < 6; i++) '${now.year}-${(now.month - i).toString().padLeft(2, '0')}',
    ];
  }

  List<Order> _sampleOrders() {
    final address = Address(
      id: 'addr1',
      label: 'Home',
      line1: '221B Baker Street',
      line2: 'Floor 1',
      city: 'Mumbai',
      state: 'Maharashtra',
      pincode: '400001',
      contactName: 'John Doe',
      contactPhone: '+91 98765 43210',
    );
    return [
      Order(
        id: '1001',
        items: [CartItem(productId: '1', name: 'Copper Wire', quantity: 10, price: 250)],
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        seller: 'ElectroMax Industries',
        status: OrderStatus.shipped,
        shippingAddress: address,
      ),
      Order(
        id: '1002',
        items: [CartItem(productId: '6', name: 'LED Bulb 9W', quantity: 4, price: 299)],
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        seller: 'LightTech Solutions',
        status: OrderStatus.completed,
        shippingAddress: address,
      ),
    ];
  }
}


