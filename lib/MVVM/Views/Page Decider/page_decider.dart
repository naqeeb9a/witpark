import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/MVVM/Views/Home%20Page/home_page.dart';

import '../Authentication/login_page.dart';

class PageDecider extends StatelessWidget {
  const PageDecider({super.key});

  @override
  Widget build(BuildContext context) {
    checkLoginStatus(context);
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: primaryColor,
          strokeWidth: 2,
        ),
      ),
    );
  }

  checkLoginStatus(BuildContext context) async {
    await SharedPreferences.getInstance().then((value) {
      usernameLogin = value.getString("token");
      if (value.getString("token") == null) {
        KRoutes.pushAndRemoveUntil(context, const LoginPage());
      } else {
        KRoutes.pushAndRemoveUntil(context, const HomePage());
      }
    });
  }
}
