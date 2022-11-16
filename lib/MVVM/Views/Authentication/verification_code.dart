import 'package:flutter/material.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_app_bar.dart';
import 'package:witpark/Widgets/custom_button.dart';

class VerificationCode extends StatelessWidget {
  const VerificationCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Forgot password",
          appBar: AppBar(),
          widgets: const [],
          automaticallyImplyLeading: true,
          appBarHeight: 50),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Enter Verification Code',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                    'Please enter Verification code we sent to your number (03353961635)'),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsetsDirectional.all(20),
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter the verification code",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TextField(
                          maxLength: 5,
                          decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const Text("      -Enter the 5 digit code")
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                      buttonColor: kWhite, text: "Confirm", function: () {}),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
