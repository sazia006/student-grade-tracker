import 'package:flutter/material.dart';

import '../models/subject.dart';

class SubjectProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];

  List<Subject> get subjects => List.unmodifiable(_subjects);

  /// Add a new subject
  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  /// Remove subject and return it (for Undo)
  Subject? removeSubject(int index) {
    if (index < 0 || index >= _subjects.length) {
      return null;
    }

    final removedSubject = _subjects.removeAt(index);
    notifyListeners();
    return removedSubject;
  }

  /// Restore deleted subject
  void insertSubject(int index, Subject subject) {
    if (index < 0 || index > _subjects.length) {
      _subjects.add(subject);
    } else {
      _subjects.insert(index, subject);
    }

    notifyListeners();
  }

  int get totalSubjects => _subjects.length;

  double get averageMark {
    if (_subjects.isEmpty) return 0;

    final totalMarks = _subjects.fold<double>(
      0,
      (sum, subject) => sum + subject.mark,
    );

    return totalMarks / _subjects.length;
  }

  String get overallGrade {
    final average = averageMark;

    if (average >= 80) return 'A';
    if (average >= 65) return 'B';
    if (average >= 50) return 'C';

    return 'F';
  }

  /// Assignment Requirement (.where())
  List<Subject> get passingSubjects =>
      _subjects.where((subject) => subject.mark >= 50).toList();

  /// Bonus
  int get failedSubjects =>
      _subjects.where((subject) => subject.mark < 50).length;

  /// Bonus
  bool get hasSubjects => _subjects.isNotEmpty;

  /// Bonus
  void clearAllSubjects() {
    _subjects.clear();
    notifyListeners();
  }

  String get performanceMessage {
    switch (overallGrade) {
      case 'A':
        return 'Excellent performance! Keep up the great work. 🎉';

      case 'B':
        return 'Very good performance! You are doing well. 👏';

      case 'C':
        return 'Good effort. With a little more practice, you can improve further. 📚';

      default:
        return 'Needs improvement. Stay consistent and keep practicing. 💪';
    }
  }

  IconData get performanceIcon {
    switch (overallGrade) {
      case 'A':
        return Icons.emoji_events_rounded;

      case 'B':
        return Icons.thumb_up_alt_rounded;

      case 'C':
        return Icons.trending_up_rounded;

      default:
        return Icons.school_rounded;
    }
  }
}
