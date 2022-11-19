import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/ViewModels/BookingViewModel/add_booking_view_model.dart';
import 'package:witpark/MVVM/ViewModels/BookingViewModel/booking_view_model.dart';
import 'package:witpark/MVVM/Views/Profile/edit_profile.dart';
import 'package:witpark/Provider/selected_city_provider.dart';
import 'package:witpark/Provider/user_data_provider.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_button.dart';

class Payment extends StatefulWidget {
  final DateTimeRange dateTimeRange;
  const Payment({super.key, required this.dateTimeRange});
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  double total = 0;
  double getPaymentDetails() {
    double charges = 0;
    int days =
        widget.dateTimeRange.end.difference(widget.dateTimeRange.start).inDays;
    if (days <= 3) {
      charges = 60;
    }
    if (days <= 10) {
      charges = 50;
    }
    if (days <= 20) {
      charges = 40;
    }
    if (days > 20) {
      charges = 35;
    }

    total = days * charges;
    return total;
  }

  double totalWithGst() {
    total = total + (total * 0.05);
    return total;
  }

  @override
  Widget build(BuildContext context) {
    AddBookingModelView addBookingModelView =
        context.watch<AddBookingModelView>();
    String selectedCity = context.read<SelectedCityProvider>().selectedCity;
    LoginModel userData = context.read<UserDataProvider>().userData!;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Payment',
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
          spacer(context, 0.15),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "Payment : ${getPaymentDetails()}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              spacer(context, 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Divider(
                  endIndent: MediaQuery.of(context).size.width * 0.7,
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
              spacer(context, 0.01),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "GST : 5%",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              spacer(context, 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Divider(
                  endIndent: MediaQuery.of(context).size.width * 0.8,
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
              spacer(context, 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "total : ${totalWithGst()}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              spacer(context, 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Divider(
                  endIndent: MediaQuery.of(context).size.width * 0.6,
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          addBookingModelView.loading
              ? const CircularProgressIndicator()
              : CustomButton(
                  buttonColor: primaryColor,
                  text: "Pay now",
                  function: () async {
                    addBookingModelView.setModelError(null);
                    await addBookingModelView
                        .getAllBookings(userData.data!.username!, selectedCity,
                            totalWithGst().toString(), widget.dateTimeRange)
                        .then((value) {
                      if (addBookingModelView.modelError != null) {
                        Fluttertoast.showToast(msg: "Unable to book a slot");
                      } else {
                        context
                            .read<BookingModelView>()
                            .getAllBookings(userData.data!.username!);
                        KRoutes.popUntil(context);
                        Fluttertoast.showToast(msg: "Booked Successfully !!");
                      }
                    });
                  })
        ]));
  }
}
