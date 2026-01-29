import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widgets/common_button.dart';
import '../../widgets/password_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1E88E5),
                    Color(0xFF0060DB),
                    Color(0xFF0A2643),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 53.w,
              top: 62.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Sign in !",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 179.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 700.h,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    color: colors(context).surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: 63.h),
                          Image.asset(AppAssets.appLogo, height: 78.h),
                          SizedBox(height: 50.h),
                          Text(
                            AppString.login,
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: const Color(0xFF2979FF),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            AppString.enterUserNamePassword,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14.sp),
                          ),
                          SizedBox(height: 41.h),
                          PasswordTextField(
                            controller: _usernameController,
                            label: 'Username',
                          ),
                          SizedBox(height: 40.h),
                          PasswordTextField(
                            controller: _passwordController,
                            label: 'Password',
                            obscureText: _obscure,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.kPhoneView);
                              },
                              child: const Text('Forgot password?'),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          CommonButton(text: 'Login', onPressed: () {
                            Navigator.pushNamed(context, Routes.kScanView);
                          }),
                          SizedBox(height: 113.h),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey[600],
                              ),
                              children: const <TextSpan>[
                                TextSpan(
                                  text:
                                  'By Sign in you Agree To Scribble 2 Scrabble`s\n',
                                ),
                                TextSpan(
                                  text: 'Terms And Conditions',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(text: ' Guideline And Our '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
