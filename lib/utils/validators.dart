class Validators {
  static String? validateSubject(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Subject name is required';
    }

    return null;
  }

  static String? validateMarks(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Marks are required';
    }

    final mark = double.tryParse(value);

    if (mark == null) {
      return 'Enter a valid number';
    }

    if (mark < 0 || mark > 100) {
      return 'Marks must be between 0 and 100';
    }

    return null;
  }
}
