import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/responsive_helper.dart';

class SellerControlScreen extends StatefulWidget {
  const SellerControlScreen({super.key});

  @override
  State<SellerControlScreen> createState() => _SellerControlScreenState();
}

class _SellerControlScreenState extends State<SellerControlScreen> with TickerProviderStateMixin {
  int _selectedTabIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
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
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.business_outlined,
                        color: Colors.orange[600],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Seller Control',
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
                  'Manage seller accounts, KYC verification, and seller tiers',
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
              labelColor: Colors.orange[600],
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: Colors.orange[600],
              labelStyle: GoogleFonts.manrope(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'KYC Pending'),
                Tab(text: 'All Sellers'),
                Tab(text: 'Seller Tiers'),
                Tab(text: 'Impersonation'),
                Tab(text: 'Suspended'),
                Tab(text: 'Analytics'),
              ],
            ),
          ),
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildKYCPending(),
                _buildAllSellers(),
                _buildSellerTiers(),
                _buildImpersonation(),
                _buildSuspended(),
                _buildAnalytics(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKYCPending() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats
          Row(
            children: [
              Expanded(child: _buildStatCard('Pending KYC', '8', Icons.pending, Colors.orange)),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard('Approved Today', '5', Icons.check_circle, Colors.green)),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard('Rejected Today', '2', Icons.cancel, Colors.red)),
            ],
          ),
          const SizedBox(height: 24),
          // KYC Applications
          Text(
            'KYC Applications',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(5, (index) => _buildKYCCard(index)),
        ],
      ),
    );
  }

  Widget _buildAllSellers() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search sellers...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: 'All Tiers',
                items: ['All Tiers', 'Free', 'Plus', 'Pro']
                    .map((tier) => DropdownMenuItem(value: tier, child: Text(tier)))
                    .toList(),
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Sellers Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)],
            ),
            child: Column(
              children: [
                _buildSellerTableHeader(),
                ...List.generate(10, (index) => _buildSellerRow(index)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerTiers() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seller Tier Management',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _buildTierCard('Free', '₹0/month', Colors.grey, 'Basic features')),
              const SizedBox(width: 16),
              Expanded(child: _buildTierCard('Plus', '₹999/month', Colors.blue, 'Enhanced features')),
              const SizedBox(width: 16),
              Expanded(child: _buildTierCard('Pro', '₹2999/month', Colors.purple, 'Premium features')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpersonation() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seller Impersonation',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Simulate seller dashboard to troubleshoot issues',
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)],
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Seller Email or ID',
                    hintText: 'Enter seller email to impersonate',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Start Impersonation'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuspended() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suspended Sellers',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 24),
          ...List.generate(3, (index) => _buildSuspendedSellerCard(index)),
        ],
      ),
    );
  }

  Widget _buildAnalytics() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seller Analytics',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _buildStatCard('Total Sellers', '1,250', Icons.business, Colors.orange)),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard('Active Sellers', '1,180', Icons.check_circle, Colors.green)),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard('New This Month', '45', Icons.trending_up, Colors.blue)),
            ],
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
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)],
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

  Widget _buildKYCCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange[100],
            child: Icon(Icons.person, color: Colors.orange[600]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seller ${index + 1}',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'seller${index + 1}@example.com',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Submitted 2 days ago',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
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

  Widget _buildSellerTableHeader() {
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
          Expanded(flex: 2, child: Text('Seller', style: GoogleFonts.manrope(fontWeight: FontWeight.w600))),
          Expanded(child: Text('Tier', style: GoogleFonts.manrope(fontWeight: FontWeight.w600))),
          Expanded(child: Text('Products', style: GoogleFonts.manrope(fontWeight: FontWeight.w600))),
          Expanded(child: Text('Status', style: GoogleFonts.manrope(fontWeight: FontWeight.w600))),
          Expanded(child: Text('Actions', style: GoogleFonts.manrope(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildSellerRow(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.orange[100],
                  child: Icon(Icons.person, color: Colors.orange[600], size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Seller ${index + 1}', style: GoogleFonts.manrope()),
                    Text('seller${index + 1}@example.com', style: GoogleFonts.manrope(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Plus',
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  color: Colors.blue[700],
                ),
              ),
            ),
          ),
          Expanded(child: Text('${(index + 1) * 5}', style: GoogleFonts.manrope())),
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
                  icon: Icon(Icons.block, color: Colors.red[600], size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierCard(String tier, String price, Color color, String description) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)],
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
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.star, color: color, size: 20),
              ),
              const Spacer(),
              Text(
                price,
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            tier,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildSuspendedSellerCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.red[100],
            child: Icon(Icons.person, color: Colors.red[600]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Suspended Seller ${index + 1}',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Reason: Policy violation',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Suspended 3 days ago',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
            ),
            child: const Text('Reinstate'),
          ),
        ],
      ),
    );
  }
}
