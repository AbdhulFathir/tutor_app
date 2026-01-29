import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_app/features/presentation/views/materials/widgets/material_card.dart';
import '../home/widgets/course.dart';

class MaterialCarousel extends StatefulWidget {
  final List<Course> courses;

  const MaterialCarousel({super.key, required this.courses});

  @override
  State<MaterialCarousel> createState() => _MaterialCarouselState();
}

class _MaterialCarouselState extends State<MaterialCarousel> {
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    _controller = PageController(viewportFraction: .80);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 175.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.courses.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double scale = 1.0;
                  if (_controller.position.haveDimensions) {
                    double pageOffset = _controller.page! - index;
                    scale = (1 - (pageOffset.abs() * 0.1)).clamp(0.9, 1.0);
                  }
                  return Transform.scale(
                    scale: scale,
                    child: Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: MaterialCard(course: widget.courses[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Indicator
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.courses.length, (index) {
            bool isActive = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: isActive ? 16.w : 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF2979FF) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        ),
      ],
    );
  }
}
