import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Enable Call Screening'),
            trailing: Switch(value: true, onChanged: null),
          ),
          ListTile(
            title: Text('Auto-summarize Calls'),
            trailing: Switch(value: true, onChanged: null),
          ),
          ListTile(
            title: Text('Use My Voice Model'),
            subtitle: Text('Currently: Default AI Voice'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
