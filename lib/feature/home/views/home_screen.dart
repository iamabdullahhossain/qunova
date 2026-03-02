import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qunova/feature/home/controller/home_controller.dart';
import 'package:qunova/feature/home/views/sections/category_section.dart';
import 'package:qunova/feature/home/views/sections/contacts_section.dart';
import 'package:qunova/feature/home/views/sections/top_bar_section.dart';
import 'package:qunova/gen/assets.gen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String? selectedRelation;
  String selectedCategoryId = 'all';

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(homeControllerProvider);

    final List<String> relations = (data.asData?.value.data?.categories ?? [])
        .map((e) => e.name.toString())
        .toList();

    Widget _buildTextField({required String hint}) {
      return TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.blueGrey.shade300),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 14.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.blue.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Color(0xFF2D7E66)),
          ),
        ),
      );
    }

    void _showBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20.w,
              right: 20.w,
              top: 10.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  SizedBox(height: 25.h),

                  _buildTextField(hint: 'Name'),
                  SizedBox(height: 12.h),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade50),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          '🇺🇸',
                          style: TextStyle(fontSize: 20),
                        ), // Flag
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: 8.w),
                        const VerticalDivider(width: 1),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: '+880  01812 432 654',
                              hintStyle: TextStyle(
                                color: Colors.blueGrey.shade300,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  _buildTextField(hint: 'Designation'),
                  SizedBox(height: 12.h),

                  _buildTextField(hint: 'Company'),
                  SizedBox(height: 12.h),

                  DropdownButtonFormField<String>(
                    initialValue: selectedRelation,
                    hint: Text(
                      'Relation',
                      style: TextStyle(
                        color: Colors.blueGrey.shade300,
                        fontSize: 14.sp,
                      ),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey.shade600,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 14.h,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.blue.shade50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0xFF2D7E66)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: relations.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 14.sp)),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedRelation = newValue;
                      });
                    },
                  ),

                  SizedBox(height: 30.h),

                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D7E66),

                        shape: const StadiumBorder(),
                        elevation: 0,
                      ),
                      child: Text(
                        'Save Contact',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      );
    }

    // prepare filtered contacts based on selectedCategoryId
    final allContacts = data.asData?.value.data?.contacts ?? [];
    final filteredContacts = selectedCategoryId == 'all'
        ? allContacts
        : allContacts.where((c) => c.categoryId == selectedCategoryId).toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: InkWell(
        onTap: () {
          _showBottomSheet(context);
        },
        child: Image.asset(
          Assets.png.floatingIcon.path,
          width: 80.w,
          height: 80.h,
        ),
      ),
      body: SafeArea(
        child: data.when(
          data: (data) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarSection(),
              CategorySection(
                category: data.data?.categories ?? [],
                selectedCategoryId: selectedCategoryId,
                onCategorySelected: (id) {
                  setState(() {
                    selectedCategoryId = id ?? 'all';
                  });
                },
              ),
              const SizedBox(height: 10),
              Expanded(child: ContactsSection(contacts: filteredContacts)),
            ],
          ),
          error: (error, stackTracer) => Text("Something went wrong"),
          loading: () => Center(
            child: CircularProgressIndicator(color: const Color(0xFF2E7D67)),
          ),
        ),
      ),
    );
  }
}
