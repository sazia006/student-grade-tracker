import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/navigation_provider.dart';
import '../providers/theme_provider.dart';

import 'add_subject_screen.dart';
import 'subject_list_screen.dart';
import 'summary_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = context.watch<NavigationProvider>();
    final theme = context.watch<ThemeProvider>();

    final pages = const [
      AddSubjectScreen(),
      SubjectListScreen(),
      SummaryScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Grade Tracker"),
        actions: [
          IconButton(
            onPressed: () {
              theme.toggleTheme();
            },
            icon: Icon(theme.isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),

      body: pages[navigation.currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigation.currentIndex,

        onTap: navigation.changeIndex,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Subjects"),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Summary",
          ),
        ],
      ),
    );
  }
}
