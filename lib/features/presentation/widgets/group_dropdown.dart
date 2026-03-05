import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/theme_data.dart';

class GroupDropdown extends StatelessWidget {
  final String? selectedGroup;
  final ValueChanged<String?> onChanged;
  final bool showAllOption;

  const GroupDropdown({
    super.key,
    required this.selectedGroup,
    required this.onChanged,
    this.showAllOption = false,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('groups')
          .orderBy('group')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildContainer(
            context,
            child: Row(
              children: [
                SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
                8.horizontalSpace,
                Text(
                  'Loading groups...',
                  style: TextStyle(
                    color: colors(context).secondaryText,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return _buildContainer(
            context,
            child: Text(
              'Failed to load groups',
              style: TextStyle(
                color: colors(context).secondaryText,
                fontSize: 12.sp,
              ),
            ),
          );
        }

        final docs = snapshot.data?.docs ?? [];
        final groups = docs
            .map((d) => (d.data()['group'] ?? '').toString())
            .where((name) => name.isNotEmpty)
            .toList();

        if (groups.isEmpty) {
          return _buildContainer(
            context,
            child: Text(
              'No groups yet',
              style: TextStyle(
                color: colors(context).secondaryText,
                fontSize: 12.sp,
              ),
            ),
          );
        }

        const allSentinel = '__all__';

        String? effectiveValue = selectedGroup;
        if (effectiveValue == null) {
          effectiveValue =
              showAllOption ? allSentinel : groups.first;
        }

        final items = <DropdownMenuItem<String>>[];

        if (showAllOption) {
          items.add(
            DropdownMenuItem(
              value: allSentinel,
              child: const Text('All groups'),
            ),
          );
        }

        items.addAll(
          groups.map(
            (g) => DropdownMenuItem<String>(
              value: g,
              child: Text(g),
            ),
          ),
        );

        return _buildContainer(
          context,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: effectiveValue,
              isExpanded: true,
              items: items,
              onChanged: (value) {
                if (value == null) return;
                if (value == allSentinel) {
                  onChanged(null);
                } else {
                  onChanged(value);
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildContainer(BuildContext context,
      {required Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: colors(context).secondarySurfaceBorder,
        ),
      ),
      child: child,
    );
  }
}

