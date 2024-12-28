import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // User info fields
  String name = '';
  String dob = '';
  String email = '';
  String mobile = '';
  String gender = '';
  String address = '';
  String occupation = '';
  String emergencyContact = '';
  String nationality = '';
  String maritalStatus = '';
  String bloodGroup = '';
  String height = '';
  String weight = '';
  String insuranceProvider = '';
  String medicalHistory = '';
  String smoker = '';
  String allergies = '';
  String preferredLanguage = '';
  String ssn = '';
  String healthId = '';

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  // Function to fetch user profile data from Firestore
  Future<void> _fetchUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        name = userData['name'];
        dob = userData['dob'];
        email = userData['email'];
        mobile = userData['mobile'];
        gender = userData['gender'];
        address = userData['address'];
        occupation = userData['occupation'];
        emergencyContact = userData['emergency_contact'];
        nationality = userData['nationality'];
        maritalStatus = userData['marital_status'];
        bloodGroup = userData['blood_group'];
        height = userData['height'];
        weight = userData['weight'];
        insuranceProvider = userData['insurance_provider'];
        medicalHistory = userData['medical_history'];
        smoker = userData['smoker'];
        allergies = userData['allergies'];
        preferredLanguage = userData['preferred_language'];
        ssn = userData['ssn'];
        healthId = userData['health_id'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background with gradient and custom pattern
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 240, 240, 240),
                  Color.fromARGB(255, 255, 255, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CustomPaint(
              painter: BackgroundPatternPainter(),
            ),
          ),
          // Main content
          Column(
            children: [
              // Top section with back button and heading text
              Padding(
                padding: const EdgeInsets.only(
                    top: 40.0, bottom: 20.0, left: 16.0, right: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 16.0),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Profile icon (replacing the heading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: [
                      _buildProfileField('Name', name),
                      _buildProfileField('Date of Birth', dob),
                      _buildProfileField('Email', email),
                      _buildProfileField('Mobile', mobile),
                      _buildProfileField('Gender', gender),
                      _buildProfileField('Address', address),
                      _buildProfileField('Occupation', occupation),
                      _buildProfileField('Emergency Contact', emergencyContact),
                      _buildProfileField('Nationality', nationality),
                      _buildProfileField('Marital Status', maritalStatus),
                      _buildProfileField('Blood Group', bloodGroup),
                      _buildProfileField('Height (cm)', height),
                      _buildProfileField('Weight (kg)', weight),
                      _buildProfileField(
                          'Insurance Provider', insuranceProvider),
                      _buildProfileField('Medical History', medicalHistory),
                      _buildProfileField('Smoker (Yes/No)', smoker),
                      _buildProfileField('Allergies', allergies),
                      _buildProfileField(
                          'Preferred Language', preferredLanguage),
                      _buildProfileField('SSN', ssn),
                      _buildProfileField('Health ID', healthId),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for displaying each profile field
  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align content at the top
        children: [
          Expanded(
            flex: 2, // Allocate more space to the label
            child: Text(
              '$label: ',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3, // Allocate more space to the value
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for background pattern
class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    paint.color = const Color.fromARGB(255, 157, 218, 219)
        .withOpacity(0.2); // Soft purple
    canvas.drawCircle(
        Offset(size.width * 0.25, size.height * 0.35), 150, paint);

    paint.color =
        const Color.fromARGB(255, 253, 230, 83).withOpacity(0.2); // Soft orange
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.7), 200, paint);

    paint.color =
        const Color.fromARGB(255, 136, 215, 116).withOpacity(0.3); // Soft green
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(size.width * 0.5, size.height * 0.5),
            width: 320,
            height: 150),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
