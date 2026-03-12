import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/enums.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/group_dropdown.dart';

class EditStudentView extends StatefulWidget {
  const EditStudentView({super.key});

  @override
  State<EditStudentView> createState() => _EditStudentViewState();
}

class _EditStudentViewState extends State<EditStudentView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();

  String? _selectedGroupName;
  bool _isSaving = false;
  bool _initialized = false;

  String get _studentDocId {
    final args = ModalRoute.of(context)?.settings.arguments;
    return args is String ? args : '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _applyDocData(Map<String, dynamic> data) {
    if (_initialized) return;
    _initialized = true;
    _firstNameController.text = (data['first_name'] ?? '').toString();
    _lastNameController.text = (data['last_name'] ?? '').toString();
    _phoneController.text = (data['phone_number'] ?? '').toString();
    _emailController.text = (data['email'] ?? '').toString();
    _idController.text = (data['id'] ?? '').toString();
    final group = (data['group'] ?? '').toString();
    _selectedGroupName = group.isEmpty ? null : group;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isSaving) return;

    setState(() => _isSaving = true);

    try {
      await FirebaseFirestore.instance.collection('users').doc(_studentDocId).update({
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'phone_number': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
        'id': _idController.text.trim(),
        'group': _selectedGroupName ?? '',
      });

      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AppDialog(
          title: 'Success',
          description: 'Student updated successfully.',
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
          description: 'Unable to update student. Please try again.',
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
        title: 'Delete',
        description: 'Are you sure you want to delete this student?',
        alertType: AlertType.FAIL,
        positiveButtonText: 'Delete',
        negativeButtonText: 'Cancel',
        onPositiveCallback: () async {
          try {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(_studentDocId)
                .delete();
            if (!context.mounted) return;
            Navigator.pop(context); // close confirm dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AppDialog(
                title: 'Success',
                description: 'Student deleted successfully.',
                alertType: AlertType.SUCCESS,
                positiveButtonText: 'Done',
                onPositiveCallback: () {
                  Navigator.pop(context); // close success dialog
                  Navigator.pop(context); // close edit view
                },
              ),
            );
          } catch (_) {
            if (!context.mounted) return;
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => const AppDialog(
                title: 'Failed',
                description: 'Unable to delete the student. Please try again.',
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
      appBar: const CommonAppBar(title: 'Edit Student'),
      body: SafeArea(
        child: _studentDocId.isEmpty
            ? Center(
                child: Text(
                  'Invalid student.',
                  style: TextStyle(
                    color: colors(context).secondaryText,
                    fontSize: 14.sp,
                  ),
                ),
              )
            : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_studentDocId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || !snapshot.data!.exists) {
                    return Center(
                      child: Text(
                        snapshot.hasError
                            ? 'Failed to load student.'
                            : 'Student not found.',
                        style: TextStyle(
                          color: colors(context).secondaryText,
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  }

                  final data = snapshot.data!.data() ?? {};
                  _applyDocData(data);

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextField(
                              controller: _firstNameController,
                              labelText: 'First name',
                              hintText: 'Enter first name',
                              validator: (v) =>
                                  v == null || v.trim().isEmpty ? 'Required' : null,
                            ),
                            18.verticalSpace,
                            CommonTextField(
                              controller: _lastNameController,
                              labelText: 'Last name',
                              hintText: 'Enter last name',
                              validator: (v) =>
                                  v == null || v.trim().isEmpty ? 'Required' : null,
                            ),
                            18.verticalSpace,
                            CommonTextField(
                              controller: _phoneController,
                              labelText: 'Phone number',
                              hintText: 'Enter phone number',
                              keyboardType: TextInputType.phone,
                              validator: (v) =>
                                  v == null || v.trim().isEmpty ? 'Required' : null,
                            ),
                            18.verticalSpace,
                            CommonTextField(
                              controller: _emailController,
                              labelText: 'Email',
                              hintText: 'Enter email',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            18.verticalSpace,
                            CommonTextField(
                              controller: _idController,
                              labelText: 'Student ID',
                              hintText: 'Enter Student ID',
                              validator: (v) =>
                                  v == null || v.trim().isEmpty ? 'Required' : null,
                            ),
                            24.verticalSpace,
                            Text(
                              'Class group',
                              style: TextStyle(
                                color: colors(context).text,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            10.verticalSpace,
                            GroupDropdown(
                              selectedGroup: _selectedGroupName,
                              onChanged: (value) {
                                setState(() => _selectedGroupName = value);
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
                              text: 'Delete Student',
                              backgroundColor: Colors.red,
                              onPressed: _confirmDelete,
                            ),
                            24.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
