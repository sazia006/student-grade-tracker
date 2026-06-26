import 'package:flutter/material.dart';

import '../models/subject.dart';

class SubjectProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];

  List<Subject> get subjects => List.unmodifiable(_subjects);

  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  void removeSubject(int index) {
    _subjects.removeAt(index);
    notifyListeners();
  }

  int get totalSubjects => _subjects.length;

  double get averageMark {
    if (_subjects.isEmpty) {
      return 0;
    }

    final total = _subjects.fold<double>(
      0,
      (sum, subject) => sum + subject.mark,
    );

    return total / _subjects.length;
  }

  String get overallGrade {
    final average = averageMark;

    if (average >= 80) {
      return 'A';
    }

    if (average >= 65) {
      return 'B';
    }

    if (average >= 50) {
      return 'C';
    }

    return 'F';
  }

  // Assignment requirement (.where())
  List<Subject> get passingSubjects {
    return _subjects.where((subject) => subject.mark >= 50).toList();
  }
}
