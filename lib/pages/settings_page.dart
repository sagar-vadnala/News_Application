
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        margin: const EdgeInsets.only(left: 25, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // dark mode
            Text(
              "Dark Mode",
              style: TextStyle(fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary
              ),
              ),
        
            // switch toggle
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context, listen: false ).isDarkMode,
              onChanged: (value) => 
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme()
              )
          ],
          
          
        ),
      ),
    );
  }
}