import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/Views/Page%20Decider/page_decider.dart';
import 'package:witpark/MVVM/Views/Profile/delete_user.dart';
import 'package:witpark/MVVM/Views/Profile/edit_password.dart';
import 'package:witpark/Provider/user_data_provider.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_button.dart';
import 'package:witpark/Widgets/custom_text.dart';
import 'package:witpark/MVVM/Views/Profile/faq.dart';
import 'package:witpark/MVVM/Views/Profile/edit_profile.dart';
import 'package:witpark/MVVM/Views/Vehicles/vehicles.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../ViewModels/Vehicles/vehicle_view_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    LoginModel userData = context.watch<UserDataProvider>().userData!;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 10),
                const CustomText(
                  text: "Profile",
                  fontsize: 30,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                const CircleAvatar(
                  radius: 62,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    maxRadius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/wit2.png"),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        )),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  CustomText(text: "Email :"),
                                  CustomText(text: "Name :"),
                                  CustomText(text: "phone :"),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: "${userData.data!.email}"),
                                  CustomText(
                                      text: "${userData.data!.firstName}"),
                                  CustomText(text: "${userData.data!.phone}"),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          spacer(context, 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                  buttonColor: primaryColor,
                                  text: "Edit profile",
                                  function: () {
                                    KRoutes.push(context, const EditProfile());
                                  }),
                              CustomButton(
                                  buttonColor: primaryColor,
                                  text: "Edit password",
                                  function: () {
                                    KRoutes.push(context, const Editpassword());
                                  })
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                CustomButton(
                    buttonColor: primaryColor,
                    text: "Vehicles",
                    invert: true,
                    function: () {
                      context
                          .read<VehicleModelView>()
                          .getAllVehicles(userData.data!.username!);
                      KRoutes.push(context, const Vehicles());
                    }),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    buttonColor: primaryColor,
                    text: "FAQ",
                    invert: true,
                    function: () {
                      KRoutes.push(context, const FAQ());
                    }),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    buttonColor: primaryColor,
                    text: "About",
                    invert: true,
                    function: () {
                      KRoutes.push(context, web(context));
                    }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                        buttonColor: primaryColor,
                        text: "Logout",
                        invert: true,
                        function: () {
                          context.read<UserDataProvider>().clearUserData();
                          KRoutes.push(context, const PageDecider());
                        }),
                    CustomButton(
                        buttonColor: primaryColor,
                        text: "Delete User",
                        invert: true,
                        function: () {
                          KRoutes.push(context, const DeleteUser());
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget web(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("About"),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios)),
    ),
    body: const WebView(
      initialUrl: 'http://witpark.pythonanywhere.com/WitPark/about/',
      javascriptMode: JavascriptMode.unrestricted,
    ),
  );
}
