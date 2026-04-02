import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_library_management/Views/Borrowed/BorrowedScreen.dart';
import 'package:online_library_management/Views/Borrowed/Late&PendingScreen.dart';
import '../../Utils/MyColors.dart';
import '../Auth/LoginScreen.dart';
import '../Borrowed/ReturnedScreen.dart';
import '../DashBoard/DashBoardScreen.dart';
import '../Library/LibraryScreen.dart';
import '../Notification/NotificationScreen.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          /// ---------- Header ----------
          DrawerHeader(
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                  AssetImage('assets/images/logo.png'),
                ),
                SizedBox(width: 12.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "E-Library",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Admin Panel",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          /// ---------- Items ----------
          _drawerItem(
            icon: Icon(Icons.dashboard_customize_outlined,color: MyColors.blackColor,),
            title: "Dashboard",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DashBoardScreen()),
              );
            },
          ),


          _drawerItem(
            icon: SvgPicture.asset('assets/images/bookcase.svg',
    width: 20.w,
    height: 20.h,
    color:  MyColors.blackColor,
    ),
            title: "Library",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LibraryScreen()),
              );
            },
          ),

          _drawerItem(
            icon:  SvgPicture.asset('assets/images/notification-bing.svg',
              width: 20.w,
              height: 20.h,
              color:  MyColors.blackColor,
            ),
            title: "Notifications",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationScreen()),
              );
            },
          ),

          _drawerItem(
            icon:  Icon(Icons.open_in_new,color: MyColors.blackColor,),
            title: "Borrowed",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BorrowedScreen(),
                ),
              );
            },
          ),
          _drawerItem(
            icon:  Icon(Icons.assignment_turned_in_outlined,color: MyColors.blackColor,),
            title: "Returned",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReturnedScreen(),
                ),
              );
            },
          ),
          _drawerItem(
            icon: Icon(Icons.error_outline_outlined,color: MyColors.blackColor,),
            title: "Late & Pending",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LatePendingScreen()),
              );
            },
          ),

          Spacer(),
          Divider(),

          _drawerItem(
            icon: Icon(Icons.logout,color: Colors.red,),
            title: "Logout",
            color: Colors.red,
            onTap: () {
              // logout logic
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginScreen.routeName,
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required Widget icon,
    required String title,
    Color? color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          color: color ?? MyColors.blackColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
