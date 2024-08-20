import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultPage extends StatelessWidget {
  final List<int?> answers;

  ResultPage({required this.answers});

  String _calculateResult() {
    int totalScore = answers.where((answer) => answer != null).fold(0, (sum, answer) => sum + (answer! + 1)); // Scores from 1 to 5

    String result;
    if (totalScore <= 20) {
      result = 'Your mental health is concerning. Consider seeking support.';
    } else if (totalScore <= 35) {
      result = 'You might be experiencing some stress. Try to take care of yourself.';
    } else if (totalScore <= 50) {
      result = 'Your mental health is okay. Keep maintaining a balanced lifestyle.';
    } else {
      result = 'Your mental health is excellent. Keep up the great work!';
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    String result = _calculateResult();

    List<double> distribution = List.generate(5, (index) {
      return answers.where((answer) => answer == index).length.toDouble();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Assessment Result'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display the result statement
            Text(
              result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Display the pie chart
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: List.generate(5, (index) {
                    final color = _getColorForIndex(index);
                    final value = distribution[index];
                    final percentage = (value / answers.length * 100).toStringAsFixed(1);

                    return PieChartSectionData(
                      color: color,
                      value: value,
                      title: '$percentage%',
                      radius: 100,
                      titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      showTitle: true,
                      badgeWidget: Text('${value.toInt()}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      badgePositionPercentageOffset: 1.2,
                    );
                  }),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Add some information below the pie chart
            Text(
              'Distribution of Responses:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal[800]),
            ),
            SizedBox(height: 10),
            ...List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: _getColorForIndex(index),
                      radius: 10,
                    ),
                    SizedBox(width: 10),
                    Text(
                      _getLabelForIndex(index),
                      style: TextStyle(fontSize: 14, color: Colors.teal[600]),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Color _getColorForIndex(int index) {
    switch (index) {
      case 0:
        return Colors.green;       // Very Good / Excellent
      case 1:
        return Colors.blue;        // Good
      case 2:
        return Colors.yellow;      // Neutral / Average
      case 3:
        return Colors.orange;      // Bad / Poor
      case 4:
        return Colors.red;         // Very Bad / Extremely Stressed
      default:
        return Colors.grey;        // Fallback color
    }
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Very Good / Excellent';
      case 1:
        return 'Good';
      case 2:
        return 'Neutral / Average';
      case 3:
        return 'Bad / Poor';
      case 4:
        return 'Very Bad / Extremely Stressed';
      default:
        return 'Unknown';
    }
  }
}
