import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Daily Summary
              dailySummary(),
              SizedBox(height: 20),

              // Weekly Overview Title
              Text(
                "Weekly Overview",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              SizedBox(height: 20),

              // Steps Card
              activityCard(Icons.directions_walk, "Steps",
                  "Your daily steps goal is 10,000", "12,345"),
              SizedBox(height: 10),

              // Calories Card
              activityCard(Icons.local_fire_department, "Calories",
                  "Calories burned this week", "1,500 kcal"),
              SizedBox(height: 10),

              // Active Minutes Card
              activityCard(Icons.timer, "Active Minutes",
                  "Weekly activity goal is 150 minutes", "45 min"),
              SizedBox(height: 20),

              // Activity Progress Indicator
              Text(
                "Activity Progress",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.3,
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                color: Colors.blue,
              ),
              SizedBox(height: 20),

              // Summary Section
              summarySection(
                  "Keep up the great work! You're on track to meet your fitness goals."),
              SizedBox(height: 30),

              // Monthly Overview Section
              Text(
                "Monthly Overview",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              SizedBox(height: 20),

              // Monthly Steps Card
              activityCard(Icons.directions_walk, "Steps",
                  "Steps taken this month", "250,000"),
              SizedBox(height: 10),

              // Monthly Calories Card
              activityCard(Icons.local_fire_department, "Calories",
                  "Calories burned this month", "15,000 kcal"),
              SizedBox(height: 10),

              // Monthly Active Minutes Card
              activityCard(Icons.timer, "Active Minutes",
                  "Activity goal: 600 minutes", "520 min"),
              SizedBox(height: 20),

              // Monthly Progress Indicator
              Text(
                "Monthly Progress",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.8,
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
              ),
              SizedBox(height: 20),

              // Monthly Summary Section
              summarySection(
                  "Fantastic progress this month! You're nearing your monthly goals."),
              SizedBox(height: 20),

              // Steps Chart
              Text(
                "Steps Chart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              stepsChart(),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blueAccent,
      ),
    );
  }

  // Daily Summary Widget
  Widget dailySummary() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Use min size for the container
          children: [
            Text(
              "Today's Summary",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Steps: 5,000\nCalories Burned: 600 kcal\nActive Minutes: 30 min",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Activity Card Widget
  Widget activityCard(
      IconData icon, String title, String subtitle, String trailing) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blueAccent),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(trailing, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  // Summary Section Widget
  Widget summarySection(String message) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Steps Chart Widget
  Widget stepsChart() {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(show: true),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 11000,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 5000),
                FlSpot(1, 7000),
                FlSpot(2, 3000),
                FlSpot(3, 8000),
                FlSpot(4, 9000),
                FlSpot(5, 10000),
                FlSpot(6, 11000),
              ],
              isCurved: true,
              color: Colors.blue,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
