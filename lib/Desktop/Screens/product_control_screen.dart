import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/responsive_helper.dart';

class ProductControlScreen extends StatefulWidget {
  const ProductControlScreen({super.key});

  @override
  State<ProductControlScreen> createState() => _ProductControlScreenState();
}

class _ProductControlScreenState extends State<ProductControlScreen> with TickerProviderStateMixin {
  int _selectedTabIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.inventory_2_outlined,
                        color: Colors.green[600],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Product Control',
                      style: GoogleFonts.manrope(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Manage all products, approve/reject submissions, and control product visibility',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Tabs
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.green[600],
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: Colors.green[600],
              labelStyle: GoogleFonts.manrope(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'Pending Approval'),
                Tab(text: 'All Products'),
                Tab(text: 'Bulk Operations'),
                Tab(text: 'Featured Products'),
                Tab(text: 'Categories'),
              ],
            ),
          ),
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPendingApproval(),
                _buildAllProducts(),
                _buildBulkOperations(),
                _buildFeaturedProducts(),
                _buildCategories(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingApproval() {
    final pendingProducts = [
      {
        'name': 'LED Bulb 9W',
        'seller': 'ElectroMart',
        'category': 'Lights',
        'price': '₹299',
        'submitted': '2 hours ago',
        'status': 'pending',
      },
      {
        'name': 'MCB 16A',
        'seller': 'Power Solutions',
        'category': 'Circuit Breakers',
        'price': '₹450',
        'submitted': '4 hours ago',
        'status': 'pending',
      },
      {
        'name': 'Wire 2.5mm',
        'seller': 'Cable King',
        'category': 'Wires & Cables',
        'price': '₹120/m',
        'submitted': '6 hours ago',
        'status': 'pending',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Pending Approval', '12', Icons.pending, Colors.orange),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('Approved Today', '8', Icons.check_circle, Colors.green),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('Rejected Today', '3', Icons.cancel, Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Pending Products List
          Text(
            'Products Awaiting Approval',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          ...pendingProducts.map((product) => _buildPendingProductCard(product)).toList(),
        ],
      ),
    );
  }

  Widget _buildAllProducts() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: 'All Categories',
                items: ['All Categories', 'Lights', 'Circuit Breakers', 'Wires & Cables']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: 'All Status',
                items: ['All Status', 'Active', 'Inactive', 'Pending']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Products Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildTableHeader(),
                ...List.generate(10, (index) => _buildProductRow(index)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulkOperations() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bulk Operations',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildBulkOperationCard(
                  'Import Products',
                  'Upload CSV/Excel file to import multiple products',
                  Icons.upload_file,
                  Colors.blue,
                  () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildBulkOperationCard(
                  'Export Products',
                  'Download all products data in Excel format',
                  Icons.download,
                  Colors.green,
                  () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildBulkOperationCard(
                  'Bulk Price Update',
                  'Update prices for multiple products at once',
                  Icons.price_change,
                  Colors.orange,
                  () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildBulkOperationCard(
                  'Category Migration',
                  'Move products between categories',
                  Icons.category,
                  Colors.purple,
                  () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProducts() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Products Management',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Control which products appear on the homepage',
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          // Featured Products Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.getResponsiveColumns(
                context,
                mobile: 2,
                tablet: 3,
                desktop: 4,
              ),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              return _buildFeaturedProductCard(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Product Categories',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add Category'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Categories Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.getResponsiveColumns(
                context,
                mobile: 2,
                tablet: 3,
                desktop: 4,
              ),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return _buildCategoryCard(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
              Icon(icon, color: color, size: 24),
              const Spacer(),
              Text(
                value,
                style: GoogleFonts.manrope(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingProductCard(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
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
          // Product Image Placeholder
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
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${product['seller']} • ${product['category']}',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Submitted ${product['submitted']}',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          // Actions
          Row(
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red[600],
                  side: BorderSide(color: Colors.red[200]!),
                ),
                child: const Text('Reject'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Approve'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text('Product', style: GoogleFonts.manrope(fontWeight: FontWeight.w600))),
          Expanded(child: Text('Seller', style: GoogleFonts.manrope(fontWeight: FontWeight.w600))),
          Expanded(child: Text('Category', style: GoogleFonts.manrope(fontWeight: FontWeight.w600))),
          Expanded(child: Text('Price', style: GoogleFonts.manrope(fontWeight: FontWeight.w600))),
          Expanded(child: Text('Status', style: GoogleFonts.manrope(fontWeight: FontWeight.w600))),
          Expanded(child: Text('Actions', style: GoogleFonts.manrope(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildProductRow(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(Icons.image, color: Colors.grey[400], size: 20),
                ),
                const SizedBox(width: 12),
                Text('Product ${index + 1}', style: GoogleFonts.manrope()),
              ],
            ),
          ),
          Expanded(child: Text('Seller ${index + 1}', style: GoogleFonts.manrope())),
          Expanded(child: Text('Category ${index + 1}', style: GoogleFonts.manrope())),
          Expanded(child: Text('₹${(index + 1) * 100}', style: GoogleFonts.manrope())),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Active',
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  color: Colors.green[700],
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: Colors.blue[600], size: 18),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.red[600], size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulkOperationCard(String title, String description, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
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
                Icon(icon, color: color, size: 24),
                const Spacer(),
                Icon(Icons.arrow_forward_ios, color: color, size: 16),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedProductCard(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.image, color: Colors.grey[400], size: 40),
          ),
          const SizedBox(height: 12),
          Text(
            'Featured Product ${index + 1}',
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('Remove'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.category, color: Colors.blue[600], size: 20),
              ),
              const Spacer(),
              PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
                child: Icon(Icons.more_vert, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Category ${index + 1}',
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${(index + 1) * 25} products',
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
