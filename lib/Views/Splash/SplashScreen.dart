import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_library_management/Views/Auth/LoginScreen.dart';
import 'package:online_library_management/Views/Library/LibraryScreen.dart';
import '../../Services/Local/SharedPreference.dart';
import '../../Utils/MyColors.dart';


class splashScreen extends StatefulWidget {
  static const String routeName = 'splash';
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    _startSplashLogic();
  }

  void _startSplashLogic() async {
    await Future.delayed(const Duration(seconds: 2)); // ⬅ وقت ظهور السبلاتش

    final token = await TokenStorage.getToken();

    if (!mounted) return;

    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LibraryScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: double.infinity,
        ),
      ),
    );
  }
}

