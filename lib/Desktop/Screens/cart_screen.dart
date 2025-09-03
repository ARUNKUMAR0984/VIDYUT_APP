import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_details_screen.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample cart items
  final List<Map<String, dynamic>> cartItems = [
    {
      'id': '1',
      'name': 'Copper Wire 2.5 sq.mm',
      'price': '₹2,500',
      'originalPrice': '₹3,200',
      'discount': '22%',
      'image': 'assets/images/wires-and-cables/copper_wire.jpeg',
      'seller': 'ElectroMax Industries',
      'quantity': 2,
      'stock': 50,
      'deliveryTime': '3-5 days',
      'minOrder': '1 Unit',
    },
    {
      'id': '2',
      'name': 'LED Panel Light 18W',
      'price': '₹450',
      'originalPrice': '₹600',
      'discount': '25%',
      'image': 'assets/images/lights/led_panel.jpeg',
      'seller': 'LightTech Solutions',
      'quantity': 5,
      'stock': 200,
      'deliveryTime': '2-4 days',
      'minOrder': '10 Units',
    },
    {
      'id': '3',
      'name': 'MCB 32A Single Pole',
      'price': '₹180',
      'originalPrice': '₹250',
      'discount': '28%',
      'image': 'assets/images/circuit-breakers/mcb_32a.jpeg',
      'seller': 'CircuitPro Ltd',
      'quantity': 10,
      'stock': 75,
      'deliveryTime': '1-3 days',
      'minOrder': '5 Units',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header
          _buildHeader(),
          
          // Main Content
          Expanded(
            child: Row(
              children: [
                // Cart Items
                Expanded(
                  flex: 2,
                  child: _buildCartItems(),
                ),
                
                // Order Summary
                Expanded(
                  flex: 1,
                  child: _buildOrderSummary(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF1976D2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'V',
                    style: TextStyle(
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
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1976D2),
                ),
              ),
            ],
          ),
          
          const Spacer(),
          
          // Navigation Menu
          Row(
            children: [
              _buildNavItem('Home'),
              _buildNavItem('Products'),
              _buildNavItem('Suppliers'),
              _buildNavItem('Buy Leads'),
              _buildNavItem('Sell'),
            ],
          ),
          
          const Spacer(),
          
          // Right Side Actions
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border, color: Color(0xFF1976D2)),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart, color: Color(0xFF1976D2)),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () {},
                child: Text(
                  'Sign In',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Register',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: GoogleFonts.inter(
            color: const Color(0xFF424242),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCartItems() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cart Header
          Row(
            children: [
              Text(
                'Shopping Cart',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF212121),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1976D2).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${cartItems.length} items',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1976D2),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    cartItems.clear();
                  });
                },
                child: Text(
                  'Clear Cart',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFD32F2F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Cart Items List
          Expanded(
            child: cartItems.isEmpty
                ? _buildEmptyCart()
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return _buildCartItemCard(item, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2).withOpacity(0.1),
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 60,
              color: Color(0xFF1976D2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some products to your cart to get started',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Continue Shopping',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade100,
                    child: Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(width: 20),
          
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name and Seller
                Text(
                        item['name'],
                  style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                    color: const Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'by ${item['seller']}',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF424242),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Price and Discount
                Row(
                  children: [
                    Text(
                      item['price'],
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1976D2),
                      ),
                    ),
                      const SizedBox(width: 8),
                      Text(
                        item['originalPrice'],
                      style: GoogleFonts.inter(
                          fontSize: 14,
                        color: Colors.grey.shade500,
                          decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item['discount'],
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4CAF50),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Business Info
                Row(
                  children: [
                    Icon(Icons.schedule, color: Colors.grey.shade400, size: 14),
                    const SizedBox(width: 4),
                          Text(
                      'Delivery: ${item['deliveryTime']}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF424242),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.shopping_cart, color: Colors.grey.shade400, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Min: ${item['minOrder']}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF424242),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Quantity Controls
          Column(
        children: [
              // Quantity Selector
                      Container(
                        decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                      children: [
                    IconButton(
                      onPressed: () {
                        if (item['quantity'] > 1) {
                          setState(() {
                            item['quantity']--;
                          });
                        }
                      },
                      icon: Icon(Icons.remove, color: const Color(0xFF1976D2)),
                    ),
                Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text(
                        item['quantity'].toString(),
                        style: GoogleFonts.inter(
                          fontSize: 16,
                                fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (item['quantity'] < item['stock']) {
                          setState(() {
                            item['quantity']++;
                          });
                        }
                      },
                      icon: Icon(Icons.add, color: const Color(0xFF1976D2)),
                ),
              ],
            ),
          ),
          
              const SizedBox(height: 8),
              
              // Remove Button
              TextButton(
                onPressed: () {
                  setState(() {
                    cartItems.removeAt(index);
                  });
                },
                child: Text(
                  'Remove',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFD32F2F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Summary Header
          Text(
            'Order Summary',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF212121),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Summary Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Items Count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Items (${cartItems.length})',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF424242),
                      ),
                    ),
                    Text(
                      '₹${_calculateSubtotal()}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF212121),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Discount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF424242),
                      ),
                    ),
                    Text(
                      '-₹${_calculateDiscount()}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Delivery
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                    Text(
                      'Delivery',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF424242),
                      ),
                    ),
                          Text(
                      'Free',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                              fontWeight: FontWeight.w600,
                        color: const Color(0xFF4CAF50),
                            ),
                          ),
                        ],
                      ),
                
                const Divider(height: 32),
                
                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Text(
                      'Total',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF212121),
                      ),
                    ),
                    Text(
                      '₹${_calculateTotal()}',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1976D2),
                        ),
                      ),
                    ],
                ),
                
                const SizedBox(height: 24),
                
                // Checkout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: cartItems.isEmpty ? null : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckoutScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                            'Proceed to Checkout',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Continue Shopping Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Continue Shopping',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Additional Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF1976D2).withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.security, color: const Color(0xFF1976D2), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Secure Checkout',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1976D2),
          ),
        ),
      ],
                ),
                const SizedBox(height: 8),
          Text(
                  'Your payment information is encrypted and secure. We never store your credit card details.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF424242),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _calculateSubtotal() {
    double subtotal = 0;
    for (var item in cartItems) {
      double price = double.parse(item['price'].replaceAll(RegExp(r'[^\d.]'), ''));
      subtotal += price * item['quantity'];
    }
    return subtotal.toStringAsFixed(0);
  }

  String _calculateDiscount() {
    double discount = 0;
    for (var item in cartItems) {
      double originalPrice = double.parse(item['originalPrice'].replaceAll(RegExp(r'[^\d.]'), ''));
      double currentPrice = double.parse(item['price'].replaceAll(RegExp(r'[^\d.]'), ''));
      discount += (originalPrice - currentPrice) * item['quantity'];
    }
    return discount.toStringAsFixed(0);
  }

  String _calculateTotal() {
    double subtotal = double.parse(_calculateSubtotal());
    double discount = double.parse(_calculateDiscount());
    return (subtotal - discount).toStringAsFixed(0);
  }
}
