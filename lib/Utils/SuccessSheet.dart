// import 'package:flutter/material.dart';
//
// import 'MyColors.dart';
//
// void showSuccessBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: MyColors.whiteColor,
//     enableDrag: false,
//     isDismissible: false,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
//     ),
//     builder: (context) {
//       return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // 🔹 Handle bar
//             Container(
//               width: 40.w,
//               height: 4.h,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(10.r),
//               ),
//             ),
//            //  SizedBox(height: 20.h),
//
//             // 🔹 Illustration (تقدري تحطي صورة من النت أو asset)
//             SvgPicture.asset('assets/images/success.svg'),
//
//              SizedBox(height: 24.h),
//
//             // 🔹 Title
//              Text(
//               "Your account successfully created!",
//               style: TextStyle(
//                   fontSize: 17.sp,
//                   fontWeight: FontWeight.w700,
//                   color: MyColors.blackColor
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 8.h),
//
//             // 🔹 Description
//              Text(
//               "Your account has been successfully created. You can go to login page first to login into your account!",
//                style: TextStyle(
//                    fontSize: 12.sp,
//                    fontWeight: FontWeight.w500,
//                    color: MyColors.greyColor
//                ),
//              // textAlign: TextAlign.center,
//             ),
//
//             SizedBox(height: 30.h),
//
//             // 🔹 Button
//             SizedBox(
//               width: double.infinity,
//              // height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                  // Navigator.pop(context); // يقفل الـ BottomSheet
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: MyColors.primaryColor,
//                   padding: EdgeInsets.symmetric(
//                     vertical: 12.h,
//                     horizontal: 16.w,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50.r),
//                   ),
//                 ),
//                 child:
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Yay! Continue",
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: MyColors.whiteColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
