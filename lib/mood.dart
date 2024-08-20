import 'package:flutter/material.dart';
import 'Result.dart'; // Import ResultsPage

class MoodTrackingPage extends StatefulWidget {
  @override
  _MoodTrackingPageState createState() => _MoodTrackingPageState();
}

class _MoodTrackingPageState extends State<MoodTrackingPage> {
  final List<Map<String, dynamic>> questions = [
    {'question': 'How are you feeling today?', 'options': ['Very Good', 'Good', 'Neutral', 'Bad', 'Very Bad']},
    {'question': 'How stressed are you?', 'options': ['Not Stressed', 'Slightly Stressed', 'Moderately Stressed', 'Very Stressed', 'Extremely Stressed']},
    {'question': 'How well did you sleep last night?', 'options': ['Very Well', 'Well', 'Okay', 'Poorly', 'Very Poorly']},
    {'question': 'How often do you feel anxious?', 'options': ['Never', 'Rarely', 'Sometimes', 'Often', 'Always']},
    {'question': 'How satisfied are you with your work-life balance?', 'options': ['Very Satisfied', 'Satisfied', 'Neutral', 'Dissatisfied', 'Very Dissatisfied']},
    {'question': 'How would you rate your overall mood this week?', 'options': ['Excellent', 'Good', 'Average', 'Below Average', 'Poor']},
    {'question': 'How frequently do you exercise?', 'options': ['Daily', 'Weekly', 'Monthly', 'Rarely', 'Never']},
    {'question': 'How social have you been recently?', 'options': ['Very Social', 'Somewhat Social', 'Neutral', 'Somewhat Isolated', 'Very Isolated']},
    {'question': 'How often do you engage in hobbies?', 'options': ['Daily', 'Weekly', 'Monthly', 'Rarely', 'Never']},
    {'question': 'How often do you feel overwhelmed?', 'options': ['Never', 'Rarely', 'Sometimes', 'Often', 'Always']},
  ];

  final List<int?> _answers = List.filled(10, null);

  void _submitAnswers() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(answers: _answers),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question['question'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...question['options'].map<Widget>((option) {
                      return ListTile(
                        title: Text(option),
                        leading: Radio<int>(
                          value: question['options'].indexOf(option),
                          groupValue: _answers[index],
                          onChanged: (value) {
                            setState(() {
                              _answers[index] = value;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitAnswers,
        child: Icon(Icons.check),
        tooltip: 'Submit Answers',
      ),
    );
  }
}
