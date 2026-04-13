import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _soundEnabled = true;
  bool _darkMode = false;
  int _aiDifficulty = 2; // 1: سهل, 2: متوسط, 3: صعب

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _soundEnabled = prefs.getBool('sound_enabled') ?? true;
      _darkMode = prefs.getBool('dark_mode') ?? false;
      _aiDifficulty = prefs.getInt('ai_difficulty') ?? 2;
    });
  }

  _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sound_enabled', _soundEnabled);
    await prefs.setBool('dark_mode', _darkMode);
    await prefs.setInt('ai_difficulty', _aiDifficulty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        backgroundColor: const Color(0xFFB71C1C),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(
              'تشغيل المؤثرات الصوتية',
              style: GoogleFonts.cairo(),
            ),
            value: _soundEnabled,
            onChanged: (value) {
              setState(() => _soundEnabled = value);
              _saveSettings();
            },
            secondary: const Icon(Icons.volume_up, color: Color(0xFFB71C1C)),
          ),
          SwitchListTile(
            title: Text(
              'الوضع الليلي',
              style: GoogleFonts.cairo(),
            ),
            value: _darkMode,
            onChanged: (value) {
              setState(() => _darkMode = value);
              _saveSettings();
              // تغيير الثيم العام
              if (value) {
                Theme.of(context).brightness == Brightness.dark;
              }
            },
            secondary: const Icon(Icons.dark_mode, color: Color(0xFFB71C1C)),
          ),
          ListTile(
            title: Text(
              'مستوى الذكاء الاصطناعي',
              style: GoogleFonts.cairo(),
            ),
            subtitle: Slider(
              value: _aiDifficulty.toDouble(),
              min: 1,
              max: 3,
              divisions: 2,
              label: _aiDifficulty == 1 ? 'سهل' : (_aiDifficulty == 2 ? 'متوسط' : 'صعب'),
              onChanged: (value) {
                setState(() => _aiDifficulty = value.toInt());
                _saveSettings();
              },
            ),
            trailing: Text(
              _aiDifficulty == 1 ? 'سهل' : (_aiDifficulty == 2 ? 'متوسط' : 'صعب'),
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              'حول اللعبة',
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'شطة رنج - لعبة شطرنج عصرية\nالإصدار 1.0.0',
              style: GoogleFonts.cairo(),
            ),
            leading: const Icon(Icons.info, color: Color(0xFFB71C1C)),
          ),
        ],
      ),
    );
  }
}
