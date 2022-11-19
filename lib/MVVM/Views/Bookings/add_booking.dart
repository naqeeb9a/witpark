import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/ViewModels/Places/place_view_model.dart';
import 'package:witpark/MVVM/Views/Payment/payment.dart';
import 'package:witpark/Provider/selected_city_provider.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_button.dart';
import 'package:witpark/Widgets/custom_text.dart';
import 'package:witpark/Widgets/place_list.dart';
import 'package:witpark/Widgets/vehicle_list.dart';

import '../../../Widgets/cities_list.dart';
import '../../ViewModels/Cities/city_view_model.dart';
import '../../ViewModels/Vehicles/vehicle_view_model.dart';

class AddBooking extends StatefulWidget {
  const AddBooking({super.key});

  @override
  State<AddBooking> createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  DateTimeRange? dateTimeRange;
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    String selectedCity = context.watch<SelectedCityProvider>().selectedCity;
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Booking',
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Divider(
                color: Colors.black,
                thickness: 2,
                indent: 90,
                endIndent: 90,
              ),
              const SizedBox(
                height: 10,
              ),
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
              const SizedBox(height: 10),
              if (selectedCity != "Select a City")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Available Parkings :"),
                    Builder(
                      builder: (context) {
                        PlaceModelView placeModelView =
                            context.watch<PlaceModelView>();
                        if (placeModelView.loading) {
                          return const CircularProgressIndicator();
                        }
                        if (placeModelView.modelError != null) {
                          return const CustomText(text: "Error");
                        }
                        return PlaceListDropDown(
                            givenList:
                                placeModelView.allPlacesModel!.data!.toList());
                      },
                    )
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(text: "Available cars :"),
                  Builder(
                    builder: (context) {
                      VehicleModelView vehicleModelView =
                          context.watch<VehicleModelView>();
                      if (vehicleModelView.loading) {
                        return const CircularProgressIndicator();
                      }
                      if (vehicleModelView.modelError != null) {
                        return const CustomText(text: "Error");
                      }
                      return VehicleListDropDown(
                          givenList:
                              vehicleModelView.vehiclesModel!.data!.toList());
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                dateTimeRange != null
                    ? "${dateFormat.format(dateTimeRange!.start)}  to  ${dateFormat.format(dateTimeRange!.end)}"
                    : "Duration",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  buttonColor: primaryColor,
                  text: "Pick duration",
                  function: () async {
                    dateTimeRange = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365)));
                    setState(() {});
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  buttonColor: primaryColor,
                  text: "Proceed to Payment",
                  function: () {
                    if (selectedCity == "Select a City") {
                      Fluttertoast.showToast(msg: "Select a city first");
                      return;
                    }
                    if (dateTimeRange == null) {
                      Fluttertoast.showToast(msg: "Select a Date range !!");
                      return;
                    }
                    KRoutes.push(
                        context,
                        Payment(
                          dateTimeRange: dateTimeRange!,
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
