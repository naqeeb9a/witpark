import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/ViewModels/Profile/update_password_view_model.dart';
import 'package:witpark/Provider/user_data_provider.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_button.dart';
import 'package:witpark/Widgets/custom_text.dart';
import 'package:witpark/Widgets/custom_text_field.dart';

class Editpassword extends StatefulWidget {
  const Editpassword({super.key});

  @override
  State<Editpassword> createState() => _EditpasswordState();
}

class _EditpasswordState extends State<Editpassword> {
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UpdatePasswordModelView updatePasswordModelView =
        context.watch<UpdatePasswordModelView>();
    LoginModel userData = context.read<UserDataProvider>().userData!;
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/wit2.png"),
                  maxRadius: 60,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomText(text: "Old Password :"),
              const SizedBox(
                height: 10,
              ),
              FormTextField(
                controller: _oldPassword,
                suffixIcon: const Icon(Icons.visibility),
                isPass: true,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(text: "New Password :"),
              const SizedBox(
                height: 10,
              ),
              FormTextField(
                controller: _newPassword,
                suffixIcon: const Icon(Icons.visibility),
                isPass: true,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(text: "Confirm Password :"),
              const SizedBox(
                height: 10,
              ),
              FormTextField(
                controller: _confirmPassword,
                suffixIcon: const Icon(Icons.visibility),
                isPass: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: updatePasswordModelView.loading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        buttonColor: primaryColor,
                        text: "Update",
                        function: () async {
                          updatePasswordModelView.setModelError(null);
                          await updatePasswordModelView
                              .updatePasword(userData, _oldPassword.text,
                                  _newPassword.text)
                              .then((value) {
                            if (updatePasswordModelView.modelError != null) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Make sure the old password is correct !");
                            } else {
                              KRoutes.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Updated Password Successfully !!");
                            }
                          });
                        }),
              )
            ]),
          ),
        ));
  }

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
}
