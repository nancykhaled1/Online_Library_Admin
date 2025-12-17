import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../Cubits/Notification/NotificationViewModel.dart';
import '../../Cubits/States/States.dart';
import '../../Utils/MyColors.dart';
import 'NotificationScreen.dart';


class NotificationDetailsScreen extends StatefulWidget {
  final String notificationId;
  static const String routeName = 'details';

  const NotificationDetailsScreen({Key? key, required this.notificationId})
    : super(key: key);

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationScreenViewModel>().getNotificationDetails(
      widget.notificationId,
    );



  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // هنا بتتحكمى هل ترجعى ولا لا
        return false; // ❌ مش هيرجع
        // return true;  ✅ هيرجع
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.whiteColor,
          appBar:AppBar(
            backgroundColor: MyColors.whiteColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: Text(
              'Notification',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: MyColors.blackColor,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => NotificationScreen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                BlocBuilder<NotificationScreenViewModel, States>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                              ),
                            ),
                          );
                        } else if (state is NotificationDetailsSuccessState) {
                          final details =
                              state.notificationDetails.notification ; // ده الريسبونس اللى جاي من الباك
                          final parsedDate =
                          DateTime.parse(details!.createdAt!).toLocal();
                          final formattedDate = DateFormat(
                            'HH:mm – dd/MM/yyyy',
                          ).format(parsedDate);



                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: MyColors.whiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: MyColors.greyColor.withOpacity(0.25),
                                  blurRadius: 15,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                      Text(
                                        details.title ?? '',
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.blackColor,
                                        ),
                                      ),

                                  SizedBox(height: 20.h),
                                  Text(
                                    details.body ?? '',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: MyColors.blackColor,
                                      height: 1.5.h,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Align(
                                    alignment: AlignmentGeometry.bottomRight,
                                    child: Text(
                                      formattedDate,
                                      style: TextStyle(
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w400,
                                        color: MyColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (state is ErrorState) {
                          final error = state.errorMessage;

                          if (error == "No Internet Connection") {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/noconnection.svg", // 🖼️ ضيفي صورة عندك
                                  width: 200.w,
                                  height: 200.h,
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "No internet connection",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: MyColors.greyColor,
                                    fontWeight: FontWeight.bold,
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
                        else {
                          return const SizedBox();
                        }
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
