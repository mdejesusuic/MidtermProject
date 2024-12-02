import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> fitnessItems = [
    {
      'title': 'Steps',
      'icon': Icons.directions_walk,
      'value': '12,345',
      'progress': 0.8
    },
    {
      'title': 'Calories Burned',
      'icon': Icons.local_fire_department,
      'value': '650 kcal',
      'progress': 0.6
    },
    {
      'title': 'Water Intake',
      'icon': Icons.local_drink,
      'value': '2.5 L',
      'progress': 0.7
    },
    {
      'title': 'Sleep',
      'icon': Icons.bedtime,
      'value': '7h 30m',
      'progress': 0.9
    },
    {
      'title': 'Workouts',
      'icon': Icons.fitness_center,
      'value': '4 this week',
      'progress': 0.4
    },
    {
      'title': 'Heart Rate',
      'icon': Icons.favorite,
      'value': '72 bpm',
      'progress': 0.5
    },
    {
      'title': 'BMI',
      'icon': Icons.accessibility,
      'value': '22.3',
      'progress': 0.6
    },
    {
      'title': 'Goals',
      'icon': Icons.flag,
      'value': '2/5 completed',
      'progress': 0.4
    },
  ];

  bool isDarkMode = false;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(fitnessItems),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.blue],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile_picture.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text('Marc De Jesus',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Text('marcdejesus@example.com',
                      style: TextStyle(fontSize: 16, color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.blue),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.blue),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics, color: Colors.blue),
              title: Text('Statistics'),
              onTap: () {
                Navigator.pushNamed(context, '/statistics');
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.blue),
              title: Text('Activity History'),
              onTap: () {
                Navigator.pushNamed(context, '/activityHistory');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: fitnessItems.length,
        itemBuilder: (context, index) {
          var item = fitnessItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailScreen(
                    title: item['title'],
                    value: item['value'],
                  ),
                ),
              );
            },
            child: Card(
              color: Colors.blue[50],
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], size: 50, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(item['title'],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900])),
                    SizedBox(height: 5),
                    Text(item['value'],
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[600])),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: item['progress'],
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/addItem');
        },
      ),
    );
  }
}

class ItemDetailScreen extends StatelessWidget {
  final String title;
  final String value;

  const ItemDetailScreen({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title Details"),
      ),
      body: Center(
        child: Text(
          "$title: $value",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> fitnessItems;

  CustomSearchDelegate(this.fitnessItems);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = fitnessItems
        .where(
            (item) => item['title'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    return results.isEmpty
        ? Center(
            child: Text('No results found',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)))
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(results[index]['title'],
                    style: TextStyle(
                        color: Colors.blue[900], fontWeight: FontWeight.bold)),
                subtitle: Text(results[index]['value']),
                leading: Icon(results[index]['icon'], color: Colors.blue),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailScreen(
                        title: results[index]['title'],
                        value: results[index]['value'],
                      ),
                    ),
                  );
                },
              );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? fitnessItems.map((item) => item['title']).toList()
        : fitnessItems
            .where((item) =>
                item['title'].toLowerCase().startsWith(query.toLowerCase()))
            .map((item) => item['title'])
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
