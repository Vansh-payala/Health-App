import 'dart:ui'; // For ImageFilter
import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'ml_model_input_page.dart';
import 'chatbot_page.dart';
import 'chatscreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  String _predictedDisease = ''; // To store the predicted disease

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      const ProfilePage(),
      MLModelInputPage(
          onPrediction:
              _onPredictionMade), // Pass the callback to the input page
      ChatScreen(),
    ]);
  }

  void _onPredictionMade(String disease) {
    setState(() {
      _predictedDisease = disease;
      _showPredictionDialog(
          disease); // Show a dialog with the prediction result
    });
  }

  void _showPredictionDialog(String disease) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Prediction Result"),
          content: Text("Predicted Disease: $disease"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/backg4.jpg',
            fit: BoxFit.cover,
          ),
          // Blurred background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          // Main content
          _pages[
              _currentIndex], // This correctly references the currently selected page
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
        selectedItemColor: const Color.fromARGB(255, 21, 0, 255),
        unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input),
            label: 'Model Input',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chatbot',
          ),
        ],
      ),
    );
  }
}
