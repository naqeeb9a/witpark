import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:witpark/MVVM/Models/Bookings/all_bookings_model.dart';

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
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(15)),
            height: MediaQuery.of(context).size.height * 0.5,
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
                const Icon(
                  Icons.directions,
                  size: 50,
                  color: Colors.black,
                ),
                const AutoSizeText('Get Directions')
              ],
            ),
          )
        ],
      ),
    );
  }
}
