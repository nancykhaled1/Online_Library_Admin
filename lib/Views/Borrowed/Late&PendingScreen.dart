import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_library_management/Cubits/Library/BookViewModel.dart';
import 'package:online_library_management/Utils/MyColors.dart';
import 'package:online_library_management/Views/Borrowed/scannerScreen.dart';
import 'package:online_library_management/Views/Drawer/DrawerScreen.dart';
import '../../Cubits/Borrowed/BorrowedViewModel.dart';
import '../../Cubits/States/States.dart';


class LatePendingScreen extends StatefulWidget {
  static const routeName = 'late_pending';

  const LatePendingScreen({super.key});

  @override
  State<LatePendingScreen> createState() => _LatePendingScreenState();
}

class _LatePendingScreenState extends State<LatePendingScreen> {

  @override
  void initState() {
    super.initState();
    context.read<BorrowCubit>().getBorrowBooks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: AppBar(
          backgroundColor: MyColors.whiteColor,
          elevation: 0,
          title: Text(
            'Late & Pending',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              color: MyColors.blackColor,
            ),
          ),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: BlocBuilder<BorrowCubit, States>(
            builder: (context, state) {

              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              else if (state is ErrorState) {
                final error = state.errorMessage;

                if (error == "No Internet Connection") {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/noconnection.svg", // 🖼️ ضيفي صورة عندك
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "No internet connection",
                          style: TextStyle(
                            fontSize: 18,
                            color: MyColors.greyColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Noto Kufi Arabic",
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Please, Try again later",
                      style: TextStyle(
                        color: MyColors.greyColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                }

              }

              if (state is GetBorrowBooksSuccessState) {
                final late = state.late;
                final pending = state.pending;

                if (late.isEmpty && pending.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/nofound.png'),
                        SizedBox(height: 10.h),
                        Text(
                          "No late or pending books",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView(
                  children: [

                    /// 🔴 Late Section
                    if (late.isNotEmpty) ...[
                      _sectionTitle("Late Books"),
                      ...late.reversed.map(
                            (borrowed) => _borrowItem(borrowed),
                      ),
                    ],

                    SizedBox(height: 20.h),

                    /// 🟠 Pending Section
                    if (pending.isNotEmpty) ...[
                      _sectionTitle("Pending Books"),
                      ...pending.reversed.map(
                            (borrowed) => _borrowItem(borrowed),
                      ),
                    ],
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  /// عنوان السيكشن
  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: MyColors.blackColor,
        ),
      ),
    );
  }

  /// عنصر الكتاب
  Widget _borrowItem(dynamic borrowed) {
    final imageUrl = borrowed.book?.mainImage ??'';
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: MyColors.outColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(
              imageUrl,
              height: 100.h,
              width: 70.w,
              errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _buildImagePlaceholder();
              },
            )
                : _buildImagePlaceholder(),

            // Image.network(
            //   borrowed.book?.mainImage ?? '',
            //   height: 100.h,
            //   width: 70.w,
            //   errorBuilder: (_, __, ___) => Image.asset(
            //     "assets/images/img.png",
            //     height: 100.h,
            //     width: 70.w,
            //   ),
            //   loadingBuilder: (context, child, loadingProgress) {
            //     if (loadingProgress == null) {
            //       return child; // الصورة اتحملت
            //     }
            //     return SizedBox(
            //       height: 100.h,
            //       width: 70.w,
            //       child: Center(
            //         child: CircularProgressIndicator(
            //           strokeWidth: 2,
            //           color: MyColors.primaryColor,
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (borrowed.status == 'late') ...[
                  Text(
                    "${borrowed.status} for ${borrowed.daysLate} days",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.sp,
                    ),
                  ),
                ] else ...[
                  Text(
                    "${borrowed.status}",
                    style: TextStyle(
                      color: MyColors.inputColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],

                SizedBox(height: 4.h),
                Text(
                  borrowed.book?.name ?? 'no name',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  borrowed.book?.publisher ?? 'no publisher',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: MyColors.greyColor,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Return date: ${borrowed.mustReturnDate}",
                  style: TextStyle(fontSize: 12.sp),
                ),

                SizedBox(height: 10.h),

                Container(

                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(14.r),

                      color: MyColors.softColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10.r,
                            backgroundColor: MyColors.whiteColor,
                            child: ClipOval(
                              child: (borrowed.user?.photo != null && borrowed.user!.photo!.startsWith("http"))
                                  ? Image.network(
                                borrowed.user!.photo!,
                                key: UniqueKey(),
                                fit: BoxFit.cover,
                                width: 100.w,
                                height: 100.h,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/personalImage.png',
                                    fit: BoxFit.cover,
                                    width: 100.w,
                                    height: 100.h,
                                  );
                                },
                              )
                                  : Image.asset(
                                'assets/images/personalImage.png',
                                fit: BoxFit.cover,
                                width: 100.w,
                                height: 100.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w,),
                          Text(borrowed.user?.name ??'',
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 12.sp
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 5.h,),
                      Text(borrowed.user?.phone ??'',
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 12.sp
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
    );
  }
  Widget _buildImagePlaceholder() {
    return Container(
      width: 70.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Icon(
        Icons.image_not_supported,
        size: 40,
        color: Colors.grey[500],
      ),
    );
  }

}
