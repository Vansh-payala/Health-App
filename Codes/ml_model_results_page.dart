import 'package:flutter/material.dart';

class MLModelResultsPage extends StatelessWidget {
  final String predictedDisease;

  const MLModelResultsPage({super.key, required this.predictedDisease});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Decoration
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 37, 138), // Deep Blue
                  Color.fromARGB(255, 241, 250, 255), // Lighter Blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Content Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Bar section with back button
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      'ML Model Results',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              // Spacer for some breathing space
              const SizedBox(height: 40),

              // Predicted Disease Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Predicted Disease:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),

              // The actual predicted disease result
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    predictedDisease,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // Add additional information or advice if needed
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Text(
                  'Please chat with out chatbot to know more about the disease, prescriptions, and Dos and Donts about the disease.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
