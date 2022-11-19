import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Authentication/login_model.dart';
import 'package:witpark/MVVM/Models/Bookings/all_bookings_model.dart';
import 'package:witpark/MVVM/ViewModels/BookingViewModel/booking_view_model.dart';
import 'package:witpark/MVVM/ViewModels/BookingViewModel/cancel_booking.dart';
import 'package:witpark/Provider/user_data_provider.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_text.dart';

class BookingDetails extends StatefulWidget {
  final Datum booking;
  const BookingDetails({super.key, required this.booking});
  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  final dateFormat = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    CancelBookingModelView cancelBookingModelView =
        context.watch<CancelBookingModelView>();
    LoginModel userData = context.read<UserDataProvider>().userData!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking details',
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
      body: Column(
        children: [
          const Divider(
            color: Colors.black,
            thickness: 2,
            indent: 90,
            endIndent: 90,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const AutoSizeText(
                  "Parking Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: AutoSizeText(
                        "Name:  \n city: \n Parking: \n Arrival: \n Departure: \n No. plate: \n Amount: \n Credit: ",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    AutoSizeText(
                      " ${widget.booking.bookingOwner}  \n ${widget.booking.bookingCity} \n ${widget.booking.bookingPlace} \n ${dateFormat.format(widget.booking.bookingArrival as DateTime)} \n ${dateFormat.format(widget.booking.bookingDeparture as DateTime)} \n ${widget.booking.bookingVehicle} \n ${widget.booking.bookingAmount} \n ${widget.booking.bookingPaymentStatus} ",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    cancelBookingModelView.loading
                        ? Column(
                            children: const [
                              CircularProgressIndicator(
                                color: kWhite,
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          )
                        : InkWell(
                            onTap: () {
                              cancelBookingModelView.setModelError(null);
                              cancelBookingModelView
                                  .cancelBooking(userData.data!.username!,
                                      widget.booking.bookingId.toString())
                                  .then((value) {
                                if (cancelBookingModelView.modelError != null) {
                                  Fluttertoast.showToast(
                                      msg: "Unable to cancel booking !");
                                } else {
                                  context
                                      .read<BookingModelView>()
                                      .getAllBookings(userData.data!.username!);
                                  KRoutes.pop(context);
                                  Fluttertoast.showToast(
                                      msg: "Booking cancelled");
                                }
                              });
                            },
                            child: const Icon(
                              Icons.cancel,
                              size: 50,
                            ),
                          ),
                    const CustomText(text: "Cancel Booking"),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
