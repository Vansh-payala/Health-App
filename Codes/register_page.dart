import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  // Controllers for text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _insuranceProviderController =
      TextEditingController();
  final TextEditingController _medicalHistoryController =
      TextEditingController();
  final TextEditingController _smokerController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _preferredLanguageController =
      TextEditingController();
  final TextEditingController _ssnController = TextEditingController();
  final TextEditingController _healthIdController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Registration function
  void _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': _usernameController.text,
        'name': _nameController.text,
        'dob': _dobController.text,
        'mobile': _mobileController.text,
        'email': _emailController.text,
        'gender': _genderController.text,
        'address': _addressController.text,
        'occupation': _occupationController.text,
        'emergency_contact': _emergencyContactController.text,
        'nationality': _nationalityController.text,
        'marital_status': _maritalStatusController.text,
        'blood_group': _bloodGroupController.text,
        'height': _heightController.text,
        'weight': _weightController.text,
        'insurance_provider': _insuranceProviderController.text,
        'medical_history': _medicalHistoryController.text,
        'smoker': _smokerController.text,
        'allergies': _allergiesController.text,
        'preferred_language': _preferredLanguageController.text,
        'ssn': _ssnController.text,
        'health_id': _healthIdController.text,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User registered successfully')),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration failed')),
      );
    }
  }

  // Function for date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.tealAccent.shade700,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.tealAccent.shade700,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      setState(() {
        _dobController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background with gradient and color patterns
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 227, 227),
                ], // White gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CustomPaint(
              painter: BackgroundPatternPainter(),
            ),
          ),
          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Back button and heading text
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
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
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _usernameController,
                          label: 'Username',
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _confirmPasswordController,
                          label: 'Confirm Password',
                          icon: Icons.lock_outline,
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _nameController,
                          label: 'Name',
                          icon: Icons.badge,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: _buildTextField(
                              controller: _dobController,
                              label: 'Date of Birth',
                              icon: Icons.cake,
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _mobileController,
                          label: 'Mobile Number',
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _genderController,
                          label: 'Gender',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _addressController,
                          label: 'Address',
                          icon: Icons.home,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _occupationController,
                          label: 'Occupation',
                          icon: Icons.work,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _emergencyContactController,
                          label: 'Emergency Contact',
                          icon: Icons.phone_in_talk,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _nationalityController,
                          label: 'Nationality',
                          icon: Icons.flag,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _maritalStatusController,
                          label: 'Marital Status',
                          icon: Icons.favorite,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _bloodGroupController,
                          label: 'Blood Group',
                          icon: Icons.bloodtype,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _heightController,
                          label: 'Height (cm)',
                          icon: Icons.height,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _weightController,
                          label: 'Weight (kg)',
                          icon: Icons.monitor_weight,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _insuranceProviderController,
                          label: 'Insurance Provider',
                          icon: Icons.security,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _medicalHistoryController,
                          label: 'Medical History',
                          icon: Icons.medical_services,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _smokerController,
                          label: 'Smoker (Yes/No)',
                          icon: Icons.smoke_free,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _allergiesController,
                          label: 'Allergies',
                          icon: Icons.sanitizer,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _preferredLanguageController,
                          label: 'Preferred Language',
                          icon: Icons.language,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _ssnController,
                          label: 'SSN',
                          icon: Icons.perm_identity,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _healthIdController,
                          label: 'Health ID',
                          icon: Icons.health_and_safety,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 20.0),
                            backgroundColor:
                                const Color.fromARGB(255, 25, 25, 180),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        prefixIcon: Icon(icon, color: Colors.black54),
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }
}

// Custom painter for background pattern (same as in LoginPage)
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
