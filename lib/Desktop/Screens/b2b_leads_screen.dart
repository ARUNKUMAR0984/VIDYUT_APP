import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';

class B2BLeadsScreen extends StatefulWidget {
  const B2BLeadsScreen({super.key});

  @override
  State<B2BLeadsScreen> createState() => _B2BLeadsScreenState();
}

class _B2BLeadsScreenState extends State<B2BLeadsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _sizeFilter = 'All sizes';
  String _sectorFilter = 'All sectors';

  final List<Map<String, String>> leads = [
    {
      'name': 'Reliance Industries',
      'sector': 'Oil & Gas',
      'city': 'Mumbai, Maharashtra',
      'turnover': '₹7,00,000 Cr',
      'tag': 'Enterprise',
      'phone': '+91-22-123456',
      'email': 'info@ril.com',
      'website': 'https://www.ril.com',
    },
    {
      'name': 'Larsen & Toubro (L&T)',
      'sector': 'EPC',
      'city': 'Mumbai, Maharashtra',
      'turnover': '₹1,80,000 Cr',
      'tag': 'Enterprise',
      'phone': '+91-22-987654',
      'email': 'contact@lnt.com',
      'website': 'https://www.larsentoubro.com',
    },
    {
      'name': 'Adani Power',
      'sector': 'Power',
      'city': 'Ahmedabad, Gujarat',
      'turnover': '₹54,000 Cr',
      'tag': 'Enterprise',
      'phone': '+91-79-123400',
      'email': 'hello@adani.com',
      'website': 'https://www.adani.com',
    },
    {
      'name': 'Tata Power',
      'sector': 'Power',
      'city': 'Mumbai, Maharashtra',
      'turnover': '₹55,000 Cr',
      'tag': 'Enterprise',
      'phone': '+91-22-223344',
      'email': 'sales@tatapower.com',
      'website': 'https://www.tatapower.com',
    },
    {
      'name': 'NTPC Limited',
      'sector': 'Power',
      'city': 'New Delhi, Delhi',
      'turnover': '₹1,50,000 Cr',
      'tag': 'Enterprise',
      'phone': '+91-11-555666',
      'email': 'enquiry@ntpc.co.in',
      'website': 'https://www.ntpc.co.in',
    },
    {
      'name': 'GVK Power & Infra',
      'sector': 'Infrastructure',
      'city': 'Hyderabad, Telangana',
      'turnover': '₹9,500 Cr',
      'tag': 'Large',
      'phone': '+91-40-888999',
      'email': 'biz@gvk.com',
      'website': 'https://www.gvk.com',
    },
  ];

  List<Map<String, String>> get filteredLeads {
    final q = _searchController.text.trim().toLowerCase();
    return leads.where((l) {
      final matchesQuery = q.isEmpty ||
          l['name']!.toLowerCase().contains(q) ||
          l['sector']!.toLowerCase().contains(q) ||
          l['city']!.toLowerCase().contains(q);
      final matchesSector = _sectorFilter == 'All sectors' || l['sector'] == _sectorFilter;
      // size filter kept as placeholder for future expansion
      return matchesQuery && matchesSector;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('B2B Leads', style: GoogleFonts.manrope(fontWeight: FontWeight.w700, color: Colors.grey[900])),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search company, sector, city...',
                      prefixIcon: const Icon(Ionicons.search_outline),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.blue[800]!, width: 2)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _buildDropdown(_sizeFilter, ['All sizes', 'SME', 'Large', 'Enterprise'], (v) => setState(() => _sizeFilter = v)),
                const SizedBox(width: 12),
                _buildDropdown(_sectorFilter, ['All sectors', 'Power', 'EPC', 'Oil & Gas', 'Infrastructure'], (v) => setState(() => _sectorFilter = v)),
              ],
            ),
            const SizedBox(height: 16),

            // Grid of leads
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  final cols = w < 800 ? 1 : w < 1200 ? 2 : 3;
                  final ratio = w < 800 ? 2.4 : 1.9;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: ratio,
                    ),
                    itemCount: filteredLeads.length,
                    itemBuilder: (context, index) => _leadCard(filteredLeads[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _leadCard(Map<String, String> l) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.domain, size: 18, color: Colors.grey)),
              const SizedBox(width: 10),
              Expanded(child: Text(l['name']!, style: GoogleFonts.manrope(fontWeight: FontWeight.w700))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(999)),
                child: Text(l['tag']!, style: GoogleFonts.manrope(fontSize: 11, color: Colors.grey[700])),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('${l['sector']} · ${l['city']}', style: GoogleFonts.manrope(color: Colors.grey[700])),
          const SizedBox(height: 4),
          Text('Turnover: ${l['turnover']}', style: GoogleFonts.manrope(fontSize: 12, color: Colors.grey[600])),
          const Spacer(),
          Row(
            children: [
              _chip(Icons.call, 'Call', () {}),
              const SizedBox(width: 8),
              _chip(Icons.email_outlined, 'Email', () {}),
              const SizedBox(width: 8),
              _chip(Icons.public, 'Website', () {}),
              const Spacer(),
              ElevatedButton(onPressed: () {}, child: const Text('View')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(IconData icon, String label, VoidCallback onTap) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
    );
  }

  Widget _buildDropdown(String value, List<String> items, ValueChanged<String> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) => onChanged(v ?? value),
      ),
    );
  }
}


