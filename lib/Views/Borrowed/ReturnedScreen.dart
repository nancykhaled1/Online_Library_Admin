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


class ReturnedScreen extends StatefulWidget{
  static const routeName = 'returned';

  const ReturnedScreen({super.key});

  @override
  State<ReturnedScreen> createState() => _ReturnedScreenState();
}

class _ReturnedScreenState extends State<ReturnedScreen> {

  @override
  void initState() {
    super.initState();
    context.read<BorrowCubit>().getBorrowBooks();

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // هنا بتتحكمى هل ترجعى ولا لا
        return false; // ❌ مش هيرجع
        // return true;  ✅ هيرجع
      },
      child: SafeArea(child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: AppBar(
          backgroundColor: MyColors.whiteColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            'Returned List',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: MyColors.blackColor
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ScanBorrowScreen(
                        scanType: ScanType.returnBook,
                      ),
                    ),
                  );

                },
                icon: Icon(Icons.qr_code_scanner,size: 30.sp,)
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 10.w
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your returned list',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: MyColors.blackColor
                ),
              ),
              SizedBox(height: 20.h),
              BlocBuilder<BorrowCubit, States>(
                builder: (context, state) {

                  if (state is LoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  else if (state is ErrorState) {
                    final error = state.errorMessage;

                    if (error == "No Internet Connection") {
                      return Column(
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
                    final returned = state.returned;
                    if (returned.isEmpty) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/nofound.png'),
                            SizedBox(height: 10.h,),
                            Text(
                              "No returned books yet!",
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: MyColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }


                    return Expanded(
                      child: ListView.separated(
                        reverse: true,

                        scrollDirection: Axis.vertical,
                        itemCount: returned.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: 10.h),
                        itemBuilder: (context, index) {
                          final returnedBook = returned[index];
                          return Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(14.r),
                              border: Border.all(
                                color: MyColors.outColor,
                              ),
                            ),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Container(
                                    padding: EdgeInsets.all(4.r),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(14.r),
                                      border: Border.all(
                                        color: MyColors.outColor,
                                      ),
                                    ),
                                    child: Image.network(
                                      returnedBook.book?.mainImage ?? '',
                                      height: 100.h,
                                      width: 70.w,
                                      //  fit: BoxFit.cover,

                                      // 🔄 Loader أثناء التحميل
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child; // الصورة اتحملت
                                        }
                                        return SizedBox(
                                          height: 100.h,
                                          width: 70.w,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: MyColors.primaryColor,
                                            ),
                                          ),
                                        );
                                      },

                                      // ❌ في حالة الخطأ
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(
                                          "assets/images/img.png",
                                          height: 100.h,
                                          width: 70.w,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text('${returnedBook.status}',
                                      style: TextStyle(
                                          color: MyColors.darkGreenColor,
                                          fontSize: 12.sp
                                      ),
                                    ),
                                    SizedBox(height: 4.h),

                                    Text(
                                      returnedBook.book?.name ??'',
                                      maxLines: 3,
                                      softWrap: true,        // يسمح بالانتقال للسطر الجديد
                                      // overflow: TextOverflow.ellipsis, // يظهر النص بالكامل
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: MyColors.blackColor),

                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      returnedBook.book?.publisher ??'',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.greyColor),

                                    ),
                                    SizedBox(height: 10.h),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Returned in',
                                          style: TextStyle(
                                              color: MyColors.greyColor,
                                              fontSize: 12.sp
                                          ),
                                        ),
                                        SizedBox(height: 4.h),

                                        Text('${returnedBook.returnDate}',
                                          style: TextStyle(
                                              color: MyColors.blackColor,
                                              fontSize: 15.sp
                                          ),
                                        ),

                                      ],
                                    ),

                                    SizedBox(height: 10.h),

                                    Container(
                                      padding: EdgeInsets.all(8.r),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(14.r),

                                          color: MyColors.softColor
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 10.r,
                                            backgroundColor: MyColors.whiteColor,
                                            child: ClipOval(
                                              child: (returnedBook.user?.photo != null && returnedBook.user!.photo!.startsWith("http"))
                                                  ? Image.network(
                                                returnedBook.user!.photo!,
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
                                          Text(returnedBook.user?.name ??'',
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




                              ],
                            ),
                          );
                        },
                      ),
                    );

                  }
                  return Container();
                },
              ),

            ],
          ),
        ),

      )),
    );
  }
}