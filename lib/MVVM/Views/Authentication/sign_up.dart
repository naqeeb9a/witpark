import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/ViewModels/Authentication/signup_view_model.dart';
import 'package:witpark/Provider/selected_city_provider.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_app_bar.dart';
import 'package:witpark/Widgets/custom_button.dart';
import 'package:witpark/Widgets/custom_text.dart';
import 'package:witpark/Widgets/custom_text_field.dart';

import '../../../Widgets/cities_list.dart';
import '../../ViewModels/Cities/city_view_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _checkBoxVal = false;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SignupModelView signupModelView = context.watch<SignupModelView>();
    return Scaffold(
      appBar: BaseAppBar(
          title: "Create Account",
          appBar: AppBar(),
          automaticallyImplyLeading: true,
          widgets: const [],
          appBarHeight: 50),
      bottomNavigationBar: bottomBar(signupModelView),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              inputField("Username :", _username, Icons.person_outline),
              inputField("First name :", _firstName, Icons.person_outline),
              inputField("Last Name :", _lastName, Icons.person_outline),
              inputField("Email :", _email, Icons.email_outlined),
              inputField("Password :", _password, Icons.visibility,
                  isPass: true),
              inputField(
                  "Confirm Password :", _confirmPassword, Icons.visibility,
                  isPass: true),
              inputField("Mobile number :", _phone, Icons.phone_outlined,
                  keyboardType: TextInputType.number),
              cityList()
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField(
      String text, TextEditingController? controller, IconData? icon,
      {bool isPass = false, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: text),
        const SizedBox(
          height: 10,
        ),
        FormTextField(
          controller: controller,
          suffixIcon: Icon(icon),
          keyboardtype: keyboardType,
          isPass: isPass,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget cityList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomText(text: "City :"),
        Builder(
          builder: (context) {
            CityModelView cityModelView = context.watch<CityModelView>();
            if (cityModelView.loading) {
              return const CircularProgressIndicator();
            }
            if (cityModelView.modelError != null) {
              return const CustomText(text: "Error");
            }
            return ListDropDown(
                givenList: cityModelView.allcitysModel!.data!.toList());
          },
        )
      ],
    );
  }

  Widget bottomBar(SignupModelView signupModelView) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        signupModelView.loading
            ? const CircularProgressIndicator()
            : CustomButton(
                buttonColor: primaryColor,
                text: "Sign Up",
                function: () async {
                  if (_username.text.isEmpty ||
                      _firstName.text.isEmpty ||
                      _lastName.text.isEmpty ||
                      _email.text.isEmpty ||
                      _password.text.isEmpty ||
                      _confirmPassword.text.isEmpty ||
                      _phone.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Fill all Fields");
                    return;
                  }
                  if (!_email.text.contains("@") ||
                      !_email.text.contains(".")) {
                    Fluttertoast.showToast(msg: "Enter a correct email");
                    return;
                  }
                  if (_password.text != _confirmPassword.text) {
                    Fluttertoast.showToast(msg: "Password don't match !!");
                    return;
                  }
                  if (_checkBoxVal == false) {
                    Fluttertoast.showToast(
                        msg: "Please accept the terms and conditions !!");
                    return;
                  }
                  signupModelView.setModelError(null);
                  await signupModelView
                      .signupUser(
                    _username.text,
                    _firstName.text,
                    _lastName.text,
                    _email.text,
                    _password.text,
                    _phone.text,
                    context.read<SelectedCityProvider>().selectedCity,
                  )
                      .then((value) {
                    if (signupModelView.modelError != null) {
                      Fluttertoast.showToast(
                          msg: "Error signing up, try again later !");
                    } else {
                      KRoutes.pop(context);
                      Fluttertoast.showToast(
                          msg: "User created successfully, now please login");
                    }
                  });
                }),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
