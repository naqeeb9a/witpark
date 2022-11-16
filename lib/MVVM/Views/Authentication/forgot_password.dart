import 'package:flutter/material.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_app_bar.dart';
import 'package:witpark/Widgets/custom_button.dart';
import 'package:witpark/Widgets/custom_text.dart';
import 'package:witpark/Widgets/custom_text_field.dart';
import 'package:witpark/MVVM/Views/Authentication/verification_code.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Forgot password",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CustomText(
                  text: "Enter your phone number",
                  fontsize: 25,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    'Please enter your phone number, we will send you a verification code to your number'),
              ],
            ),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6162,
              color: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Phone number",
                          style: TextStyle(fontSize: 20),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const FormTextField(
                        controller: null,
                        suffixIcon: Icon(Icons.phone_outlined)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.17,
                    ),
                    CustomButton(
                        buttonColor: kWhite,
                        text: "Send",
                        function: () {
                          KRoutes.push(context, const VerificationCode());
                        })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
