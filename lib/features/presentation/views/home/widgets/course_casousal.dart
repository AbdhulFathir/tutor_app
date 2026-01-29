import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'course.dart';
import 'course_card.dart';

class CoursesCarousel extends StatefulWidget {
  final List<Course> courses;

  const CoursesCarousel({super.key, required this.courses});

  @override
  State<CoursesCarousel> createState() => _CoursesCarouselState();
}

class _CoursesCarouselState extends State<CoursesCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.75);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.courses.length,
            onPageChanged: (i) => setState(() => currentIndex = i),
            itemBuilder: (_, index) =>
                CourseCard(course: widget.courses[index]),
          ),
        ),

        10.verticalSpace,

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.courses.length, (index) {
            final active = index == currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(left: 3.w),
              height: 6.h,
              width: active ? 18.w : 6.w,
              decoration: BoxDecoration(
                color: active ? const Color(0xFF2979FF) : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(12.r),
              ),
            );
          }),
        ),
      ],
    );
  }
}

