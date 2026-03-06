import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../tutor/models/firestore_test.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_text_field.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/group_dropdown.dart';

class AddTestView extends StatefulWidget {
  const AddTestView({super.key});

  @override
  State<AddTestView> createState() => _AddTestViewState();
}

class _AddTestViewState extends State<AddTestView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _testUrlController = TextEditingController();
  final _totalQuestionsController = TextEditingController(text: '20');

  String? _selectedGroup;
  DateTime? _dueDate;
  bool _isUploading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _testUrlController.dispose();
    _totalQuestionsController.dispose();
    super.dispose();
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

  Future<void> _upload() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedGroup == null || _selectedGroup!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a group')),
      );
      return;
    }
    if (_isUploading) return;

    setState(() => _isUploading = true);

    try {
      final now = DateTime.now();
      final test = FirestoreTest(
        id: '', // Firestore will assign
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        dueDate: _dueDate,
        group: _selectedGroup!,
        testUrl: _testUrlController.text.trim(),
        totalQuestions: int.tryParse(_totalQuestionsController.text.trim()) ?? 20,
        createdAt: now,
      );

      await FirebaseFirestore.instance
          .collection('tests')
          .add(test.toMap());

      if (!mounted) return;
      _showSuccessDialog();
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => const AppDialog(
          title: 'Failed',
          description: 'Could not upload test. Please try again.',
          alertType: AlertType.FAIL,
        ),
      );
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppDialog(
        title: 'Success',
        description: 'Test uploaded successfully.',
        alertType: AlertType.SUCCESS,
        positiveButtonText: 'Download QR',
        negativeButtonText: 'Done',
        onPositiveCallback: () {
          Navigator.pop(context); // close dialog
          Navigator.pushNamed(context, Routes.kTutorQrGenerateView);
        },
        onNegativeCallback: () {
          Navigator.pop(context); // back to manage tests
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Add New Test'),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  text: 'Upload',
                  isLoading: _isUploading,
                  onPressed: _upload,
                ),
                24.verticalSpace,
              ],
            ),
          ),
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
