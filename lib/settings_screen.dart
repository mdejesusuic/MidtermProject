import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChanged; // Callback to notify theme change

  SettingsScreen({required this.onThemeChanged});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _isDarkMode = false;
  String _appVersion = '1.0.0';
  String _profilePictureUrl = '';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _profilePictureUrl = prefs.getString('profilePictureUrl') ?? '';
    });
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
    await prefs.setBool('isDarkMode', _isDarkMode); // Save the theme preference
    await prefs.setString('profilePictureUrl', _profilePictureUrl);
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    widget.onThemeChanged(_isDarkMode); // Notify MyApp to change the theme
    _saveSettings();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Theme changed to ${_isDarkMode ? 'Dark' : 'Light'}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Settings",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          _buildSwitchTile(
            context,
            title: "Enable Notifications",
            subtitle: "Receive notifications about updates",
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
              _saveSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Notifications ${value ? 'enabled' : 'disabled'}')),
              );
            },
          ),
          _buildCard(
            context,
            icon: Icons.palette,
            title: "Appearance",
            subtitle: "Choose your app theme",
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (bool newValue) {
                _toggleTheme(); // Toggle theme
              },
            ),
          ),
          // Privacy Policy Section
          _buildCard(
            context,
            icon: Icons.security,
            title: "Privacy Policy",
            subtitle: "View our privacy policy",
            onTap: () {
              // Navigate to Privacy Policy screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
              );
            },
          ),
          // Help & Support Section
          _buildCard(
            context,
            icon: Icons.help_outline,
            title: "Help & Support",
            subtitle: "Get assistance with the app",
            onTap: () {
              // Navigate to Help & Support screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpSupportScreen()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              "App Version: $_appVersion",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Function()? onTap,
    Widget? trailing,
  }) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: trailing ?? Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 4,
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

// Placeholder screen for Privacy Policy
class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policy")),
      body: Center(
        child: Text(
            "At FitLife, we prioritize your privacy and are committed to safeguarding your personal information. When you use our app, we collect personal data such as your name, email, date of birth, gender, and fitness data like workout history, calories burned, and distance traveled. We may also collect device information, location data, and payment details for in-app purchases or subscriptions. This information is used to provide personalized fitness recommendations, improve app functionality, communicate app updates, and process transactions. We do not share your data with third parties, except for trusted service providers who assist us in app operations and in cases where disclosure is required by law. We implement reasonable security measures to protect your information, but cannot guarantee absolute security. You have the right to access, correct, or delete your data, and can opt out of marketing communications at any time.FitLife is not intended for children under 13, and we do not knowingly collect data from them. We may update this Privacy Policy periodically, and any changes will be posted with the effective date. If you have any questions, please contact us"),
      ),
    );
  }
}

// Placeholder screen for Help & Support
class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Help & Support")),
      body: Center(
        child: Text(
            "If you need assistance with FitLife, our support team is here to help! You can visit our in-app FAQ section for quick answers to common questions or use the live chat feature to reach out to us directly.We are committed to ensuring you have the best experience with FitLife and will address any concerns promptly."),
      ),
    );
  }
}
