import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/Models/Vehicles/vehicles_model.dart';
import 'package:witpark/MVVM/ViewModels/Vehicles/edit_vehicle_view_model.dart';
import 'package:witpark/MVVM/ViewModels/Vehicles/vehicle_view_model.dart';
import 'package:witpark/Provider/user_data_provider.dart';
import 'package:witpark/Utils/app_routes.dart';

import '../../../Utils/utils.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_text.dart';
import '../../../Widgets/custom_text_field.dart';

class EditVehicle extends StatefulWidget {
  final DatumVehicle? vehicle;
  const EditVehicle(this.vehicle, {super.key});
  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {
  final TextEditingController _carName = TextEditingController();
  final TextEditingController _carModel = TextEditingController();
  final TextEditingController _carColor = TextEditingController();
  final TextEditingController _carNumberPlate = TextEditingController();
  @override
  void initState() {
    _carName.text = widget.vehicle!.vehicleName!;
    _carModel.text = widget.vehicle!.vehicleModel.toString();
    _carColor.text = widget.vehicle!.vehicleColor!;
    _carNumberPlate.text = widget.vehicle!.vehicleNoPlate!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EditVehicleModelView editVehicleModelView =
        context.watch<EditVehicleModelView>();
    LoginModel userData = context.read<UserDataProvider>().userData!;
    return Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            'Edit Vehicle',
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
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://cdn3.iconfinder.com/data/icons/transport-02-set-of-vehicles-and-cars/110/Vehicles_and_cars_12-512.png"),
                      maxRadius: 60,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                height: 50,
              ),
              editVehicleModelView.loading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      buttonColor: primaryColor,
                      text: "Update",
                      function: () async {
                        DatumVehicle vehicle = DatumVehicle(
                            vehicleId: widget.vehicle!.vehicleId,
                            vehicleOwner: widget.vehicle!.vehicleOwner,
                            vehicleName: widget.vehicle!.vehicleName,
                            vehicleModel: widget.vehicle!.vehicleModel,
                            vehicleColor: widget.vehicle!.vehicleColor,
                            vehicleNoPlate: widget.vehicle!.vehicleNoPlate);
                        editVehicleModelView.setModelError(null);
                        await editVehicleModelView
                            .editVehicle(vehicle)
                            .then((value) {
                          if (editVehicleModelView.modelError != null) {
                            Fluttertoast.showToast(msg: "Edit vehicle error");
                          } else {
                            context
                                .read<VehicleModelView>()
                                .getAllVehicles(userData.data!.username!);
                            KRoutes.pop(context);
                            Fluttertoast.showToast(
                                msg: "Vehicle Edited Succesfully");
                          }
                        });
                      })
            ]),
          ),
        ));
  }
}
