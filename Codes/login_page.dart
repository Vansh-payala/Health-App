import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login failed')),
      );
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
                  Color.fromARGB(255, 255, 227, 227)
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
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back button and heading text
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 16.0),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // App logo or icon
                  const Icon(
                    Icons.health_and_safety,
                    size: 80,
                    color: Color.fromARGB(196, 253, 0, 0), // Dark blue color
                  ),
                  const SizedBox(height: 40),
                  // Email text field
                  TextField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Email-ID',
                      labelStyle: const TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password text field
                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  // Login button
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 80.0),
                      backgroundColor: const Color.fromARGB(
                          255, 25, 25, 180), // Dark blue button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Forgot Password link
                  TextButton(
                    onPressed: () {
                      // Implement Forgot Password functionality here
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.black54),
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

// Custom painter for background pattern (same as in HomePage)
class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // Example of creating abstract shapes with new colors
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

    // Add more shapes and patterns as needed
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
