import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/subject_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/summary_card.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubjectProvider>();

    if (provider.subjects.isEmpty) {
      return const EmptyState(
        icon: Icons.analytics,
        title: 'No Summary Available',
        subtitle:
            'Your academic summary will appear here after you add your first subject.',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Academic Summary',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        SummaryCard(
          icon: Icons.subject,
          title: 'Total Subjects',
          value: provider.totalSubjects.toString(),
        ),

        SummaryCard(
          icon: Icons.calculate_rounded,
          title: 'Average Mark',
          value: provider.averageMark.toStringAsFixed(2),
        ),

        SummaryCard(
          icon: Icons.grade_rounded,
          title: 'Overall Grade',
          value: provider.overallGrade,
        ),

        SummaryCard(
          icon: Icons.check_circle_rounded,
          title: 'Passing Subjects',
          value: provider.passingSubjects.length.toString(),
        ),

        const SizedBox(height: 20),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      provider.performanceIcon,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Performance Insight',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Text(
                  provider.performanceMessage,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
