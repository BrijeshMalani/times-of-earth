import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../common/color_picker.dart';
import '../../common/constant.dart';
import '../../common/image_path.dart';
import '../dashboard/dashboard.dart';
import '../login/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      print(Constant().storage.read("id"));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Constant().storage.read("id") == null
              ? const SignUpScreen()
              : const DashboardScreen(),
        ),
      );
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(ImagePath.logo), context);
    return Scaffold(
      backgroundColor: Colors.indigo.shade200,
      body: Center(
        child: SizedBox(
          height: 350,
          width: 250,
          child: Lottie.asset(ImagePath.lottieAnimation, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
