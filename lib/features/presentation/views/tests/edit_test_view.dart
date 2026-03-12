import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../../utils/enums.dart';
import '../../../tutor/models/firestore_test.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/group_dropdown.dart';

class EditTestView extends StatefulWidget {
  const EditTestView({super.key});

  @override
  State<EditTestView> createState() => _EditTestViewState();
}

class _EditTestViewState extends State<EditTestView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _testUrlController = TextEditingController();
  final _totalQuestionsController = TextEditingController(text: '20');

  String? _selectedGroup;
  DateTime? _dueDate;
  bool _isSaving = false;
  bool _initialized = false;

  String get _testId {
    final args = ModalRoute.of(context)?.settings.arguments;
    return args is String ? args : '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _testUrlController.dispose();
    _totalQuestionsController.dispose();
    super.dispose();
  }

  void _applyTest(FirestoreTest test) {
    if (_initialized) return;
    _initialized = true;
    _titleController.text = test.title;
    _descriptionController.text = test.description;
    _testUrlController.text = test.testUrl;
    _totalQuestionsController.text = '${test.totalQuestions}';
    _selectedGroup = test.group.isEmpty ? null : test.group;
    _dueDate = test.dueDate;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && mounted) {
      setState(() => _dueDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedGroup == null || _selectedGroup!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a group')),
      );
      return;
    }
    if (_testId.isEmpty || _isSaving) return;

    setState(() => _isSaving = true);

    try {
      await FirebaseFirestore.instance.collection('tests').doc(_testId).update({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'dueDate': _dueDate != null ? Timestamp.fromDate(_dueDate!) : null,
        'group': _selectedGroup!,
        'test_url': _testUrlController.text.trim(),
        'totalQuestions': int.tryParse(_totalQuestionsController.text.trim()) ?? 20,
      });

      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AppDialog(
          title: 'Success',
          description: 'Test updated successfully.',
          alertType: AlertType.SUCCESS,
          positiveButtonText: 'Done',
          onPositiveCallback: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      );
    } catch (_) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => const AppDialog(
          title: 'Failed',
          description: 'Could not update test. Please try again.',
          alertType: AlertType.FAIL,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppDialog(
        title: 'Delete Test',
        description: 'Are you sure you want to delete this test?',
        alertType: AlertType.FAIL,
        positiveButtonText: 'Delete',
        negativeButtonText: 'Cancel',
        onPositiveCallback: () async {
          try {
            await FirebaseFirestore.instance
                .collection('tests')
                .doc(_testId)
                .delete();
            if (!mounted) return;
            // ignore: use_build_context_synchronously - mounted checked above
            Navigator.pop(context); // close delete confirm dialog
            showDialog(
              // ignore: use_build_context_synchronously - mounted checked above
              context: context,
              barrierDismissible: false,
              builder: (_) => AppDialog(
                title: 'Success',
                description: 'Test deleted successfully.',
                alertType: AlertType.SUCCESS,
                positiveButtonText: 'Done',
                onPositiveCallback: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            );
          } catch (_) {
            if (!mounted) return;
            // ignore: use_build_context_synchronously - mounted checked above
            Navigator.pop(context);
            showDialog(
              // ignore: use_build_context_synchronously - mounted checked above
              context: context,
              builder: (_) => const AppDialog(
                title: 'Failed',
                description: 'Could not delete test. Please try again.',
                alertType: AlertType.FAIL,
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Edit Test'),
      body: SafeArea(
        child: _testId.isEmpty
            ? Center(
                child: Text(
                  'Invalid test.',
                  style: TextStyle(
                    color: colors(context).secondaryText,
                    fontSize: 14.sp,
                  ),
                ),
              )
            : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('tests')
                    .doc(_testId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || !snapshot.data!.exists) {
                    return Center(
                      child: Text(
                        snapshot.hasError
                            ? 'Failed to load test.'
                            : 'Test not found.',
                        style: TextStyle(
                          color: colors(context).secondaryText,
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  }

                  final test = FirestoreTest.fromDoc(snapshot.data!);
                  _applyTest(test);

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Group',
                            style: TextStyle(
                              color: colors(context).text,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          10.verticalSpace,
                          GroupDropdown(
                            selectedGroup: _selectedGroup,
                            onChanged: (value) {
                              setState(() => _selectedGroup = value);
                            },
                          ),
                          18.verticalSpace,
                          CommonTextField(
                            controller: _titleController,
                            labelText: 'Main Title',
                            hintText: 'Enter Main Title',
                            validator: (v) =>
                                v == null || v.trim().isEmpty ? 'Required' : null,
                          ),
                          18.verticalSpace,
                          _DescriptionField(
                            controller: _descriptionController,
                          ),
                          18.verticalSpace,
                          _DueDateField(
                            dueDate: _dueDate,
                            onTap: _pickDueDate,
                          ),
                          18.verticalSpace,
                          CommonTextField(
                            controller: _testUrlController,
                            labelText: 'Test URL / Material link',
                            hintText: 'https://...',
                            keyboardType: TextInputType.url,
                          ),
                          18.verticalSpace,
                          CommonTextField(
                            controller: _totalQuestionsController,
                            labelText: 'Total Questions',
                            hintText: '20',
                            keyboardType: TextInputType.number,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Required';
                              final n = int.tryParse(v.trim());
                              if (n == null || n < 1) return 'Enter a valid number';
                              return null;
                            },
                          ),
                          32.verticalSpace,
                          CommonButton(
                            text: 'Save',
                            isLoading: _isSaving,
                            onPressed: _save,
                          ),
                          16.verticalSpace,
                          CommonButton(
                            text: 'Delete Test',
                            backgroundColor: Colors.red,
                            onPressed: _confirmDelete,
                          ),
                          24.verticalSpace,
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const _DescriptionField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            color: colors(context).text,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        14.verticalSpace,
        TextFormField(
          controller: controller,
          maxLines: 4,
          style: AppStyling.normal400Size15.copyWith(color: colors(context).text),
          decoration: InputDecoration(
            hintText: 'Add Description',
            hintStyle: TextStyle(color: colors(context).secondaryText),
            filled: true,
            fillColor: colors(context).secondarySurface,
            contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: colors(context).secondarySurfaceBorder,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: Colors.blue.withValues(alpha: 0.7),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DueDateField extends StatelessWidget {
  final DateTime? dueDate;
  final VoidCallback onTap;

  const _DueDateField({this.dueDate, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final text = dueDate != null
        ? '${dueDate!.day}/${dueDate!.month}/${dueDate!.year}'
        : 'Select due date';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Due Date',
          style: TextStyle(
            color: colors(context).text,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        14.verticalSpace,
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            height: 46.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: colors(context).secondarySurface,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: colors(context).secondarySurfaceBorder,
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 19.h,
                  color: colors(context).secondaryText,
                ),
                12.horizontalSpace,
                Text(
                  text,
                  style: TextStyle(
                    color: dueDate != null
                        ? colors(context).text
                        : colors(context).secondaryText,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
