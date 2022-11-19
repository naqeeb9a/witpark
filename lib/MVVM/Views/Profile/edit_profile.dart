import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/ViewModels/Cities/city_view_model.dart';
import 'package:witpark/MVVM/ViewModels/Profile/update_profile_view_model.dart';
import 'package:witpark/Provider/user_data_provider.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/cities_list.dart';
import 'package:witpark/Widgets/custom_button.dart';
import 'package:witpark/Widgets/custom_text.dart';
import 'package:witpark/Widgets/custom_text_field.dart';

import '../../../Provider/selected_city_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  @override
  void initState() {
    LoginModel userData = context.read<UserDataProvider>().userData!;
    _firstName.text = userData.data!.firstName!;
    _lastName.text = userData.data!.lastName!;
    _email.text = userData.data!.email!;
    _city.text = userData.data!.city!;
    _phone.text = userData.data!.phone!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginModel userData = context.read<UserDataProvider>().userData!;
    UpdateProfileModelView updateProfileModelView =
        context.watch<UpdateProfileModelView>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/wit2.png"),
                  maxRadius: 60,
                ),
              ),
              const SizedBox(height: 20),
              const CustomText(text: "First name :"),
              const SizedBox(height: 10),
              FormTextField(
                  controller: _firstName, suffixIcon: const Icon(Icons.person)),
              const SizedBox(height: 10),
              const CustomText(text: "Last name :"),
              const SizedBox(height: 10),
              FormTextField(
                  controller: _lastName, suffixIcon: const Icon(Icons.person)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(text: "City :"),
                  Builder(
                    builder: (context) {
                      CityModelView cityModelView =
                          context.watch<CityModelView>();
                      if (cityModelView.loading) {
                        return const CircularProgressIndicator();
                      }
                      if (cityModelView.modelError != null) {
                        return const CustomText(text: "Error");
                      }
                      return ListDropDown(
                          givenList:
                              cityModelView.allcitysModel!.data!.toList());
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: updateProfileModelView.loading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        buttonColor: primaryColor,
                        text: "Update",
                        function: () async {
                          LoginModel updatedUserData = LoginModel(
                              status: true,
                              message: "updated",
                              data: Data(
                                  id: userData.data!.id,
                                  username: userData.data!.username,
                                  firstName: _firstName.text,
                                  lastName: _lastName.text,
                                  email: userData.data!.email,
                                  phone: userData.data!.phone,
                                  city: context
                                      .read<SelectedCityProvider>()
                                      .selectedCity));
                          updateProfileModelView.setModelError(null);
                          await updateProfileModelView
                              .getAllupdateProfiles(updatedUserData)
                              .then((value) {
                            if (updateProfileModelView.modelError != null) {
                              Fluttertoast.showToast(
                                  msg: "Profile update error");
                            } else {
                              context
                                  .read<UserDataProvider>()
                                  .updateData(updatedUserData);
                              KRoutes.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Updated Successfully");
                            }
                          });
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget spacer(BuildContext context, double value) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * value,
  );
}
