import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastead/providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
        backgroundColor: Colors.amber.shade800,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Consumer<SettingsProvider>(
          builder: (ctx, settingsProvider, _) => SwitchListTile(
            title: const Text('Aktifkan pengingat harian'),
            value: settingsProvider.isReminderEnabled,
            onChanged: (value) {
              settingsProvider.setReminder(value);
            },
          ),
        ),
      ),
    );
  }
}
