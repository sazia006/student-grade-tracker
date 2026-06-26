import 'package:flutter/material.dart';

import '../models/subject.dart';

class SubjectTile extends StatelessWidget {
  final Subject subject;

  const SubjectTile({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colors.primaryContainer,
          child: Icon(Icons.menu_book, color: colors.onPrimaryContainer),
        ),
        title: Text(
          subject.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text('Marks: ${subject.mark.toStringAsFixed(0)}'),
        trailing: Chip(label: Text(subject.grade)),
      ),
    );
  }
}
