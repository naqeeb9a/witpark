import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/ViewModels/Vehicles/new_vehicle_view_model.dart';
import 'package:witpark/MVVM/ViewModels/Vehicles/vehicle_view_model.dart';
import 'package:witpark/Provider/user_data_provider.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_button.dart';
import 'package:witpark/Widgets/custom_text.dart';
import 'package:witpark/Widgets/custom_text_field.dart';

class AddVehicles extends StatefulWidget {
  const AddVehicles({super.key});
  @override
  State<AddVehicles> createState() => _AddVehiclesState();
}

class _AddVehiclesState extends State<AddVehicles> {
  final TextEditingController _carName = TextEditingController();
  final TextEditingController _carModel = TextEditingController();
  final TextEditingController _carColor = TextEditingController();
  final TextEditingController _carNumberPlate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    NewVehicleModelView newVehicleModelView =
        context.watch<NewVehicleModelView>();
    LoginModel? userData = context.read<UserDataProvider>().userData;
    return Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            'Add Vehicles',
            style: TextStyle(fontSize: 30),
          ),
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
            child: Column(children: [
              const Divider(
                color: Colors.black,
                thickness: 2,
                indent: 90,
                endIndent: 90,
              ),
              const SizedBox(
                height: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(text: "Car Name:"),
                  const SizedBox(
                    height: 10,
                  ),
                  FormTextField(
                      controller: _carName,
                      suffixIcon: const Icon(Icons.car_rental)),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(text: "Car Model :"),
                  const SizedBox(
                    height: 10,
                  ),
                  FormTextField(
                      controller: _carModel,
                      suffixIcon: const Icon(Icons.car_repair)),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(text: "Car Color :"),
                  const SizedBox(
                    height: 10,
                  ),
                  FormTextField(
                      controller: _carColor,
                      suffixIcon: const Icon(Icons.colorize)),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(text: "Car Number Plate :"),
                  const SizedBox(
                    height: 10,
                  ),
                  FormTextField(
                      controller: _carNumberPlate,
                      suffixIcon: const Icon(Icons.numbers))
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              newVehicleModelView.loading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      buttonColor: primaryColor,
                      text: "Add",
                      function: () async {
                        newVehicleModelView.setModelError(null);
                        await newVehicleModelView
                            .addNewVehicle(
                                userData!.data!.username ?? "",
                                _carName.text,
                                _carModel.text,
                                _carColor.text,
                                _carNumberPlate.text)
                            .then((value) {
                          if (newVehicleModelView.modelError != null) {
                            Fluttertoast.showToast(
                                msg: newVehicleModelView
                                    .modelError!.errorResponse
                                    .toString());
                          } else {
                            context.read<VehicleModelView>().getAllVehicles();
                            KRoutes.pop(context);
                            Fluttertoast.showToast(
                                msg: "Vehicle added successfully !!");
                          }
                        });
                      })
            ]),
          ),
        ));
  }
}
