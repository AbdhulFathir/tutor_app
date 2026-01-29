import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_app/features/presentation/views/profile/widgets/settings_container.dart';
import '../../../../core/theme/theme_data.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_text_field.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController _userNameController = TextEditingController(text: 'Smitu');
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(text: 'smitu@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: '••••••••');
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: CommonAppBar(
        title: 'Edit profile',
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: colors(context).text,
            ),
            onPressed: () {
              // Handle save
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 11.w),
            child: Column(
              children: [
                SizedBox(height: 32.h),
                Stack(
                  children: [
                    Container(
                      width: 83.w,
                      height: 83.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      child: ClipOval(
                        child:
                        Image.network(
                          "https://picsum.photos/200/300.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 25.w,
                        height: 25.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:  Colors.black,
                          border: Border.all(
                            color: colors(context).text,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11.h),
                Text(
                  'Change profile picture',
                  style: TextStyle(
                    color: colors(context).text.withValues( alpha:0.6),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 40.h),
                SettingsContainer(
                  widget: Column(
                    children: [
                      CommonTextField(
                        controller: _userNameController,
                        labelText: 'User name',
                        suffixIcon: Icon(
                          Icons.edit,
                          size: 18.sp,
                          color: colors(context).text.withValues( alpha:0.5),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CommonTextField(
                        controller: _phoneController,
                        labelText: 'Phone number',
                        keyboardType: TextInputType.phone,
                        suffixIcon: Icon(
                          Icons.edit,
                          size: 18.sp,
                          color: colors(context).text.withValues( alpha:0.5),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CommonTextField(
                        controller: _emailController,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: Icon(
                          Icons.edit,
                          size: 18.sp,
                          color: colors(context).text.withValues( alpha:0.5),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CommonTextField(
                        controller: _passwordController,
                        labelText: 'Password',
                        obscureText: true,
                        suffixIcon: Icon(
                          Icons.edit,
                          size: 18.sp,
                          color: colors(context).text.withValues( alpha:0.5),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CommonTextField(
                        controller: _addressController,
                        labelText: 'Address',
                        maxLines: 2,
                        suffixIcon: Icon(
                          Icons.edit,
                          size: 18.sp,
                          color: colors(context).text.withValues( alpha:0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

