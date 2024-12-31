import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/settings_provider.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => _showSettingsDialog(context),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: Consumer<SettingsProvider>(
          builder: (context, settings, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: settings.isDarkMode,
                  onChanged: (_) => settings.toggleTheme(),
                ),
                SwitchListTile(
                  title: const Text('Use Celsius'),
                  value: settings.isCelsius,
                  onChanged: (_) => settings.toggleTemperatureUnit(),
                ),
                SwitchListTile(
                  title: const Text('Weather Alerts'),
                  value: settings.enableNotifications,
                  onChanged: (_) => settings.toggleNotifications(),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}