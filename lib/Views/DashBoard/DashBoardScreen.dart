import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_library_management/Utils/MyColors.dart';
import 'package:online_library_management/Views/Borrowed/Late&PendingScreen.dart';
import 'package:online_library_management/Views/Drawer/DrawerScreen.dart';
import '../../Cubits/Borrowed/BorrowedViewModel.dart';
import '../../Cubits/Library/BookViewModel.dart';
import '../../Cubits/Library/CategoryViewModel.dart';
import '../../Cubits/States/States.dart';
import '../Borrowed/scannerScreen.dart';
import '../Library/AddBookScreen.dart';
import 'ChartScreen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BorrowCubit>().getBorrowBooks();

  }
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CategoryCubit>();
    // لو البيانات لسه ما اتجلبتش، استدعي loadHomeData
    if (viewModel.books.isEmpty) {
      viewModel.loadHomeData();
    }

    return WillPopScope(
      onWillPop: () async {
        // هنا بتتحكمى هل ترجعى ولا لا
        return false; // ❌ مش هيرجع
        // return true;  ✅ هيرجع
      },
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            'DashBoard',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: MyColors.blackColor
            ),
          ),
          centerTitle: true,
          backgroundColor: MyColors.whiteColor,
          actions: [
            Image.asset('assets/images/logo2.png',
              width: 40.w,
              height: 40.h,
            )
          ],
        ),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                Column(
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
                              BlocBuilder<CategoryCubit, States>(
                                builder: (context, state) {
                                  int totalBooks = viewModel.books.length;

                                  if (state is LoadingState) {
                                    return Center(child: CircularProgressIndicator(color: MyColors.whiteColor,));
                                  }

                                  return Text(
                                    "$totalBooks",
                                    style:  TextStyle(
                                      color: MyColors.whiteColor,
                                      fontSize: 36.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },



                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // كونتينر ثاني
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ScanBorrowScreen(
                                      scanType: ScanType.borrow,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(20.r),
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: MyColors.orangeColor.withOpacity(0.4),
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      )
                                    ],
                                    border: Border.all(color: MyColors.darkOrangeColor)
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.qr_code_scanner, size: 40.sp, color: MyColors.blackColor,),
                                    SizedBox(height: 10.h),
                                    Text(
                                      "Scan borrow",
                                      style: TextStyle(
                                        color: MyColors.blackColor,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ScanBorrowScreen(
                                      scanType: ScanType.returnBook,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(20.r),
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: MyColors.greenColor.withOpacity(0.4),
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      )
                                    ],
                                    border: Border.all(color: MyColors.darkGreenColor)
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.qr_code_scanner, size: 40.sp, color: MyColors.blackColor,),
                                    SizedBox(height: 10.h),
                                    Text(
                                      "Scan return",
                                      style: TextStyle(
                                        color: MyColors.blackColor,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 20.h),

                        GestureDetector(
                          onTap: (){
                            context.read<BookCubit>().clearForm(); // ⭐ مهم جدًا

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddNewBookScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.r),
                            decoration: BoxDecoration(
                                color: MyColors.whiteColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: MyColors.inputColor.withOpacity(0.4),
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                                border: Border.all(color: MyColors.primaryColor)
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.add, size: 40.sp, color: MyColors.blackColor,),
                                SizedBox(height: 10.h),
                                Text(
                                  "Add Book",
                                  style: TextStyle(
                                    color: MyColors.blackColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                SizedBox(height: 20.h),

                BlocBuilder<BorrowCubit, States>(
                  builder: (context, state) {
                    if (state is GetBorrowBooksSuccessState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Summary",
                          style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700
                          ),
                          ),
                          BorrowSummaryPieChart(
                            borrowed: state.borrow.length,
                            returned: state.returned.length,
                            late: state.late.length,
                            pending: state.pending.length,
                          ),
                        ],
                      );
                    }
                    if (state is LoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }


                    return SizedBox();
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
