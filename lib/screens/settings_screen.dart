import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Call Screening",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: const Text('Enable Call Screening'),
            value: true,
            onChanged: (_) {
              // Handle toggle
            },
          ),
          SwitchListTile(
            title: const Text('Auto Summarize Calls'),
            value: true,
            onChanged: (_) {
              // Handle toggle
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "AI Preferences",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Voice Personality'),
            subtitle: const Text('Default AI Voice'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Future voice profile selection
            },
          ),
        ],
      ),
    );
  }
}
