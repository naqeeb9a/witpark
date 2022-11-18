import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Vehicles/vehicles_model.dart';
import 'package:witpark/MVVM/ViewModels/Vehicles/vehicle_view_model.dart';
import 'package:witpark/MVVM/Views/Vehicles/add_vehicles.dart';
import 'package:witpark/MVVM/Views/Vehicles/vehicles_cards.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Widgets/custom_text.dart';

import '../../../Utils/utils.dart';

class Vehicles extends StatefulWidget {
  const Vehicles({super.key});

  @override
  State<Vehicles> createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  @override
  Widget build(BuildContext context) {
    VehicleModelView vehicleModelView = context.watch<VehicleModelView>();
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Vehicles',
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
      body: Column(children: [
        const Divider(
          color: Colors.black,
          thickness: 2,
          indent: 90,
          endIndent: 90,
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(child: vehiclesView(vehicleModelView))
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (vehicleModelView.loading == false) {
            KRoutes.push(context, const AddVehicles());
          } else {
            Fluttertoast.showToast(msg: "Wait for the vehicles to load ..");
          }
        },
      ),
    );
  }

  Widget vehiclesView(VehicleModelView vehicleModelView) {
    if (vehicleModelView.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: kblack,
        ),
      );
    }
    if (vehicleModelView.modelError != null) {
      return Center(
        child: CustomText(
            text: vehicleModelView.modelError!.errorResponse.toString()),
      );
    }
    if (vehicleModelView.vehiclesModel!.data!.isEmpty) {
      return const Center(
        child: CustomText(text: "No Bookings for Now !"),
      );
    }

    return ListView.builder(
      itemCount: vehicleModelView.vehiclesModel!.data!.length,
      itemBuilder: (context, index) {
        DatumVehicle vehicle;
        vehicle = vehicleModelView.vehiclesModel!.data![index];
        return VechiclesCards(
          vehicle: vehicle,
        );
      },
    );
  }
}
