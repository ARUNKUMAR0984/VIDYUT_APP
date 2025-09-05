import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/responsive_helper.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;
  
  const OrderTrackingScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int _currentStep = 2; // Example: Order is currently being processed
  
  final List<OrderStep> _orderSteps = [
    OrderStep(
      title: 'Order Placed',
      description: 'Your order has been confirmed',
      icon: Icons.shopping_cart,
      completed: true,
    ),
    OrderStep(
      title: 'Payment Confirmed',
      description: 'Payment has been processed successfully',
      icon: Icons.payment,
      completed: true,
    ),
    OrderStep(
      title: 'Processing',
      description: 'Seller is preparing your order',
      icon: Icons.inventory_2,
      completed: false,
      isCurrent: true,
    ),
    OrderStep(
      title: 'Shipped',
      description: 'Order has been dispatched',
      icon: Icons.local_shipping,
      completed: false,
    ),
    OrderStep(
      title: 'Delivered',
      description: 'Order delivered successfully',
      icon: Icons.home,
      completed: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Order Tracking',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary Card
            _buildOrderSummaryCard(),
            const SizedBox(height: 24),
            
            // Tracking Progress
            _buildTrackingProgress(),
            const SizedBox(height: 24),
            
            // Order Details
            _buildOrderDetails(),
            const SizedBox(height: 24),
            
            // Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.receipt_long,
                  color: Colors.blue[600],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${widget.orderId}',
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Placed on ${_getOrderDate()}',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Processing',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange[700],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem('Total Amount', '₹2,450'),
              ),
              Expanded(
                child: _buildSummaryItem('Items', '3'),
              ),
              Expanded(
                child: _buildSummaryItem('Seller', 'ElectroMart'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingProgress() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Text(
            'Order Progress',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 20),
          ..._orderSteps.asMap().entries.map((entry) {
            int index = entry.key;
            OrderStep step = entry.value;
            bool isLast = index == _orderSteps.length - 1;
            
            return _buildStepItem(step, isLast);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStepItem(OrderStep step, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step Icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: step.completed 
                ? Colors.green[100]
                : step.isCurrent 
                    ? Colors.blue[100]
                    : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: step.completed 
                  ? Colors.green[600]!
                  : step.isCurrent 
                      ? Colors.blue[600]!
                      : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Icon(
            step.icon,
            color: step.completed 
                ? Colors.green[600]
                : step.isCurrent 
                    ? Colors.blue[600]
                    : Colors.grey[400],
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        // Step Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: step.completed || step.isCurrent 
                      ? Colors.grey[900]
                      : Colors.grey[500],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                step.description,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: step.completed || step.isCurrent 
                      ? Colors.grey[600]
                      : Colors.grey[400],
                ),
              ),
              if (!isLast) const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Text(
            'Order Details',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(3, (index) => _buildOrderItem(index)),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              Text(
                '₹2,450',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(int index) {
    final items = [
      {'name': 'LED Bulb 9W', 'qty': '2', 'price': '₹598'},
      {'name': 'MCB 16A', 'qty': '1', 'price': '₹450'},
      {'name': 'Wire 2.5mm', 'qty': '10m', 'price': '₹1,200'},
    ];
    
    final item = items[index];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.image, color: Colors.grey[400]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name']!,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[900],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Qty: ${item['qty']}',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            item['price']!,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Navigate to reorder
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue[600],
              side: BorderSide(color: Colors.blue[600]!),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Reorder',
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Contact seller or support
              _showContactOptions();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Contact Seller',
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showContactOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Contact Options',
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.chat, color: Colors.blue[600]),
              title: Text('Chat with Seller'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to chat
              },
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.green[600]),
              title: Text('Call Seller'),
              onTap: () {
                Navigator.pop(context);
                // Make phone call
              },
            ),
            ListTile(
              leading: Icon(Icons.support_agent, color: Colors.orange[600]),
              title: Text('Contact Support'),
              onTap: () {
                Navigator.pop(context);
                // Contact support
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getOrderDate() {
    return 'Dec 15, 2024 at 2:30 PM';
  }
}

class OrderStep {
  final String title;
  final String description;
  final IconData icon;
  final bool completed;
  final bool isCurrent;

  OrderStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.completed,
    this.isCurrent = false,
  });
}
