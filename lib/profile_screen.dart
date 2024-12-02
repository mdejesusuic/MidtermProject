import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String bio =
      "A passionate software engineer with experience in developing mobile applications and a strong interest in UI/UX design.";
  List<String> goals = [
    "Run a 10K race by the end of the year.",
    "Complete 100 workout sessions in 2024.",
    "Drink at least 2 liters of water daily."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen (to be implemented)
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              SizedBox(height: 10),
              Text(
                "Marc De Jesus",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Divider(height: 30, thickness: 2),

              // Bio Section
              _buildSectionTitle("Bio"),
              SizedBox(height: 10),
              _buildEditableCard(
                title: "Bio",
                content: bio,
                onEdit: (newBio) {
                  setState(() {
                    bio = newBio;
                  });
                },
              ),
              SizedBox(height: 20),

              // Fitness Goals Section
              _buildSectionTitle("Fitness Goals"),
              SizedBox(height: 10),
              GoalsSection(
                initialGoals: goals,
                onGoalUpdated: (updatedGoal, index) {
                  setState(() {
                    goals[index] = updatedGoal;
                  });
                },
              ),
              SizedBox(height: 20),

              // Achievements Section
              _buildSectionTitle("Achievements"),
              SizedBox(height: 10),
              _buildAchievementsList(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  // Helper method to create editable cards
  Widget _buildEditableCard({
    required String title,
    required String content,
    required Function(String) onEdit,
  }) {
    return GestureDetector(
      onTap: () {
        _showEditDialog(context, title, content, onEdit);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  // Show dialog to edit text (Bio or Goal)
  void _showEditDialog(BuildContext context, String title, String initialText,
      Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: initialText);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $title"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter your $title here"),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Helper method to create Achievements List
  Widget _buildAchievementsList() {
    return Column(
      children: [
        AchievementsCard(
          title: "5K Run Completed",
          date: "March 10, 2024",
          badge: "🏅",
        ),
        AchievementsCard(
          title: "10 Days of Consistent Workouts",
          date: "April 5, 2024",
          badge: "🎖️",
        ),
        AchievementsCard(
          title: "Healthy Eating Badge",
          date: "April 15, 2024",
          badge: "🥗",
        ),
      ],
    );
  }
}

// Goals section widget to handle goal listing and editing
class GoalsSection extends StatelessWidget {
  final List<String> initialGoals;
  final Function(String, int) onGoalUpdated;

  GoalsSection({required this.initialGoals, required this.onGoalUpdated});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: initialGoals.asMap().entries.map((entry) {
        int index = entry.key;
        String goal = entry.value;
        return GestureDetector(
          onTap: () {
            _showEditGoalDialog(context, goal, index);
          },
          child: GoalCard(goal: goal),
        );
      }).toList(),
    );
  }

  // Show dialog to edit goal text
  void _showEditGoalDialog(
      BuildContext context, String initialGoal, int index) {
    TextEditingController controller = TextEditingController(text: initialGoal);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Goal"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter your goal here"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onGoalUpdated(controller.text, index);
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}

// Goal card widget
class GoalCard extends StatelessWidget {
  final String goal;

  GoalCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          goal,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

// Achievements card widget
class AchievementsCard extends StatelessWidget {
  final String title;
  final String date;
  final String badge;

  AchievementsCard({
    required this.title,
    required this.date,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(date, style: TextStyle(color: Colors.grey)),
              ],
            ),
            Text(badge, style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
