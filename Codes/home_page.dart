import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Health icon at the top
                      Icon(
                        Icons.local_hospital,
                        color:
                            Color.fromARGB(196, 253, 0, 0), // Dark blue color
                        size: 80, // Size of the icon
                      ),
                      SizedBox(height: 10),
                      // Heading text
                      Text(
                        'Welcome to Personal HealthCare App',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(
                              255, 0, 38, 253), // Dark blue text color
                          fontFamily: 'Roboto',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Your health journey starts here.',
                        style: TextStyle(
                          fontSize: 18,
                          color:
                              Color.fromARGB(255, 0, 0, 0), // Subtle grey color
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegisterPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              backgroundColor: const Color.fromARGB(
                                  255, 25, 25, 180), // Dark blue button
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 20.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Text('Sign Up'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color.fromARGB(
                                  255, 25, 25, 180), // Dark blue button
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 20.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30), // Add space at the bottom
                  ],
                ),
              ),
            ],
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
