import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_text_field.dart';

class AddAdminView extends ConsumerStatefulWidget {
  const AddAdminView({super.key});

  @override
  ConsumerState<AddAdminView> createState() => _AddAdminViewState();
}

class _AddAdminViewState extends ConsumerState<AddAdminView> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _roleController = TextEditingController();

  String? _username;
  String? _password;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Add Admin'),
      body: SafeArea(
        child: Padding(
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
                        v == null || v.trim().isEmpty ? 'First name required' : null,
                  ),
                  18.verticalSpace,
                  CommonTextField(
                    controller: _lastNameController,
                    labelText: 'Last name',
                    hintText: 'Enter last name',
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Last name required' : null,
                  ),
                  18.verticalSpace,
                  CommonTextField(
                    controller: _phoneController,
                    labelText: 'Phone number',
                    hintText: 'Enter phone number',
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Phone number required' : null,
                  ),
                  18.verticalSpace,
                  CommonTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Enter email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Email required' : null,
                  ),
                  18.verticalSpace,
                  CommonTextField(
                    controller: _roleController,
                    labelText: 'Role',
                    hintText: 'Enter role (e.g. Admin, Editor)',
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Role required' : null,
                  ),
                  24.verticalSpace,
                  CommonButton(
                    text: _username == null ? 'Create Login Details' : 'Edit Login Details',
                    onPressed: _showLoginDialog,
                  ),
                  if (_username != null && _password != null) ...[
                    16.verticalSpace,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: colors(context).secondarySurface,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: colors(context).secondarySurfaceBorder,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login details',
                            style: TextStyle(
                              color: colors(context).text,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          6.verticalSpace,
                          Text(
                            'Username: $_username',
                            style: TextStyle(
                              color: colors(context).text,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            'Password: $_password',
                            style: TextStyle(
                              color: colors(context).text,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  32.verticalSpace,
                  CommonButton(
                    text: 'Add',
                    isLoading: _isSubmitting,
                    onPressed: _onSubmit,
                  ),
                  24.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLoginDialog() {
    final usernameController =
        TextEditingController(text: _username ?? _emailController.text);
    final passwordController =
        TextEditingController(text: _password ?? 'Password@123');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors(context).surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 20.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create login',
                    style: TextStyle(
                      color: colors(context).text,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              18.verticalSpace,
              CommonTextField(
                controller: usernameController,
                labelText: 'Username',
                hintText: 'Enter username',
              ),
              18.verticalSpace,
              CommonTextField(
                controller: passwordController,
                labelText: 'Password',
                hintText: 'Enter password',
              ),
              24.verticalSpace,
              CommonButton(
                text: 'Save',
                onPressed: () {
                  setState(() {
                    _username = usernameController.text.trim();
                    _password = passwordController.text.trim();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_username == null || _password == null) {
      showDialog(
        context: context,
        builder: (_) => const AppDialog(
          title: 'Create login first',
          description: 'Please create login details before adding the admin.',
          alertType: AlertType.FAIL,
        ),
      );
      return;
    }

    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();
    final role = _roleController.text.trim();

    try {
      final auth = FirebaseAuth.instance;
      final credential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: _password!,
      );

      final uid = credential.user?.uid;
      if (uid == null) {
        throw Exception('Unable to create user');
      }

      await FirebaseFirestore.instance
          .collection('admins')
          .doc(uid)
          .set({
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phone,
        'role': role,
        'joined_date': DateTime.now().toIso8601String(),
        'profile_image': '',
        'uid': uid,
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AppDialog(
          title: 'Success',
          description: 'Admin added successfully.',
          alertType: AlertType.SUCCESS,
          positiveButtonText: 'Done',
          onPositiveCallback: () {
            Navigator.pop(context);
            Navigator.popUntil(
              context,
              ModalRoute.withName(Routes.kTutorManageAdminsView),
            );
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (_) => AppDialog(
          title: 'Failed',
          description:
              e.message ?? 'Unable to create admin account.',
          alertType: AlertType.FAIL,
        ),
      );
    } catch (_) {
      showDialog(
        context: context,
        builder: (_) => const AppDialog(
          title: 'Failed',
          description:
              'Something went wrong while adding the admin.',
          alertType: AlertType.FAIL,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
}
