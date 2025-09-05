import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/responsive_helper.dart';
import 'seller_dashboard_screen.dart';

class SellerOnboardingScreen extends StatefulWidget {
  const SellerOnboardingScreen({super.key});

  @override
  State<SellerOnboardingScreen> createState() => _SellerOnboardingScreenState();
}

class _SellerOnboardingScreenState extends State<SellerOnboardingScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentStep = 0;
  
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _gstinController = TextEditingController();
  final _panController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _businessNameController.dispose();
    _contactPersonController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _gstinController.dispose();
    _panController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Become a Seller',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[900],
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue[600],
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Colors.blue[600],
          labelStyle: GoogleFonts.manrope(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Business Info'),
            Tab(text: 'Documents'),
            Tab(text: 'Verification'),
            Tab(text: 'Complete'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBusinessInfo(),
          _buildDocuments(),
          _buildVerification(),
          _buildComplete(),
        ],
      ),
    );
  }

  Widget _buildBusinessInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepHeader(
              'Business Information',
              'Tell us about your business',
              Icons.business,
              Colors.blue,
            ),
            const SizedBox(height: 24),
            
            // Business Details
            _buildSectionCard(
              'Business Details',
              [
                _buildTextField('Business Name', _businessNameController, 'Enter your business name'),
                _buildTextField('Contact Person', _contactPersonController, 'Enter contact person name'),
                _buildTextField('Email', _emailController, 'business@example.com'),
                _buildTextField('Phone', _phoneController, '+91 9876543210'),
                _buildTextField('Address', _addressController, 'Enter business address', maxLines: 3),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Legal Information
            _buildSectionCard(
              'Legal Information',
              [
                _buildTextField('GSTIN', _gstinController, '22AAAAA0000A1Z5'),
                _buildTextField('PAN Number', _panController, 'AAAAA0000A'),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Next Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Next: Upload Documents',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocuments() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(
            'Document Upload',
            'Upload required business documents',
            Icons.upload_file,
            Colors.orange,
          ),
          const SizedBox(height: 24),
          
          // Document Upload Cards
          _buildDocumentCard(
            'Business Registration Certificate',
            'Upload your business registration or incorporation certificate',
            Icons.description,
            'business_cert.pdf',
          ),
          
          _buildDocumentCard(
            'GST Certificate',
            'Upload your GST registration certificate',
            Icons.receipt,
            'gst_cert.pdf',
          ),
          
          _buildDocumentCard(
            'PAN Card',
            'Upload your PAN card copy',
            Icons.credit_card,
            'pan_card.pdf',
          ),
          
          _buildDocumentCard(
            'Bank Account Details',
            'Upload bank statement or cancelled cheque',
            Icons.account_balance,
            'bank_details.pdf',
          ),
          
          const SizedBox(height: 32),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue[600],
                    side: BorderSide(color: Colors.blue[600]!),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Previous',
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
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Next: Verification',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerification() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(
            'Verification Process',
            'We will review your documents and verify your business',
            Icons.verified_user,
            Colors.green,
          ),
          const SizedBox(height: 24),
          
          // Verification Steps
          _buildVerificationStep(
            'Document Review',
            'Our team is reviewing your uploaded documents',
            Icons.description,
            true,
            'Completed',
          ),
          
          _buildVerificationStep(
            'Business Verification',
            'We are verifying your business details',
            Icons.business,
            true,
            'Completed',
          ),
          
          _buildVerificationStep(
            'Bank Account Verification',
            'Verifying your bank account details',
            Icons.account_balance,
            false,
            'In Progress',
          ),
          
          _buildVerificationStep(
            'Final Approval',
            'Awaiting final approval from admin',
            Icons.check_circle,
            false,
            'Pending',
          ),
          
          const SizedBox(height: 32),
          
          // Status Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.orange[600]),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verification in Progress',
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange[700],
                        ),
                      ),
                      Text(
                        'We will notify you once verification is complete. This usually takes 1-2 business days.',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          color: Colors.orange[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue[600],
                    side: BorderSide(color: Colors.blue[600]!),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Previous',
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
                  onPressed: _completeOnboarding,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Complete Setup',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComplete() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.green[600],
                size: 60,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Welcome to Vidyut!',
              style: GoogleFonts.manrope(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your seller account has been created successfully. You can now start listing your products and managing your business.',
              style: GoogleFonts.manrope(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SellerDashboardScreen()),
                  );
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
                  'Go to Seller Dashboard',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepHeader(String title, String subtitle, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
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
            title,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint, {int maxLines = 1}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
          ),
        ),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDocumentCard(String title, String description, IconData icon, String fileName) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue[600], size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[900],
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  fileName,
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: Colors.green[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Upload document
            },
            icon: Icon(Icons.upload, color: Colors.blue[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationStep(String title, String description, IconData icon, bool completed, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: completed ? Colors.green[200]! : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: completed ? Colors.green[100] : Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              completed ? Icons.check : icon,
              color: completed ? Colors.green[600] : Colors.grey[400],
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[900],
                  ),
                ),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: completed ? Colors.green[100] : Colors.orange[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: completed ? Colors.green[700] : Colors.orange[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_tabController.index < _tabController.length - 1) {
      _tabController.animateTo(_tabController.index + 1);
    }
  }

  void _previousStep() {
    if (_tabController.index > 0) {
      _tabController.animateTo(_tabController.index - 1);
    }
  }

  void _completeOnboarding() {
    _tabController.animateTo(_tabController.length - 1);
  }
}
