import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class ReviewsScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  
  const ReviewsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  String _selectedSortBy = 'Most Recent';
  String _selectedRatingFilter = 'All Ratings';
  bool _showOnlyVerified = false;
  
  // Sample reviews data
  final List<Map<String, dynamic>> _reviews = [
    {
      'id': '1',
      'userName': 'Rajesh Kumar',
      'userAvatar': 'RK',
      'rating': 5,
      'title': 'Excellent Quality!',
      'comment': 'This LED bulb is amazing. Very bright and energy efficient. Perfect for my home office. Highly recommended!',
      'date': '2024-01-15',
      'verified': true,
      'helpful': 12,
      'images': [],
    },
    {
      'id': '2',
      'userName': 'Priya Sharma',
      'userAvatar': 'PS',
      'rating': 4,
      'title': 'Good product, fast delivery',
      'comment': 'The bulb works well and the delivery was super fast. Only minor issue is the packaging could be better.',
      'date': '2024-01-14',
      'verified': true,
      'helpful': 8,
      'images': [],
    },
    {
      'id': '3',
      'userName': 'Amit Patel',
      'userAvatar': 'AP',
      'rating': 5,
      'title': 'Perfect for my needs',
      'comment': 'Exactly what I was looking for. Great brightness and the warranty gives me peace of mind.',
      'date': '2024-01-13',
      'verified': false,
      'helpful': 5,
      'images': [],
    },
    {
      'id': '4',
      'userName': 'Sneha Reddy',
      'userAvatar': 'SR',
      'rating': 3,
      'title': 'Average product',
      'comment': 'It works fine but nothing extraordinary. The price is reasonable for what you get.',
      'date': '2024-01-12',
      'verified': true,
      'helpful': 3,
      'images': [],
    },
    {
      'id': '5',
      'userName': 'Vikram Singh',
      'userAvatar': 'VS',
      'rating': 5,
      'title': 'Outstanding value!',
      'comment': 'This is the best LED bulb I have ever used. The light quality is perfect and it has been working flawlessly for months.',
      'date': '2024-01-11',
      'verified': true,
      'helpful': 15,
      'images': [],
    },
    {
      'id': '6',
      'userName': 'Anita Desai',
      'userAvatar': 'AD',
      'rating': 2,
      'title': 'Not as expected',
      'comment': 'The bulb stopped working after just 2 weeks. Customer service was helpful but still disappointed.',
      'date': '2024-01-10',
      'verified': true,
      'helpful': 2,
      'images': [],
    },
  ];

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
                            style: GoogleFonts.manrope(
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
                        style: GoogleFonts.manrope(
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
                        _buildNavItem(Ionicons.home_outline, 'Home'),
                        _buildNavItem(Ionicons.search_outline, 'Search Products'),
                        _buildNavItem(Ionicons.bag_outline, 'My Orders'),
                        _buildNavItem(Ionicons.heart_outline, 'Wishlist'),
                        _buildNavItem(Ionicons.cart_outline, 'Shopping Cart'),
                        _buildNavItem(Ionicons.storefront_outline, 'Sell'),
                        _buildNavItem(Ionicons.chatbubbles_outline, 'Messages'),
                        _buildNavItem(Ionicons.location_outline, 'State Info'),
                        _buildNavItem(Icons.trending_up, 'Trending'),
                        
                        const SizedBox(height: 30),
                        
                        // Account Section
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
                          style: GoogleFonts.manrope(
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
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[900],
                              ),
                            ),
                            Text(
                              'john.doe@email.com',
                              style: GoogleFonts.manrope(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Customer Reviews',
                              style: GoogleFonts.manrope(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),
                            Text(
                              widget.product['name'],
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _showWriteReviewDialog,
                        icon: const Icon(Icons.edit),
                        label: Text(
                          'Write Review',
                          style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Review Summary
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: _buildReviewSummary(),
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
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: _selectedSortBy,
                        underline: Container(),
                        style: GoogleFonts.manrope(color: Colors.grey[700]),
                        items: [
                          'Most Recent',
                          'Most Helpful',
                          'Highest Rating',
                          'Lowest Rating',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: GoogleFonts.manrope()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedSortBy = newValue;
                            });
                          }
                        },
                      ),
                      
                      const SizedBox(width: 24),
                      
                      // Rating filter
                      Text(
                        'Rating:',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: _selectedRatingFilter,
                        underline: Container(),
                        style: GoogleFonts.manrope(color: Colors.grey[700]),
                        items: [
                          'All Ratings',
                          '5 Stars',
                          '4 Stars',
                          '3 Stars',
                          '2 Stars',
                          '1 Star',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: GoogleFonts.manrope()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedRatingFilter = newValue;
                            });
                          }
                        },
                      ),
                      
                      const Spacer(),
                      
                      // Verified only toggle
                      Row(
                        children: [
                          Checkbox(
                            value: _showOnlyVerified,
                            onChanged: (value) {
                              setState(() {
                                _showOnlyVerified = value ?? false;
                              });
                            },
                            activeColor: Colors.blue[800],
                          ),
                          Text(
                            'Verified purchases only',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Reviews List
                Expanded(
                  child: _buildReviewsList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, {bool isActive = false}) {
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
          style: GoogleFonts.manrope(
            color: isActive ? Colors.blue[800] : Colors.grey[700],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        onTap: () {
          if (title == 'Home') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_HomeScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildReviewSummary() {
    double averageRating = _reviews.fold(0.0, (sum, review) => sum + review['rating']) / _reviews.length;
    int totalReviews = _reviews.length;
    
    // Calculate rating distribution
    Map<int, int> ratingDistribution = {};
    for (int i = 1; i <= 5; i++) {
      ratingDistribution[i] = _reviews.where((review) => review['rating'] == i).length;
    }

    return Row(
      children: [
        // Overall Rating
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: GoogleFonts.manrope(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStarRating(averageRating, size: 24),
                      Text(
                        'Based on $totalReviews reviews',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Rating Distribution
        Expanded(
          flex: 3,
          child: Column(
            children: [
              for (int i = 5; i >= 1; i--) ...[
                _buildRatingBar(i, ratingDistribution[i] ?? 0, totalReviews),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(int rating, int count, int total) {
    double percentage = total > 0 ? count / total : 0;
    
    return Row(
      children: [
        Text(
          '$rating',
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$count',
          style: GoogleFonts.manrope(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStarRating(double rating, {double size = 16}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: Colors.amber, size: size);
        } else if (index < rating) {
          return Icon(Icons.star_half, color: Colors.amber, size: size);
        } else {
          return Icon(Icons.star_border, color: Colors.amber, size: size);
        }
      }),
    );
  }

  Widget _buildReviewsList() {
    List<Map<String, dynamic>> filteredReviews = _reviews.where((review) {
      bool matchesRating = _selectedRatingFilter == 'All Ratings' ||
          review['rating'].toString() == _selectedRatingFilter.split(' ')[0];
      bool matchesVerified = !_showOnlyVerified || review['verified'];
      return matchesRating && matchesVerified;
    }).toList();

    // Apply sorting
    switch (_selectedSortBy) {
      case 'Most Helpful':
        filteredReviews.sort((a, b) => b['helpful'].compareTo(a['helpful']));
        break;
      case 'Highest Rating':
        filteredReviews.sort((a, b) => b['rating'].compareTo(a['rating']));
        break;
      case 'Lowest Rating':
        filteredReviews.sort((a, b) => a['rating'].compareTo(b['rating']));
        break;
      default: // Most Recent
        filteredReviews.sort((a, b) => b['date'].compareTo(a['date']));
        break;
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: filteredReviews.length,
      itemBuilder: (context, index) {
        return _buildReviewCard(filteredReviews[index]);
      },
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Review Header
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue[800],
                child: Text(
                  review['userAvatar'],
                  style: GoogleFonts.manrope(
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
                    Row(
                      children: [
                        Text(
                          review['userName'],
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[900],
                          ),
                        ),
                        if (review['verified']) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Verified Purchase',
                              style: GoogleFonts.manrope(
                                fontSize: 10,
                                color: Colors.green[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      _formatDate(review['date']),
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              _buildStarRating(review['rating'].toDouble()),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Review Title
          Text(
            review['title'],
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[900],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Review Comment
          Text(
            review['comment'],
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Review Actions
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => _markAsHelpful(review['id']),
                icon: const Icon(Icons.thumb_up_outlined, size: 16),
                label: Text(
                  'Helpful (${review['helpful']})',
                  style: GoogleFonts.manrope(fontSize: 12),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => _reportReview(review['id']),
                icon: const Icon(Icons.flag_outlined, size: 16),
                label: Text(
                  'Report',
                  style: GoogleFonts.manrope(fontSize: 12),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  void _markAsHelpful(String reviewId) {
    setState(() {
      final reviewIndex = _reviews.indexWhere((review) => review['id'] == reviewId);
      if (reviewIndex != -1) {
        _reviews[reviewIndex]['helpful']++;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Thank you for your feedback!', style: GoogleFonts.manrope()),
        backgroundColor: Colors.green[600],
      ),
    );
  }

  void _reportReview(String reviewId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Report Review',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to report this review? Our team will review it and take appropriate action.',
            style: GoogleFonts.manrope(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.manrope(color: Colors.grey[600]),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Review reported successfully', style: GoogleFonts.manrope()),
                    backgroundColor: Colors.blue[800],
                  ),
                );
              },
              child: Text(
                'Report',
                style: GoogleFonts.manrope(color: Colors.red[600]),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showWriteReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WriteReviewDialog(product: widget.product);
      },
    );
  }
}

class WriteReviewDialog extends StatefulWidget {
  final Map<String, dynamic> product;
  
  const WriteReviewDialog({
    super.key,
    required this.product,
  });

  @override
  State<WriteReviewDialog> createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends State<WriteReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _commentController = TextEditingController();
  int _rating = 0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Text(
                    'Write a Review',
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Product Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.image,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product['name'],
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[900],
                            ),
                          ),
                          Text(
                            widget.product['description'],
                            style: GoogleFonts.manrope(
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
              
              const SizedBox(height: 24),
              
              // Rating
              Text(
                'Your Rating',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    child: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                  );
                }),
              ),
              
              const SizedBox(height: 24),
              
              // Review Title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Review Title',
                  labelStyle: GoogleFonts.manrope(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a review title';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Review Comment
              TextFormField(
                controller: _commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Your Review',
                  labelStyle: GoogleFonts.manrope(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please write your review';
                  }
                  if (value.length < 10) {
                    return 'Review must be at least 10 characters long';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              
              // Submit Button
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitReview,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Submit Review',
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitReview() {
    if (_formKey.currentState!.validate() && _rating > 0) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate review submission
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isSubmitting = false;
        });
        
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Thank you for your review!', style: GoogleFonts.manrope()),
            backgroundColor: Colors.green[600],
          ),
        );
      });
    } else if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a rating', style: GoogleFonts.manrope()),
          backgroundColor: Colors.red[600],
        ),
      );
    }
  }
}












