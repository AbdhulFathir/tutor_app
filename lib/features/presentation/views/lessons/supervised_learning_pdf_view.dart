import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_data.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../../../utils/app_assets.dart';

class SupervisedLearningPdfView extends StatefulWidget {
  const SupervisedLearningPdfView({super.key});

  @override
  State<SupervisedLearningPdfView> createState() => _SupervisedLearningPdfViewState();
}

class _SupervisedLearningPdfViewState extends State<SupervisedLearningPdfView> {
  int _rating = 0;
  final TextEditingController _suggestionController = TextEditingController();
  String _selectedFileType = 'PDF Standard';
  String _selectedPageSize = 'A4';
  bool _saveDownloadSettings = false;

  @override
  void dispose() {
    _suggestionController.dispose();
    super.dispose();
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Container(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rate your experience with us!',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: colors(context).text,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _rating = index + 1;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Icon(
                              index < _rating ? Icons.star : Icons.star_border,
                              color: index < _rating
                                  ? Colors.amber
                                  : colors(context).text.withOpacity(0.3),
                              size: 32.sp,
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 24.h),
                    TextField(
                      controller: _suggestionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Any other Suggestions?',
                        labelStyle: TextStyle(
                          color: colors(context).secondaryText,
                          fontSize: 14.sp,
                        ),
                        filled: true,
                        fillColor: colors(context).secondarySurface,
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
                            color: Colors.blue.withOpacity(0.7),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CommonButton(
                      text: 'Submit',
                      onPressed: () {
                        Navigator.pop(context);
                        _showSubmittedDialog();
                      },
                      isFullWidth: true,
                      backgroundColor: const Color(0xFF2979FF),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showSubmittedDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            padding: EdgeInsets.all(32.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Submitted',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: colors(context).text,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Thanks for rating us!',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: colors(context).secondaryText,
                  ),
                ),
                SizedBox(height: 24.h),
                CommonButton(
                  text: 'Done',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isFullWidth: true,
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDownloadDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Container(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Download',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: colors(context).text,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    DropdownButtonFormField<String>(
                      value: _selectedFileType,
                      decoration: InputDecoration(
                        labelText: 'File Type',
                        labelStyle: TextStyle(
                          color: colors(context).secondaryText,
                          fontSize: 14.sp,
                        ),
                        filled: true,
                        fillColor: colors(context).secondarySurface,
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
                            color: Colors.blue.withOpacity(0.7),
                            width: 2,
                          ),
                        ),
                      ),
                      items: ['PDF Standard', 'PDF/A', 'PDF/X'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedFileType = newValue;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    DropdownButtonFormField<String>(
                      value: _selectedPageSize,
                      decoration: InputDecoration(
                        labelText: 'Page Size',
                        labelStyle: TextStyle(
                          color: colors(context).secondaryText,
                          fontSize: 14.sp,
                        ),
                        filled: true,
                        fillColor: colors(context).secondarySurface,
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
                            color: Colors.blue.withOpacity(0.7),
                            width: 2,
                          ),
                        ),
                      ),
                      items: ['A4', 'Letter', 'Legal', 'A3'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedPageSize = newValue;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Checkbox(
                          value: _saveDownloadSettings,
                          onChanged: (bool? value) {
                            setState(() {
                              _saveDownloadSettings = value ?? false;
                            });
                          },
                          activeColor: const Color(0xFF2979FF),
                        ),
                        Text(
                          'Save Download Settings',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: colors(context).text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    CommonButton(
                      text: 'Download',
                      onPressed: () {
                        Navigator.pop(context);
                        _showDownloadCompletedDialog();
                      },
                      isFullWidth: true,
                      backgroundColor: const Color(0xFF2979FF),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDownloadCompletedDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            padding: EdgeInsets.all(32.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Completed',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: colors(context).text,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Pdf downloaded successfully!',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: colors(context).secondaryText,
                  ),
                ),
                SizedBox(height: 24.h),
                CommonButton(
                  text: 'Done',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isFullWidth: true,
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: CommonAppBar(
        title: 'Supervised Learning PDF',
        showNotificationIcon: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured Image
                    Container(
                      width: double.infinity,
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: colors(context).surface.withOpacity(0.1),
                      ),
                      child: Center(
                        child: Image.asset(
                          AppAssets.machineLearning,
                          height: 100.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Supervised Learning',
                            style: TextStyle(
                              color: colors(context).text,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            'Supervised learning is a machine learning approach where algorithms learn from labeled training data. The model makes predictions or decisions based on input-output pairs, learning to map inputs to correct outputs through examples.',
                            style: TextStyle(
                              color: colors(context).text.withOpacity(0.8),
                              fontSize: 14.sp,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 32.h),
                          Text(
                            'What is labeled data?',
                            style: TextStyle(
                              color: colors(context).text,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Labeled data consists of input-output pairs where each input (feature) is associated with a known output (label or target). For example, in image classification, labeled data would be images paired with their correct categories (e.g., "cat", "dog", "bird").',
                            style: TextStyle(
                              color: colors(context).text.withOpacity(0.8),
                              fontSize: 14.sp,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            'How it works (simple)',
                            style: TextStyle(
                              color: colors(context).text,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            '1. Training Phase: The algorithm is fed labeled training data.\n'
                            '2. Learning: It identifies patterns and relationships between inputs and outputs.\n'
                            '3. Model Creation: A mathematical model is built that can make predictions.\n'
                            '4. Testing: The model is tested on unseen data to evaluate its accuracy.\n'
                            '5. Prediction: Once trained, the model can predict outputs for new, unlabeled inputs.',
                            style: TextStyle(
                              color: colors(context).text.withOpacity(0.8),
                              fontSize: 14.sp,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            'Types of Supervised Learning',
                            style: TextStyle(
                              color: colors(context).text,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            '1. Classification',
                            style: TextStyle(
                              color: colors(context).text,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '• Predicts discrete categories or classes',
                                  style: TextStyle(
                                    color: colors(context).text.withOpacity(0.8),
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  ),
                                ),
                                Text(
                                  '• Examples: Email spam detection, image recognition, medical diagnosis',
                                  style: TextStyle(
                                    color: colors(context).text.withOpacity(0.8),
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            '2. Regression',
                            style: TextStyle(
                              color: colors(context).text,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '• Predicts continuous numerical values',
                                  style: TextStyle(
                                    color: colors(context).text.withOpacity(0.8),
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  ),
                                ),
                                Text(
                                  '• Examples: House price prediction, temperature forecasting, stock market analysis',
                                  style: TextStyle(
                                    color: colors(context).text.withOpacity(0.8),
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Footer with buttons
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: colors(context).surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      text: 'Mark as Completed',
                      onPressed: () {
                        _showRatingDialog();
                      },
                      isFullWidth: true,
                      backgroundColor: colors(context).secondarySurface,
                      textColor: colors(context).text,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CommonButton(
                      text: 'Download',
                      onPressed: () {
                        _showDownloadDialog();
                      },
                      isFullWidth: true,
                      backgroundColor: const Color(0xFF2979FF),
                      image: AppAssets.iconUploadFileFill,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


