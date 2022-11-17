import 'package:flutter/material.dart';
import 'package:flutter_transitions/flutter_transitions.dart';
import 'package:witpark/MVVM/Views/Profile/delete_user.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_button.dart';
import 'package:witpark/Widgets/custom_text.dart';
import 'package:witpark/faq.dart';
import 'package:witpark/MVVM/Views/Profile/edit_profile.dart';
import 'package:witpark/MVVM/Views/Vehicles/vehicles.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Authentication/login_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 10),
              const CustomText(text: "Profile"),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                        spacer(context, 0.023),
                        const Divider(
                          thickness: 2,
                          color: Colors.black,
                        ),
                        spacer(context, 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                                buttonColor: primaryColor,
                                text: "Edit profile",
                                function: () {}),
                            CustomButton(
                                buttonColor: primaryColor,
                                text: "Edit password",
                                function: () {})
                          ],
                        )
                      ],
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      )),
                  width: MediaQuery.of(context).size.width * 0.67,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const Center(
                      child: Text(
                    "Vehicles",
                    style: TextStyle(fontSize: 20),
                  )),
                ),
                onTap: () {
                  Navigator.push(
                      context, FlutterScaleRoute(page: const Vehicles()));
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, FlutterScaleRoute(page: const FAQ()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      )),
                  width: MediaQuery.of(context).size.width * 0.67,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const Center(
                      child: Text(
                    "FAQ",
                    style: TextStyle(fontSize: 20),
                  )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, FlutterScaleRoute(page: web(context)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      )),
                  width: MediaQuery.of(context).size.width * 0.67,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const Center(
                      child: Text(
                    "About",
                    style: TextStyle(fontSize: 20),
                  )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginPage()),
                          (Route<dynamic> route) => false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                          )),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: const Center(
                          child: Text(
                        "Logout",
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context, FlutterScaleRoute(page: const DeleteUser()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                          )),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: const Center(
                          child: Text(
                        "Delete user",
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                  ),
                ],
              )
            ],
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
