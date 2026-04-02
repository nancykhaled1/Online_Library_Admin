import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../Cubits/Notification/NotificationViewModel.dart';
import '../../Cubits/States/States.dart';
import '../../Utils/MyColors.dart';
import '../Drawer/DrawerScreen.dart';
import 'AddNotificationSheet.dart';
import 'NotificationDetails.dart';
import 'notification_card.dart';


class NotificationScreen extends StatefulWidget {
  static const String routeName = 'notification';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationScreenViewModel>().getNotification();

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // هنا بتتحكمى هل ترجعى ولا لا
          return false; // ❌ مش هيرجع
          // return true;  ✅ هيرجع
        },
        child: Scaffold(
          backgroundColor: MyColors.whiteColor,
          appBar:AppBar(
            backgroundColor: MyColors.whiteColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: Text(
              'Notifications',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: MyColors.blackColor,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    addNotificationBottomSheet(context: context,
                      buttonText: 'Add',
                      onPressed: (value) {

                        context.read<NotificationScreenViewModel>().addNotification();
                      },


                    );
                  },
                  icon:Icon(Icons.add,color: MyColors.primaryColor,size: 25.sp)),
            ],
          ),
          drawer: AppDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // BlocBuilder لمتابعة الـ state
              Expanded(
                child: BlocBuilder<NotificationScreenViewModel, States>(
                  builder: (context, state) {

                    if (state is LoadingState) {
                      return Center(
                        child: CircularProgressIndicator(
                        ),
                      );
                    }
                    else if (state is ErrorState) {
                      final error = state.errorMessage;

                      if (error == "No Internet Connection") {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                "assets/images/noconnection.svg", // 🖼️ ضيفي صورة عندك
                                width: 200,
                                height: 200,
                              ),
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
                    else if (state is GetNotificationSuccessState) {
                      final notifications = state.notifications;

                      if (notifications.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/notification-slash.svg',
                                  // width: 238,
                                  // height: 238,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text('no notifications yet',
                                  style: TextStyle(
                                    color: MyColors.greyColor,
                                    fontFamily: "Noto Kufi Arabic",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24.sp ,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notif = notifications[index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => NotificationDetailsScreen(notificationId: notif.id ??'',),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            child: NotificationCard(
                              title: notif.title ?? "",
                              body: notif.body ?? "",
                              date: notif.createdAt ??'',
                              id: notif.id!
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
