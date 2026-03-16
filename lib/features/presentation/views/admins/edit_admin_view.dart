import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/enums.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_text_field.dart';

class EditAdminView extends StatefulWidget {
  const EditAdminView({super.key});

  @override
  State<EditAdminView> createState() => _EditAdminViewState();
}

class _EditAdminViewState extends State<EditAdminView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _roleController = TextEditingController();

  bool _isSaving = false;
  bool _initialized = false;

  String get _adminDocId {
    final args = ModalRoute.of(context)?.settings.arguments;
    return args is String ? args : '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  void _applyDocData(Map<String, dynamic> data) {
    if (_initialized) return;
    _initialized = true;
    _firstNameController.text = (data['first_name'] ?? '').toString();
    _lastNameController.text = (data['last_name'] ?? '').toString();
    _phoneController.text = (data['phone_number'] ?? '').toString();
    _emailController.text = (data['email'] ?? '').toString();
    _roleController.text = (data['role'] ?? '').toString();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isSaving) return;

    setState(() => _isSaving = true);

    try {
      await FirebaseFirestore.instance.collection('admins').doc(_adminDocId).update({
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'phone_number': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
        'role': _roleController.text.trim(),
      });

      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AppDialog(
          title: 'Success',
          description: 'Admin updated successfully.',
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
          description: 'Unable to update admin. Please try again.',
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
        description: 'Are you sure you want to delete this admin?',
        alertType: AlertType.FAIL,
        positiveButtonText: 'Delete',
        negativeButtonText: 'Cancel',
        onPositiveCallback: () async {
          try {
            await FirebaseFirestore.instance
                .collection('admins')
                .doc(_adminDocId)
                .delete();
            if (!context.mounted) return;
            Navigator.pop(context); // close confirm dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AppDialog(
                title: 'Success',
                description: 'Admin deleted successfully.',
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
                description: 'Unable to delete the admin. Please try again.',
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
      appBar: const CommonAppBar(title: 'Edit Admin'),
      body: SafeArea(
        child: _adminDocId.isEmpty
            ? Center(
                child: Text(
                  'Invalid admin.',
                  style: TextStyle(
                    color: colors(context).secondaryText,
                    fontSize: 14.sp,
                  ),
                ),
              )
            : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('admins')
                    .doc(_adminDocId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || !snapshot.data!.exists) {
                    return Center(
                      child: Text(
                        snapshot.hasError
                            ? 'Failed to load admin.'
                            : 'Admin not found.',
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
                              validator: (v) =>
                                  v == null || v.trim().isEmpty ? 'Required' : null,
                            ),
                            18.verticalSpace,
                            CommonTextField(
                              controller: _roleController,
                              labelText: 'Role',
                              hintText: 'Enter Role',
                              validator: (v) =>
                                  v == null || v.trim().isEmpty ? 'Required' : null,
                            ),
                            32.verticalSpace,
                            CommonButton(
                              text: 'Save',
                              isLoading: _isSaving,
                              onPressed: _save,
                            ),
                            16.verticalSpace,
                            CommonButton(
                              text: 'Delete Admin',
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
