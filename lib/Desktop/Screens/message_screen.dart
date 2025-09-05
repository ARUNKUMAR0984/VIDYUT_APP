import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/responsive_helper.dart';
import '../Components/unified_navigation.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // Unified Navigation
          UnifiedNavigation(
            currentPage: 'message',
            isMobile: ResponsiveHelper.isMobile(context),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 20, desktop: 24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Messages',
                    style: GoogleFonts.manrope(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 24, tablet: 28, desktop: 32),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Stay connected with buyers and sellers',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Messages List
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFF1F5F9),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1E293B).withOpacity(0.04),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 8,
                      separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
                      itemBuilder: (context, index) {
                        final messages = [
                          {'name': 'Rajesh Kumar', 'lastMessage': 'Interested in LED bulbs', 'time': '2 min ago', 'unread': true},
                          {'name': 'Priya Sharma', 'lastMessage': 'Quote request for MCB', 'time': '15 min ago', 'unread': true},
                          {'name': 'Amit Patel', 'lastMessage': 'Delivery status update', 'time': '1 hour ago', 'unread': false},
                          {'name': 'Sneha Singh', 'lastMessage': 'Product inquiry', 'time': '2 hours ago', 'unread': false},
                          {'name': 'Vikram Mehta', 'lastMessage': 'Bulk order discussion', 'time': '3 hours ago', 'unread': false},
                          {'name': 'Anjali Desai', 'lastMessage': 'Payment confirmation', 'time': '1 day ago', 'unread': false},
                          {'name': 'Rahul Verma', 'lastMessage': 'Technical specifications', 'time': '2 days ago', 'unread': false},
                          {'name': 'Meera Kapoor', 'lastMessage': 'Warranty information', 'time': '3 days ago', 'unread': false},
                        ];
                        
                        final message = messages[index];
                        
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: const Color(0xFF3B82F6).withOpacity(0.1),
                            child: Text(
                              (message['name'] as String).substring(0, 1),
                              style: GoogleFonts.manrope(
                                color: const Color(0xFF3B82F6),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  message['name'] as String,
                                  style: GoogleFonts.manrope(
                                    fontWeight: message['unread'] as bool ? FontWeight.w600 : FontWeight.w500,
                                    color: const Color(0xFF1E293B),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              if (message['unread'] as bool)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3B82F6),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                message['lastMessage'] as String,
                                style: GoogleFonts.manrope(
                                  color: const Color(0xFF64748B),
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                message['time'] as String,
                                style: GoogleFonts.manrope(
                                  color: const Color(0xFF94A3B8),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            // Handle message tap
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Opening chat with ${message['name']}'),
                                backgroundColor: const Color(0xFF3B82F6),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

