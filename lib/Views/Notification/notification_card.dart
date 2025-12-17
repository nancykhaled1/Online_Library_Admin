import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:online_library_management/Cubits/Notification/NotificationViewModel.dart';

import '../../Utils/CommenConfirmSheet.dart';
import '../../Utils/MyColors.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final String date;
  final String id;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.body,
    required this.date,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // حاولنا نعمل فورمات للتاريخ لو اتبعت صح من الـ API

    final DateTime parsedDate = DateTime.parse(date ).toLocal();
    final String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    final String formattedTime = DateFormat('HH:mm').format(parsedDate);

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 10.w
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
                color: MyColors.softGreyColor,
                borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: MyColors.outColor,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1, // 👈 ياخد سطر واحد بس
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: MyColors.blackColor,
                        ),
                      ),
                    ),
                  IconButton(
                      onPressed: (){
                        showCommonBottomSheet(
                          context: context,
                          imagePath: 'assets/images/deleteImage.png',
                          title: 'Delete this category?',
                          description:
                          'You sure you want to delete this category!',
                          primaryButtonText: 'Yes, Delete',
                          onPrimaryPressed: () async {
                            Navigator.pop(context); // اقفل الشيت
                          context.read<NotificationScreenViewModel>().deleteNotification(id);
                          },
                          secondaryButtonText: 'No, Cancel',
                          onSecondaryPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                      icon:Icon(Icons.delete,color: Colors.red,size: 20.sp)),

                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.timer_outlined,color: MyColors.greyColor,size: 15.sp,),
                    SizedBox(width: 5.w,),
                    Text(
                      '$formattedDate.$formattedTime',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: MyColors.greyColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),
                Text(
                  body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: MyColors.greyColor,
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: 4.h,)

        ],
      ),
    );
  }
}
