import 'package:flutter/material.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

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
                ], // Gradient colors
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
                      icon: const Icon(Icons.arrow_back,
                          color: Color.fromARGB(255, 9, 9, 9)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 16.0),
                    const Text(
                      'Chatbot',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 2, 2),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Example content
                      Text(
                        'Chatbot functionality will be implemented here.',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 8, 234, 246),
                        ),
                      ),
                      // Add chatbot UI and functionality here
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
