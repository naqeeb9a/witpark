import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/Models/Vehicles/vehicles_model.dart';
import 'package:witpark/MVVM/ViewModels/Vehicles/delete_vehicle.dart';
import 'package:witpark/MVVM/ViewModels/Vehicles/vehicle_view_model.dart';
import 'package:witpark/MVVM/Views/Vehicles/edit_vehicle.dart';
import 'package:witpark/Provider/user_data_provider.dart';
import 'package:witpark/Utils/app_routes.dart';

class VechiclesCards extends StatefulWidget {
  final DatumVehicle vehicle;
  const VechiclesCards({super.key, required this.vehicle});
  @override
  State<VechiclesCards> createState() => _VechiclesCardsState();
}

class _VechiclesCardsState extends State<VechiclesCards> {
  @override
  Widget build(BuildContext context) {
    LoginModel userData = context.read<UserDataProvider>().userData!;
    DeleteVehicleModelView deleteVehicleModelView =
        context.watch<DeleteVehicleModelView>();
    return Slidable(
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            KRoutes.push(context, EditVehicle(widget.vehicle));
          },
          icon: Icons.edit,
          label: 'Edit',
        ),
        SlidableAction(
          onPressed: (context2) async {
            await deleteVehicleModelView
                .deleteVehicle(userData.data!.username!, widget.vehicle)
                .then((value) {
              if (deleteVehicleModelView.modelError != null) {
                Fluttertoast.showToast(msg: "Unable to delete Vehicle");
              } else {
                context
                    .read<VehicleModelView>()
                    .getAllVehicles(userData.data!.username!);
                Fluttertoast.showToast(msg: "Deleted Successfully !!");
              }
            });
          },
          icon: Icons.delete,
          label: 'Delete',
        ),
      ]),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              "${widget.vehicle.vehicleName} \n${widget.vehicle.vehicleModel} model\n${widget.vehicle.vehicleColor}",
              style: const TextStyle(fontSize: 15),
            ),
            AutoSizeText(
              widget.vehicle.vehicleNoPlate ?? "",
              style: const TextStyle(
                  color: Colors.amber, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
