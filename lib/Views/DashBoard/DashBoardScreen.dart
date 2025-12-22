import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_library_management/Utils/MyColors.dart';
import 'package:online_library_management/Views/Drawer/DrawerScreen.dart';
import '../../Cubits/Library/CategoryViewModel.dart';
import '../../Cubits/States/States.dart';

class BooksSummaryScreen extends StatelessWidget {
  const BooksSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CategoryCubit>();
    // لو البيانات لسه ما اتجلبتش، استدعي loadHomeData
    if (viewModel.books.isEmpty) {
      viewModel.loadHomeData();
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: BlocBuilder<CategoryCubit, States>(
          builder: (context, state) {
            int totalBooks = viewModel.books.length;

            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                // الكونتينر الأزرق
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient:  LinearGradient(
                      colors: [MyColors.primaryColor, MyColors.inputColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        "Total Books",
                        style: TextStyle(
                          color: MyColors.whiteColor,
                          fontSize: 16.sp,
                        ),
                      ),
                       SizedBox(height: 10.h),
                      Text(
                        "$totalBooks",
                        style:  TextStyle(
                          color: MyColors.whiteColor,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                // كونتينر ثاني
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: MyColors.darkOrangeColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.add, size: 30.sp, color: MyColors.whiteColor,),
                      SizedBox(height: 20.h),
                      Text(
                        "Add Book",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
