import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_transitions/flutter_transitions.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/ViewModels/Authentication/login_view_model.dart';
import 'package:witpark/MVVM/Views/Authentication/forgot_password.dart';
import 'package:witpark/Provider/user_data_provider.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_app_bar.dart';
import 'package:witpark/Widgets/custom_button.dart';
import 'package:witpark/Widgets/custom_text.dart';
import 'package:witpark/Widgets/custom_text_field.dart';
import 'package:witpark/MVVM/Views/Home%20Page/home_page.dart';
import 'package:witpark/MVVM/Views/Authentication/sign_up.dart';
import 'package:witpark/MVVM/Views/Skip%20Screen/skip.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _checkBoxVal = true;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LoginModelView loginModelView = context.watch<LoginModelView>();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/bg.jpg'),
                        fit: BoxFit.contain)),
              ),
              const CustomText(text: "Username / Email :"),
              const SizedBox(
                height: 10,
              ),
              FormTextField(
                  controller: username,
                  suffixIcon: const Icon(Icons.email_outlined)),
              const SizedBox(
                height: 10,
              ),
              const CustomText(text: "Password :"),
              const SizedBox(
                height: 10,
              ),
              FormTextField(
                controller: password,
                suffixIcon: const Icon(Icons.visibility_outlined),
                isPass: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      KRoutes.push(context, const ForgotPassword());
                    },
                    child: const CustomText(text: ""),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: loginModelView.loading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        buttonColor: primaryColor,
                        text: "Sign In",
                        function: () async {
                          loginModelView.setModelError(null);
                          await context
                              .read<LoginModelView>()
                              .loginUser(username.text, password.text)
                              .then((value) async {
                            if (loginModelView.modelError != null) {
                              Fluttertoast.showToast(
                                  msg: loginModelView.modelError!.errorResponse
                                      .toString());
                            } else {
                              await updateData(loginModelView.loginModel!);
                              pushPage();
                            }
                          });
                        }),
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
      ),
    );
  }

  Future<void> updateData(LoginModel response) async {
    await context.read<UserDataProvider>().saveUserData(response);
  }

  popPage() {
    KRoutes.pop(context);
  }

  pushPage() {
    KRoutes.pushAndRemoveUntil(context, const HomePage());
  }
}
