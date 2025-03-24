import 'package:flutter/material.dart';

import '../common/image_path.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.wifi,
                width: 300,
                height: 300,
              ),
              Text(
                "Please check your internet connection",
                textScaleFactor: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
