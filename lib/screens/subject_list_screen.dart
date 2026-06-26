import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/subject_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/subject_tile.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubjectProvider>();

    if (provider.subjects.isEmpty) {
      return const EmptyState(
        icon: Icons.menu_book,
        title: 'No Subjects Yet',
        subtitle:
            'Tap the Add tab below and add your first subject to start tracking your grades.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: provider.subjects.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(provider.subjects[index].name),

          background: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            child: Icon(
              Icons.delete_rounded,
              color: Theme.of(context).colorScheme.onError,
            ),
          ),

          onDismissed: (_) {
            final removed = provider.removeSubject(index);

            if (removed == null) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${removed.name} deleted'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    provider.insertSubject(index, removed);
                  },
                ),
              ),
            );
          },

          child: SubjectTile(subject: provider.subjects[index]),
        );
      },
    );
  }
}
