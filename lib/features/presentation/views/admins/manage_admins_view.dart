import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../widgets/app_search_box.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/app_dialog.dart';

class ManageAdminsView extends ConsumerStatefulWidget {
  const ManageAdminsView({super.key});

  @override
  ConsumerState<ManageAdminsView> createState() => _ManageAdminsViewState();
}

class _ManageAdminsViewState extends ConsumerState<ManageAdminsView> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: CommonAppBar(
        title: 'Manage Admins',
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1_rounded),
            onPressed: () {
              Navigator.pushNamed(context, Routes.kTutorAddAdminView);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              AppSearchBox(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _query = value.trim();
                  });
                },
              ),
              20.verticalSpace,
              _buildHeaderRow(context),
              8.verticalSpace,
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('admins')
                      .orderBy('first_name')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Failed to load admins.',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 13.sp,
                          ),
                        ),
                      );
                    }

                    final docs = snapshot.data?.docs ?? [];

                    final items = docs.map((doc) {
                      final data = doc.data();
                      return _AdminListItem(
                        docId: doc.id,
                        fullName:
                            '${data['first_name'] ?? ''} ${data['last_name'] ?? ''}'
                                .trim(),
                        role: (data['role'] ?? '').toString(),
                        phone: (data['phone_number'] ?? '').toString(),
                        email: (data['email'] ?? '').toString(),
                        uid: (data['uid'] ?? '').toString(),
                        joinedDate: (data['joined_date'] ?? '').toString(),
                      );
                    }).where((item) {
                      if (_query.isEmpty) return true;
                      final q = _query.toLowerCase();
                      return item.fullName.toLowerCase().contains(q) ||
                          item.role.toLowerCase().contains(q) ||
                          item.email.toLowerCase().contains(q);
                    }).toList();

                    if (items.isEmpty) {
                      return Center(
                        child: Text(
                          'No admins yet. Tap the + icon to add.',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 13.sp,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => 8.verticalSpace,
                      itemBuilder: (context, index) {
                        final admin = items[index];
                        return _buildAdminRow(context, admin);
                      },
                    );
                  },
                ),
              ),
              16.verticalSpace,
              CommonButton(
                text: 'Add Admin',
                onPressed: () {
                  Navigator.pushNamed(context, Routes.kTutorAddAdminView);
                },
              ),
              8.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    final labelStyle = TextStyle(
      color: colors(context).secondaryText,
      fontSize: 11.sp,
      fontWeight: FontWeight.w500,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors(context).secondarySurfaceBorder),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('Name', style: labelStyle)),
          Expanded(flex: 2, child: Text('Role', style: labelStyle)),
          Expanded(
            flex: 2,
            child: Text(
              'Action',
              style: labelStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminRow(BuildContext context, _AdminListItem admin) {
    final textStyle = TextStyle(
      color: colors(context).text,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors(context).secondarySurfaceBorder),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(admin.fullName, style: textStyle)),
          Expanded(flex: 2, child: Text(admin.role, style: textStyle)),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _showAdminDetails(context, admin);
                },
                child: const Text('View'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAdminDetails(BuildContext context, _AdminListItem admin) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Admin Details',
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
              8.verticalSpace,
              _detailRow(context, 'Name', admin.fullName),
              _detailRow(context, 'Role', admin.role),
              _detailRow(context, 'Phone', admin.phone),
              _detailRow(context, 'Email', admin.email),
              _detailRow(
                context,
                'Joined',
                AppUtils.getDate(admin.joinedDate),
              ),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      text: 'Edit',
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          Routes.kTutorEditAdminView,
                          arguments: admin.docId,
                        );
                      },
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: colors(context).secondarySurfaceBorder,
                        ),
                      ),
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _detailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90.w,
            child: Text(
              label,
              style: TextStyle(
                color: colors(context).secondaryText,
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: colors(context).text,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminListItem {
  final String docId;
  final String fullName;
  final String role;
  final String phone;
  final String email;
  final String uid;
  final String joinedDate;

  _AdminListItem({
    required this.docId,
    required this.fullName,
    required this.role,
    required this.phone,
    required this.email,
    required this.uid,
    required this.joinedDate,
  });
}
