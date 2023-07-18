import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/auth_manager.dart';
import '../login_screen/login_screen.dart';
import 'collage_screen.dart';

class OnboardCollage extends StatelessWidget {
  const OnboardCollage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager _authManager = Get.find();

    Future<void> initializeSettings() async {
      _authManager.checkLoginStatus();

      //Simulate other services for 3 seconds
      await Future.delayed(Duration(seconds: 2));
    }

    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError)
            return errorView(snapshot);
          else
            return Obx(() {
              return _authManager.isLogged.value
                  ? CollageScreen()
                  : LoginScreen();
            });
        }
      },
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
