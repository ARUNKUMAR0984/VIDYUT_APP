import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'search_products_screen.dart';
import 'browse_brands_screen.dart';
import 'state_info_screen.dart';
import 'login_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'John Doe');
  final _emailController = TextEditingController(text: 'john.doe@example.com');
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _addressController = TextEditingController(text: '123 Main Street, Mumbai, Maharashtra');
  String _selectedUserType = 'Customer';
  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
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
          style: GoogleFonts.manrope(
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
                  style: GoogleFonts.manrope(
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
          } else if (title == 'Browse Brands') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const D_BrowseBrandsScreen()),
            );
          } else if (title == 'State Info') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const D_StateInfoScreen()),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
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
                
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Ionicons.search_outline),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
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
                        _buildNavItem(Ionicons.home_outline, 'Home'),
                        _buildNavItem(Ionicons.search_outline, 'Search Products'),
                        _buildNavItem(Icons.branding_watermark, 'Browse Brands'),
                        _buildNavItem(Ionicons.bag_outline, 'My Orders', badge: '3'),
                        _buildNavItem(Ionicons.storefront_outline, 'Sell'),
                        _buildNavItem(Ionicons.chatbubbles_outline, 'Messages'),
                        _buildNavItem(Ionicons.location_outline, 'State Info'),
                        _buildNavItem(Icons.trending_up, 'Trending'),
                        
                        const SizedBox(height: 30),
                        
                        // Account Section
                        _buildNavItem(Ionicons.person_outline, 'Profile', isActive: true),
                        _buildNavItem(Ionicons.settings_outline, 'Settings'),
                        _buildNavItem(Icons.help, 'Help'),
                      ],
                    ),
                  ),
                ),
                
                // User Profile
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue[600],
                        child: const Text(
                          'J',
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
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'john.doe@example.com',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Ionicons.log_out_outline, size: 20),
                        onPressed: _logout,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Main Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'My Profile',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: _isEditing ? _saveProfile : _toggleEditing,
                        icon: Icon(_isEditing ? Icons.save : Icons.edit),
                        label: Text(_isEditing ? 'Save' : 'Edit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Profile Content
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column - Profile Picture and Basic Info
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            // Profile Picture
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.blue[600],
                                    child: const Text(
                                      'J',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  if (_isEditing)
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        // TODO: Implement image picker
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Image picker functionality')),
                                        );
                                      },
                                      icon: const Icon(Icons.camera_alt, size: 16),
                                      label: const Text('Change Photo'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[200],
                                        foregroundColor: Colors.black87,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            
                            // Account Stats
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Account Statistics',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildStatItem(Ionicons.bag_outline, 'Orders', '12'),
                                  const SizedBox(height: 12),
                                  _buildStatItem(Ionicons.heart_outline, 'Wishlist', '8'),
                                  const SizedBox(height: 12),
                                  _buildStatItem(Icons.star, 'Reviews', '5'),
                                  const SizedBox(height: 12),
                                  _buildStatItem(Icons.local_shipping, 'Deliveries', '10'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 32),
                      
                      // Right Column - Profile Form
                      Expanded(
                        flex: 2,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Personal Information
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Personal Information',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    
                                    // User Type
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey[300]!),
                                        borderRadius: BorderRadius.circular(8),
                                        color: _isEditing ? Colors.white : Colors.grey[100],
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        value: _selectedUserType,
                                        decoration: const InputDecoration(
                                          labelText: 'Account Type',
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.person_outline),
                                        ),
                                        items: const [
                                          DropdownMenuItem(value: 'Customer', child: Text('Customer')),
                                          DropdownMenuItem(value: 'Seller', child: Text('Seller')),
                                          DropdownMenuItem(value: 'Both', child: Text('Both')),
                                        ],
                                        onChanged: _isEditing ? (value) {
                                          setState(() {
                                            _selectedUserType = value!;
                                          });
                                        } : null,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    
                                    // Name
                                    TextFormField(
                                      controller: _nameController,
                                      enabled: _isEditing,
                                      decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        prefixIcon: const Icon(Icons.person_outlined),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: !_isEditing,
                                        fillColor: Colors.grey[100],
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    
                                    // Email
                                    TextFormField(
                                      controller: _emailController,
                                      enabled: _isEditing,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'Email Address',
                                        prefixIcon: const Icon(Icons.email_outlined),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: !_isEditing,
                                        fillColor: Colors.grey[100],
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    
                                    // Phone
                                    TextFormField(
                                      controller: _phoneController,
                                      enabled: _isEditing,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        labelText: 'Phone Number',
                                        prefixIcon: const Icon(Icons.phone_outlined),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: !_isEditing,
                                        fillColor: Colors.grey[100],
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your phone number';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    
                                    // Address
                                    TextFormField(
                                      controller: _addressController,
                                      enabled: _isEditing,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        labelText: 'Address',
                                        prefixIcon: const Icon(Ionicons.location_outline),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: !_isEditing,
                                        fillColor: Colors.grey[100],
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your address';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              // Security Settings
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Security Settings',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    
                                    _buildSecurityOption(
                                      Icons.lock_outline,
                                      'Change Password',
                                      'Update your account password',
                                      () {
                                        // TODO: Implement change password
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Change password functionality')),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    _buildSecurityOption(
                                      Icons.security,
                                      'Two-Factor Authentication',
                                      'Add an extra layer of security',
                                      () {
                                        // TODO: Implement 2FA
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Two-factor authentication functionality')),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    _buildSecurityOption(
                                      Icons.notifications_outlined,
                                      'Notification Preferences',
                                      'Manage your notification settings',
                                      () {
                                        // TODO: Implement notification settings
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Notification settings functionality')),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
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

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue[600], size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityOption(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue[600], size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }
}

