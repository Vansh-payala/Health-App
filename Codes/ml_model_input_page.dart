import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ml_model_results_page.dart';

class MLModelInputPage extends StatefulWidget {
  const MLModelInputPage({super.key, required this.onPrediction});

  final void Function(String disease) onPrediction;

  @override
  _MLModelInputPageState createState() => _MLModelInputPageState();
}

class _MLModelInputPageState extends State<MLModelInputPage>
    with SingleTickerProviderStateMixin {
  String? selectedSymptom1;
  String? selectedSymptom2;
  String? selectedSymptom3;
  late AnimationController _animationController;

  List<String> symptoms = [
    'Abdominal pain',
    'Belly pain',
    'Nausea',
    'Fever',
    'Cough',
    'Difficulty breathing',
    'Joint pain',
    'Fatigue',
    'Muscle weakness',
    'Chest pain',
    'Fast heart rate',
    'Shortness of breath',
    'Blurred vision',
    'Loss of consciousness',
    'Bladder discomfort',
    'Painful urination',
    'Foul smell of urine',
    'Jaundice',
    'Yellowing of eyes',
    'Excessive hunger',
    'Unexplained weight loss',
    'Acne',
    'Blackheads',
    'Oily skin',
    'Depression',
    'Irritability',
    'Appetite loss',
    'Diarrhea',
    'Vomiting',
    'Sweating',
    'Headache',
    'Sensitivity to light',
    'Back pain',
    'Leg pain',
    'Weakness',
    'Ear pain',
    'Sore throat',
    'Swollen lymph nodes',
    'Weight gain',
    'Cold intolerance',
    'Constipation',
    'Rash',
    'Itching',
    'Swelling',
    'Abnormal heart rhythm',
    'Dizziness',
    'Fainting',
    'Dry mouth',
    'Increased thirst',
    'Frequent urination',
    'Knee pain',
    'Stiffness',
    'Persistent cough',
    'Chest tightness',
    'Wheezing',
    'Hair loss',
    'Sensitivity to cold',
    'Pale skin',
    'Abdominal swelling',
    'Painful joints',
    'Skin rash',
    'Sun sensitivity',
    'Loss of appetite',
    'Weight loss',
    'Red skin',
    'Pus discharge',
    'Severe headache',
    'Redness of eyes',
    'Watery discharge',
    'Hoarseness',
    'Difficulty swallowing',
    'Neck swelling'
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
      lowerBound: 0.98,
      upperBound: 1.0,
    );
    _animationController.value = 1.0;
  }

  Future<void> _predictDisease() async {
    if (selectedSymptom1 != null &&
        selectedSymptom2 != null &&
        selectedSymptom3 != null) {
      final List<String> chosenSymptoms = [
        selectedSymptom1!,
        selectedSymptom2!,
        selectedSymptom3!,
      ];

      try {
        final response = await http.post(
          Uri.parse('http://192.168.184.1:6000/predict'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'symptoms': chosenSymptoms}),
        );

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          final predictedDisease = result['disease'] ?? 'Unknown Disease';

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MLModelResultsPage(predictedDisease: predictedDisease),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to get prediction. Try again.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Connection error. Ensure the server is running.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all symptoms')),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Enhanced Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(254, 0, 10, 36),
                  Color.fromARGB(255, 9, 0, 177),
                  Color.fromARGB(255, 255, 255, 255)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            children: [
              // Custom AppBar
              Padding(
                padding:
                    const EdgeInsets.only(top: 60.0, bottom: 20.0, left: 16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(2, 5),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 24),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Model Input',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _buildSymptomDropdown(1),
                      const SizedBox(height: 15),
                      _buildSymptomDropdown(2),
                      const SizedBox(height: 15),
                      _buildSymptomDropdown(3),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTapDown: (_) => _animationController.reverse(),
                        onTapUp: (_) {
                          _animationController.forward();
                          _predictDisease();
                        },
                        child: ScaleTransition(
                          scale: _animationController,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 0, 0, 0),
                                  Color.fromARGB(255, 0, 0, 137)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 31, 77)
                                      .withOpacity(0.3),
                                  offset: Offset(0, 8),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: const Text(
                              'Predict Disease',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ),
                      ),
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

  Widget _buildSymptomDropdown(int symptomNumber) {
    String? selectedSymptom = symptomNumber == 1
        ? selectedSymptom1
        : symptomNumber == 2
            ? selectedSymptom2
            : selectedSymptom3;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(3, 5),
            blurRadius: 15,
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedSymptom,
          hint: Text(
            'Select Symptom $symptomNumber',
            style: TextStyle(color: Colors.grey[600]),
          ),
          onChanged: (String? newValue) {
            setState(() {
              if (symptomNumber == 1) selectedSymptom1 = newValue;
              if (symptomNumber == 2) selectedSymptom2 = newValue;
              if (symptomNumber == 3) selectedSymptom3 = newValue;
            });
          },
          items: symptoms.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                    color: Colors.grey[850], fontWeight: FontWeight.w600),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
