import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_app_bar.dart';
import 'package:witpark/Widgets/custom_button.dart';
import 'package:witpark/Widgets/custom_text.dart';
import 'package:witpark/Widgets/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _checkBoxVal = false;

  postData() async {
    await http
        .post(Uri.parse("http://witpark.pythonanywhere.com/API/Signup_API/"),
            body: _authData)
        .then((value) {
      var jsonData = jsonDecode(value.body);
      if (jsonData["status"] == 201 &&
          jsonData["message"] == "Data saved successfully") {
        showToast("successfully registered please login now", context: context);
        Navigator.pop(context);
      } else if (jsonData["status"] == 204 &&
          jsonData["message"] == "Invalid data") {
        showToast("User details were wrong or the user exists already",
            context: context);
      } else {
        //Simple to use, no global configuration
        showToast("Error try again", context: context);
      }
    });
  }

  final _authData = {
    "username": "",
    "first_name": "",
    "last_name": "",
    "email": "",
    "password": "",
    "phone": "",
    "city": "",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Create Account",
          appBar: AppBar(),
          automaticallyImplyLeading: true,
          widgets: const [],
          appBarHeight: 50),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              inputField("Username :", null, Icons.person_outline),
              inputField("First name :", null, Icons.person_outline),
              inputField("Last Name :", null, Icons.person_outline),
              inputField("Email :", null, Icons.email_outlined),
              inputField("Password :", null, Icons.visibility),
              inputField("Confirm Password :", null, Icons.visibility),
              inputField("Mobile number :", null, Icons.phone_outlined),
              inputField("City :", null, Icons.location_city_outlined),
              Row(
                children: [
                  Checkbox(
                    value: _checkBoxVal,
                    onChanged: (value) {
                      setState(() => _checkBoxVal = value!);
                    },
                  ),
                  const CustomText(
                    text: "I have accepted the terms and conditions",
                    maxLines: 2,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  buttonColor: primaryColor, text: "Sign Up", function: () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField(
      String text, TextEditingController? controller, IconData? icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: text),
        const SizedBox(
          height: 10,
        ),
        FormTextField(controller: controller, suffixIcon: Icon(icon)),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
