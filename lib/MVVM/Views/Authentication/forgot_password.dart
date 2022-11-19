import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/ViewModels/Authentication/forget_password_view_model.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_app_bar.dart';
import 'package:witpark/Widgets/custom_button.dart';
import 'package:witpark/Widgets/custom_text.dart';
import 'package:witpark/Widgets/custom_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ForgetPasswordModelView forgetPasswordModelView =
        context.watch<ForgetPasswordModelView>();
    return Scaffold(
      appBar: BaseAppBar(
        title: "Forgot password",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomText(
                    text: "Enter your detials",
                    fontsize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      'Please enter your detais to reset your password, Make sure the details are accurate'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Username",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormTextField(
                      controller: username,
                      suffixIcon: const Icon(Icons.phone_outlined)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormTextField(
                      controller: email,
                      suffixIcon: const Icon(Icons.phone_outlined)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "New Password",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormTextField(
                    controller: password,
                    suffixIcon: const Icon(
                      Icons.visibility,
                    ),
                    isPass: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: forgetPasswordModelView.loading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            buttonColor: primaryColor,
                            text: "Send",
                            function: () {
                              if (username.text.isEmpty ||
                                  password.text.isEmpty ||
                                  email.text.isEmpty) {
                                Fluttertoast.showToast(msg: "Fill add fields");
                                return;
                              }
                              if (!email.text.contains("@")) {
                                Fluttertoast.showToast(
                                    msg: "Enter a valid email");
                                return;
                              }
                              forgetPasswordModelView.setModelError(null);
                              forgetPasswordModelView
                                  .forgetPassword(
                                      username.text, email.text, password.text)
                                  .then((value) {
                                if (forgetPasswordModelView.modelError !=
                                    null) {
                                  Fluttertoast.showToast(
                                      msg: "Unable to reset password");
                                } else {
                                  KRoutes.pop(context);
                                  Fluttertoast.showToast(
                                      msg:
                                          "Password reset successful please login");
                                }
                              });
                            }),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
