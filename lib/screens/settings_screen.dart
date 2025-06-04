import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _ttsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _ttsEnabled = prefs.getBool('tts_enabled') ?? true;
    });
  }

  Future<void> _toggleTTS(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tts_enabled', value);
    print("TTS set to: $value");
    setState(() {
      _ttsEnabled = value;
    });
  }

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
          SwitchListTile(
            title: const Text("Enable Voice Summaries (TTS)"),
            value: _ttsEnabled,
            onChanged: _toggleTTS,
          )
        ],
      ),
    );
  }
}
