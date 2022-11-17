import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/Views/Authentication/login_page.dart';
import 'package:witpark/MVVM/Views/Home%20Page/home_page.dart';

import '../../../Provider/user_data_provider.dart';
import '../../../Utils/app_routes.dart';

class PageDecider extends StatefulWidget {
  const PageDecider({super.key});

  @override
  State<PageDecider> createState() => _PageDeciderState();
}

class _PageDeciderState extends State<PageDecider> {
  @override
  void initState() {
    decidePage();
    super.initState();
  }

  decidePage() async {
    String? userData = await context.read<UserDataProvider>().getUserData();
    if (userData == null) {
      pushPage(const LoginPage(), userData);
    } else {
      pushPage(const HomePage(), userData);
    }
  }

  void pushPage(Widget page, String? userData) {
    if (userData != null) {
      context.read<UserDataProvider>().updateData(loginModelFromJson(userData));
    }
    KRoutes.pushAndRemoveUntil(context, page);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
