import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'search_products_screen.dart';
import 'product_details_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Sample wishlist data - in real app this would come from a wishlist service
  List<Map<String, dynamic>> wishlistItems = [
    {
      'id': '1',
      'name': 'Philips LED Bulb 9W',
      'category': 'light',
      'price': '₹299',
      'originalPrice': '₹399',
      'image': 'assets/images/lights/philips_bulb_single_white_bg.jpeg',
      'description': 'Energy efficient LED bulb with 2 year warranty',
      'seller': 'Philips India',
      'rating': 4.5,
      'inStock': true,
      'addedDate': '2024-01-15',
    },
    {
      'id': '2',
      'name': 'Copper Wire 2.5mm',
      'category': 'wire',
      'price': '₹120/meter',
      'originalPrice': '₹150/meter',
      'image': 'assets/images/wires-and-cables/wires1.jpeg',
      'description': 'High grade copper wire for house wiring',
      'seller': 'Polycab Wires',
      'rating': 4.6,
      'inStock': true,
      'addedDate': '2024-01-14',
    },
    {
      'id': '3',
      'name': 'MCB 32A',
      'category': 'circuit',
      'price': '₹450',
      'originalPrice': '₹600',
      'image': 'assets/images/circuit-breakers/mcb.jpeg',
      'description': 'Miniature Circuit Breaker for electrical protection',
      'seller': 'CircuitPro',
      'rating': 4.3,
      'inStock': false,
      'addedDate': '2024-01-13',
    },
    {
      'id': '4',
      'name': 'LED Panel Light 18W',
      'category': 'light',
      'price': '₹1,299',
      'originalPrice': '₹1,599',
      'image': 'assets/images/lights/led_panel_light.jpeg',
      'description': 'Modern LED panel light for office and home',
      'seller': 'Havells',
      'rating': 4.7,
      'inStock': true,
      'addedDate': '2024-01-12',
    },
    {
      'id': '5',
      'name': 'Switch Socket 6A',
      'category': 'switch',
      'price': '₹89',
      'originalPrice': '₹120',
      'image': 'assets/images/switches/switch_socket.jpeg',
      'description': 'High quality switch socket with safety features',
      'seller': 'Anchor Electricals',
      'rating': 4.4,
      'inStock': true,
      'addedDate': '2024-01-11',
    },
  ];

  String _selectedSortBy = 'Recently Added';
  bool _showOutOfStock = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Row(
        children: [
          // Left Sidebar
          Container(
            width: 280,
            color: Colors.white,
            child: Column(
              children: [
                // Logo
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'V',
                            style: GoogleFonts.inter(
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
                          color: Colors.blue[800],
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
                        _buildNavItem(Icons.home, 'Home'),
                        _buildNavItem(Icons.search, 'Search Products'),
                        _buildNavItem(Icons.shopping_bag, 'My Orders'),
                        _buildNavItem(Icons.favorite, 'Wishlist', isActive: true),
                        _buildNavItem(Icons.shopping_cart, 'Shopping Cart', badge: '3'),
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
                        backgroundColor: Colors.blue[800],
                        child: Text(
                          'JD',
                          style: GoogleFonts.inter(
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
                            Text(
                              'John Doe',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[900],
                              ),
                            ),
                            Text(
                              'john.doe@email.com',
                              style: GoogleFonts.inter(
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
              ],
            ),
          ),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Header
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
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'My Wishlist',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${wishlistItems.length} items',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Filter and Sort Controls
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Sort dropdown
                      Text(
                        'Sort by:',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: _selectedSortBy,
                        underline: Container(),
                        style: GoogleFonts.inter(color: Colors.grey[700]),
                        items: [
                          'Recently Added',
                          'Price: Low to High',
                          'Price: High to Low',
                          'Rating: High to Low',
                          'Name: A to Z',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: GoogleFonts.inter()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedSortBy = newValue;
                            });
                            _applySorting();
                          }
                        },
                      ),
                      
                      const Spacer(),
                      
                      // Show out of stock toggle
                      Row(
                        children: [
                          Checkbox(
                            value: _showOutOfStock,
                            onChanged: (value) {
                              setState(() {
                                _showOutOfStock = value ?? true;
                              });
                            },
                            activeColor: Colors.blue[800],
                          ),
                          Text(
                            'Show out of stock',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Clear all button
                      OutlinedButton(
                        onPressed: _clearAllWishlist,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red[400]!),
                        ),
                        child: Text(
                          'Clear All',
                          style: GoogleFonts.inter(
                            color: Colors.red[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Content
                Expanded(
                  child: wishlistItems.isEmpty
                      ? _buildEmptyWishlist()
                      : _buildWishlistContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, {bool isActive = false, String? badge}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? Colors.blue[800] : Colors.grey[600],
          size: 20,
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: isActive ? Colors.blue[800] : Colors.grey[700],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
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
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        onTap: () {
          if (title == 'Home') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_HomeScreen()),
            );
          } else if (title == 'Search Products') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 120,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          Text(
            'Your wishlist is empty',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Save items you love for later',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
              );
            },
            icon: const Icon(Icons.search),
            label: Text(
              'Start Shopping',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistContent() {
    List<Map<String, dynamic>> filteredItems = wishlistItems.where((item) {
      return _showOutOfStock || item['inStock'] == true;
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wishlist Stats
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                _buildStatItem(
                  Icons.favorite,
                  'Total Items',
                  '${wishlistItems.length}',
                  Colors.red[400]!,
                ),
                const SizedBox(width: 32),
                _buildStatItem(
                  Icons.inventory,
                  'In Stock',
                  '${wishlistItems.where((item) => item['inStock'] == true).length}',
                  Colors.green[400]!,
                ),
                const SizedBox(width: 32),
                _buildStatItem(
                  Icons.shopping_cart,
                  'In Cart',
                  '0',
                  Colors.blue[400]!,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Wishlist Items Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.75,
            ),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return _buildWishlistItem(filteredItems[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWishlistItem(Map<String, dynamic> item) {
    return Container(
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
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image with Remove Button
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    color: Colors.grey[100],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      item['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(
                            _getProductIcon(item['category']),
                            size: 60,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // Remove from wishlist button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red[400],
                        size: 20,
                      ),
                      onPressed: () => _removeFromWishlist(item['id']),
                    ),
                  ),
                ),
                
                // Out of stock overlay
                if (!item['inStock'])
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red[600],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Out of Stock',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Product Info
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    item['name'],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[900],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Description
                  Text(
                    item['description'],
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const Spacer(),
                  
                  // Price and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['price'],
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[600],
                            ),
                          ),
                          if (item['originalPrice'] != null)
                            Text(
                              item['originalPrice'],
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: Colors.grey[500],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${item['rating']}',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Seller
                  Text(
                    'Sold by: ${item['seller']}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: item['inStock'] ? () => _addToCart(item) : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800],
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  product: item,
                                  allProducts: [],
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          child: Text(
                            'View',
                            style: GoogleFonts.inter(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getProductIcon(String category) {
    switch (category.toLowerCase()) {
      case 'light':
        return Icons.lightbulb;
      case 'wire':
        return Icons.cable;
      case 'motor':
        return Icons.settings;
      case 'switch':
        return Icons.toggle_on;
      case 'circuit':
        return Icons.electrical_services;
      case 'panel':
        return Icons.dashboard;
      case 'tool':
        return Icons.build;
      case 'safety':
        return Icons.security;
      case 'transformer':
        return Icons.transform;
      case 'conduit':
        return Icons.timeline;
      default:
        return Icons.category;
    }
  }

  void _applySorting() {
    setState(() {
      switch (_selectedSortBy) {
        case 'Price: Low to High':
          wishlistItems.sort((a, b) {
            double priceA = double.tryParse(a['price'].toString().replaceAll('₹', '').replaceAll(',', '').replaceAll('/meter', '')) ?? 0;
            double priceB = double.tryParse(b['price'].toString().replaceAll('₹', '').replaceAll(',', '').replaceAll('/meter', '')) ?? 0;
            return priceA.compareTo(priceB);
          });
          break;
        case 'Price: High to Low':
          wishlistItems.sort((a, b) {
            double priceA = double.tryParse(a['price'].toString().replaceAll('₹', '').replaceAll(',', '').replaceAll('/meter', '')) ?? 0;
            double priceB = double.tryParse(b['price'].toString().replaceAll('₹', '').replaceAll(',', '').replaceAll('/meter', '')) ?? 0;
            return priceB.compareTo(priceA);
          });
          break;
        case 'Rating: High to Low':
          wishlistItems.sort((a, b) => b['rating'].compareTo(a['rating']));
          break;
        case 'Name: A to Z':
          wishlistItems.sort((a, b) => a['name'].compareTo(b['name']));
          break;
        default: // Recently Added
          // Keep original order
          break;
      }
    });
  }

  void _removeFromWishlist(String itemId) {
    setState(() {
      wishlistItems.removeWhere((item) => item['id'] == itemId);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item removed from wishlist', style: GoogleFonts.inter()),
        backgroundColor: Colors.red[600],
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            // TODO: Implement undo functionality
          },
        ),
      ),
    );
  }

  void _addToCart(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['name']} added to cart', style: GoogleFonts.inter()),
        backgroundColor: Colors.green[600],
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            // TODO: Navigate to cart screen
          },
        ),
      ),
    );
  }

  void _clearAllWishlist() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Clear Wishlist',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to remove all items from your wishlist?',
            style: GoogleFonts.inter(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(color: Colors.grey[600]),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  wishlistItems.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Wishlist cleared', style: GoogleFonts.inter()),
                    backgroundColor: Colors.blue[800],
                  ),
                );
              },
              child: Text(
                'Clear All',
                style: GoogleFonts.inter(color: Colors.red[600]),
              ),
            ),
          ],
        );
      },
    );
  }
}
