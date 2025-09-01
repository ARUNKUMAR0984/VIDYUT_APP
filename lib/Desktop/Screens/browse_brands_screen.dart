import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_products_screen.dart';
import 'state_info_screen.dart';

class D_BrowseBrandsScreen extends StatefulWidget {
  const D_BrowseBrandsScreen({super.key});

  @override
  State<D_BrowseBrandsScreen> createState() => _D_BrowseBrandsScreenState();
}

class _D_BrowseBrandsScreenState extends State<D_BrowseBrandsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _sidebarSearchController = TextEditingController();
  final TextEditingController _brandSearchController = TextEditingController();
  String _selectedFilter = 'All Brands';
  String _searchQuery = '';
  bool _isSearchFocused = false;

  @override
  void dispose() {
    _searchController.dispose();
    _sidebarSearchController.dispose();
    _brandSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSearchFocused = false;
        });
      },
      child: Scaffold(
      body: Row(
        children: [
          // Left Sidebar Navigation
          Container(
            width: 280,
            color: Colors.white,
            child: Column(
              children: [
                // Logo Section
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
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
                      const Text(
                        'Vidyut',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Sidebar Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _sidebarSearchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.grid_view),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Navigation Links
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildNavItem(Icons.home, 'Home'),
                        _buildNavItem(Icons.search, 'Search Products'),
                        _buildNavItem(Icons.branding_watermark, 'Browse Brands', isActive: true),
                        _buildNavItem(Icons.shopping_bag, 'My Orders', badge: '3'),
                        _buildNavItem(Icons.store, 'Sell'),
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
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.red[600],
                        child: const Text(
                          'N',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'John Doe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'john@example.com',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Top Header
                Container(
                  padding: const EdgeInsets.all(20),
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
                      // Logo
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
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
                      const Text(
                        'Vidyut',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      
                      const SizedBox(width: 20),
                      
                      // Back Arrow
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      
                      const SizedBox(width: 20),
                      
                      // Main Search Bar
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                '⌘K',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 20),
                      
                      // Location
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            const Text('Deliver to: Set location'),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 20),
                      
                      // Icons
                      IconButton(
                        icon: const Icon(Icons.notifications),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                      
                      const SizedBox(width: 20),
                      
                      // Buttons
                      TextButton(
                        onPressed: () {},
                        child: const Text('Sign In'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Sign Up'),
                      ),
                      
                      const SizedBox(width: 20),
                      
                      // User Avatar
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue[600],
                        child: const Text(
                          'JD',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Main Title Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Trusted Electrical Brands',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Discover products from India\'s most trusted electrical brands. Quality guaranteed, prices competitive.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Brand Search and Filter Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                                         // Brand Search Bar
                             SizedBox(
                               width: 400,
                               child: TextField(
                                 controller: _brandSearchController,
                                 decoration: InputDecoration(
                                   hintText: 'Search brands...',
                                   prefixIcon: const Icon(Icons.search),
                                   suffixIcon: _searchQuery.isNotEmpty
                                     ? IconButton(
                                         icon: const Icon(Icons.clear),
                                         onPressed: () {
                                           setState(() {
                                             _searchQuery = '';
                                             _brandSearchController.clear();
                                           });
                                         },
                                       )
                                     : null,
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(8),
                                     borderSide: BorderSide(color: Colors.grey[300]!),
                                   ),
                                   filled: true,
                                   fillColor: Colors.grey[50],
                                 ),
                                 onChanged: (value) {
                                   setState(() {
                                     _searchQuery = value.toLowerCase();
                                   });
                                 },
                                 onTap: () {
                                   setState(() {
                                     _isSearchFocused = true;
                                   });
                                 },
                               ),
                             ),
                            
                            // Search Suggestions
                            if (_isSearchFocused && _searchQuery.isEmpty) ...[
                              const SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Popular searches:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      _buildSearchSuggestion('Havells'),
                                      _buildSearchSuggestion('Schneider'),
                                      _buildSearchSuggestion('ABB'),
                                      _buildSearchSuggestion('Philips'),
                                      _buildSearchSuggestion('Crompton'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                            
                            const SizedBox(height: 20),
                            
                            // Filter Buttons
                            Row(
                              children: [
                                _buildFilterButton('All Brands', isSelected: _selectedFilter == 'All Brands'),
                                const SizedBox(width: 16),
                                _buildFilterButton('Most Popular', isSelected: _selectedFilter == 'Most Popular'),
                                const SizedBox(width: 16),
                                _buildFilterButton('A-Z', isSelected: _selectedFilter == 'A-Z'),
                              ],
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 50),
                        
                                                 // Featured Brands Section
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               children: [
                                 Text(
                                   _searchQuery.isNotEmpty ? 'Search Results' : 'Featured Brands',
                                   style: const TextStyle(
                                     fontSize: 28,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black87,
                                   ),
                                 ),
                                 const SizedBox(width: 16),
                                 Text(
                                   _searchQuery.isNotEmpty 
                                     ? '${_getFilteredBrands().length} brand${_getFilteredBrands().length != 1 ? 's' : ''} found for "$_searchQuery"'
                                     : '36 brands • 250 total products',
                                   style: TextStyle(
                                     fontSize: 16,
                                     color: Colors.grey[600],
                                   ),
                                 ),
                               ],
                             ),
                             
                             const SizedBox(height: 30),
                             
                             // Show search results or all brands
                             if (_searchQuery.isNotEmpty && _getFilteredBrands().isEmpty) ...[
                               // No results found
                               Center(
                                 child: Column(
                                   children: [
                                     Icon(
                                       Icons.search_off,
                                       size: 64,
                                       color: Colors.grey[400],
                                     ),
                                     const SizedBox(height: 16),
                                     Text(
                                       'No brands found for "$_searchQuery"',
                                       style: TextStyle(
                                         fontSize: 18,
                                         color: Colors.grey[600],
                                       ),
                                     ),
                                     const SizedBox(height: 8),
                                     Text(
                                       'Try searching with a different term',
                                       style: TextStyle(
                                         fontSize: 14,
                                         color: Colors.grey[500],
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ] else ...[
                                                            // Brand Cards Grid
                             GridView.builder(
                               shrinkWrap: true,
                               physics: const NeverScrollableScrollPhysics(),
                               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                 crossAxisCount: 3,
                                 crossAxisSpacing: 24,
                                 mainAxisSpacing: 24,
                                 childAspectRatio: 0.85, // Reduced from 1.2 to give more height
                               ),
                               itemCount: _getFilteredBrands().length,
                               itemBuilder: (context, index) {
                                 return _buildBrandCard(_getFilteredBrands()[index]);
                               },
                             ),
                             ],
                           ],
                         ),
                      ],
                    ),
                  ),
                ),
                
                // Floating Support Button
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.blue[600],
                    child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
  
  Widget _buildNavItem(IconData icon, String title, {bool isActive = false, String? badge}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? Colors.blue[600] : Colors.grey[600],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.blue[600] : Colors.grey[700],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        tileColor: isActive ? Colors.blue[50] : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          if (title == 'Home') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_HomeScreen()),
            );
          } else if (title == 'Search Products') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
            );
          } else if (title == 'State Info') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_StateInfoScreen()),
            );
          }
        },
      ),
    );
  }
  
  Widget _buildSearchSuggestion(String suggestion) {
    return InkWell(
      onTap: () {
        setState(() {
          _searchQuery = suggestion.toLowerCase();
          _brandSearchController.text = suggestion;
          _isSearchFocused = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue[200]!),
        ),
        child: Text(
          suggestion,
          style: TextStyle(
            color: Colors.blue[700],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  
  Widget _buildFilterButton(String label, {bool isSelected = false}) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue[600] : Colors.grey[100],
        foregroundColor: isSelected ? Colors.white : Colors.grey[700],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
  
  List<Map<String, dynamic>> _getFilteredBrands() {
    // Sample brand data
    final List<Map<String, dynamic>> allBrands = [
      {
        'name': 'Havells',
        'initial': 'H',
        'rating': 4.6,
        'description': 'Leading electrical equipment company known for quality switches, fans, and lighting solutions',
        'products': 28,
        'reviews': 1311,
        'categories': ['wires cables', 'switches outlets', 'lighting', '+4 more'],
        'color': Colors.purple,
      },
      {
        'name': 'Schneider',
        'initial': 'S',
        'rating': 4.6,
        'description': 'Multinational corporation specializing in energy management and automation solutions',
        'products': 18,
        'reviews': 723,
        'categories': ['circuit breakers', 'motors', 'panels', '+2 more'],
        'color': Colors.purple,
      },
      {
        'name': 'ABB',
        'initial': 'A',
        'rating': 4.6,
        'description': 'Quality electrical products and solutions from ABB',
        'products': 17,
        'reviews': 556,
        'categories': ['circuit breakers', 'motors', 'panels', '+3 more'],
        'color': Colors.purple,
      },
      {
        'name': 'Crompton',
        'initial': 'C',
        'rating': 4.5,
        'description': 'Trusted brand for fans, lights, and electrical appliances',
        'products': 25,
        'reviews': 892,
        'categories': ['Fans', 'Lights', 'Appliances', '+2 more'],
        'color': Colors.purple,
      },
      {
        'name': 'Philips',
        'initial': 'P',
        'rating': 4.7,
        'description': 'Global leader in lighting and healthcare technology',
        'products': 22,
        'reviews': 1156,
        'categories': ['LED Lights', 'Smart Lighting', 'Healthcare', '+1 more'],
        'color': Colors.purple,
      },
      {
        'name': 'Legrand',
        'initial': 'L',
        'rating': 4.4,
        'description': 'French multinational specializing in electrical and digital building infrastructures',
        'products': 15,
        'reviews': 445,
        'categories': ['Switches', 'Sockets', 'Cables', '+1 more'],
        'color': Colors.purple,
      },
      {
        'name': 'Siemens',
        'initial': 'S',
        'rating': 4.8,
        'description': 'German multinational conglomerate in industry, energy, and healthcare',
        'products': 20,
        'reviews': 678,
        'categories': ['Automation', 'Energy', 'Healthcare', '+2 more'],
        'color': Colors.purple,
      },
      {
        'name': 'Anchor',
        'initial': 'A',
        'rating': 4.3,
        'description': 'Popular Indian brand for electrical accessories and switches',
        'products': 30,
        'reviews': 1234,
        'categories': ['Switches', 'Sockets', 'Wires', '+3 more'],
        'color': Colors.purple,
      },
      {
        'name': 'Finolex',
        'initial': 'F',
        'rating': 4.2,
        'description': 'Leading manufacturer of electrical cables and wires',
        'products': 35,
        'reviews': 567,
        'categories': ['Cables', 'Wires', 'Conduits', '+2 more'],
        'color': Colors.purple,
             },
     ];
     
     // Filter brands based on search query
     if (_searchQuery.isEmpty) {
       return allBrands;
     }
     
     return allBrands.where((brand) {
       return brand['name'].toLowerCase().contains(_searchQuery) ||
              brand['description'].toLowerCase().contains(_searchQuery) ||
              (brand['categories'] as List<String>).any((category) => 
                category.toLowerCase().contains(_searchQuery));
     }).toList();
  }
  
  Widget _buildBrandCard(Map<String, dynamic> brand) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
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
          // Brand Header
          Row(
            children: [
              // Brand Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: brand['color'],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    brand['initial'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Brand Name and Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brand['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${brand['rating']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Popular',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Brand Description
          Text(
            brand['description'],
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 12),
          
                     // Statistics
           Row(
             children: [
               // Products Count
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     '${brand['products']}',
                     style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                       color: Colors.blue[700],
                     ),
                   ),
                   Text(
                     'Products',
                     style: TextStyle(
                       fontSize: 12,
                       color: Colors.grey[600],
                     ),
                   ),
                 ],
               ),
               const SizedBox(width: 24),
               // Reviews Count
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     '${brand['reviews']}',
                     style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                       color: Colors.green[700],
                     ),
                   ),
                   Text(
                     'Reviews',
                     style: TextStyle(
                       fontSize: 12,
                       color: Colors.grey[600],
                     ),
                   ),
                 ],
               ),
             ],
           ),
          
          const SizedBox(height: 8),
          
          // Categories
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: (brand['categories'] as List<String>).map((category) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              // View Products Button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to brand products page
                  },
                  icon: const Icon(Icons.inventory_2, size: 16),
                  label: const Text('View Products'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Arrow Button
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: IconButton(
                  onPressed: () {
                    // Navigate to brand details page
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.grey[600],
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
