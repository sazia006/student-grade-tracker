import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/subject.dart';
import '../providers/subject_provider.dart';

import '../utils/validators.dart';

import '../widgets/app_button.dart';
import '../widgets/custom_text_field.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _markController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();

    _markController.dispose();

    super.dispose();
  }

  void addSubject() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider = context.read<SubjectProvider>();

    provider.addSubject(
      Subject(
        name: _nameController.text.trim(),
        mark: double.parse(_markController.text),
      ),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Subject Added Successfully")));

    _nameController.clear();

    _markController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Form(
        key: _formKey,

        child: Column(
          children: [
            const SizedBox(height: 20),

            CustomTextField(
              controller: _nameController,

              label: "Subject Name",

              icon: Icons.book,

              validator: Validators.validateSubject,
            ),

            const SizedBox(height: 20),

            CustomTextField(
              controller: _markController,

              label: "Marks",

              icon: Icons.numbers,

              keyboardType: TextInputType.number,

              validator: Validators.validateMarks,
            ),

            const SizedBox(height: 30),

            AppButton(
              text: "Add Subject",

              icon: Icons.add,

              onPressed: addSubject,
            ),
          ],
        ),
      ),
    );
  }
}
