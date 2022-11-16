import 'dart:convert';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_transitions/flutter_transitions.dart';
import 'package:witpark/MVVM/Views/Authentication/forgot_password.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_app_bar.dart';
import 'package:witpark/Widgets/custom_button.dart';
import 'package:witpark/Widgets/custom_text.dart';
import 'package:witpark/Widgets/custom_text_field.dart';
import 'package:witpark/MVVM/Views/Home%20Page/home_page.dart';
import 'package:witpark/MVVM/Views/Authentication/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:witpark/MVVM/Views/Skip%20Screen/skip.dart';

String? usernameLogin;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _checkBoxVal = true;
  signIn() async {
    Map data = {
      "username": _authData["username"],
      "password": _authData["password"]
    };
    var response = await http.post(
        Uri.parse('http://witpark.pythonanywhere.com/API/Login_API/'),
        body: data);
    SharedPreferences pref = await SharedPreferences.getInstance();

    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200 &&
        jsonData["message"] == "${_authData["username"]} Login successfully") {
      usernameLogin = _authData["username"];
      setState(() {
        pref.setString("token", usernameLogin!);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const HomePage()),
            (Route<dynamic> route) => false);
      });
    } else {
      showToast("username or password incorrect or does not exists",
          context: context);
    }
  }

  final _authData = {
    "username": "",
    "password": "",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
          title: "Login",
          appBar: AppBar(),
          widgets: [
            InkWell(
              onTap: () {
                KRoutes.push(context, const Skip());
              },
              child: const CustomText(
                text: "Skip",
                color: primaryColor,
              ),
            )
          ],
          appBarHeight: 50),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Container(
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg.jpg'), fit: BoxFit.contain)),
            ),
            const Spacer(),
            const CustomText(text: "Username / Email :"),
            const SizedBox(
              height: 10,
            ),
            const FormTextField(
                controller: null, suffixIcon: Icon(Icons.email_outlined)),
            const SizedBox(
              height: 10,
            ),
            const CustomText(text: "Password :"),
            const SizedBox(
              height: 10,
            ),
            const FormTextField(
              controller: null,
              suffixIcon: Icon(Icons.visibility_outlined),
              isPass: true,
            ),
            Row(
              children: [
                Checkbox(
                    value: _checkBoxVal,
                    onChanged: (bool? value) {
                      setState(() {
                        _checkBoxVal = value!;
                      });
                    }),
                const CustomText(text: "Remember me"),
                const Spacer(),
                InkWell(
                  onTap: () {
                    KRoutes.push(context, const ForgotPassword());
                  },
                  child: const CustomText(text: "Forgot password?"),
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                buttonColor: primaryColor,
                text: "Sign In",
                function: () {},
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                InkWell(
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.amber),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, FlutterScaleRoute(page: const SignUp()));
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
