import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_transitions/flutter_transitions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:witpark/MVVM/Views/Authentication/login_page.dart';
import 'package:witpark/MVVM/Views/Bookings/booking_card.dart';
import 'package:http/http.dart' as http;

import 'add_booking.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  Future<List<BookingData>> _getUsers() async {
    var data = await http.get(
        Uri.parse("http://witpark.pythonanywhere.com/API/AllBookings_API/"));
    var jsonData = json.decode(data.body);

    List<BookingData> users = [];

    for (var u in jsonData["data"]) {
      if (u["booking_owner"] == usernameLogin) {
        BookingData user = BookingData(
            u["booking_id"],
            u["booking_owner"],
            u["booking_city"],
            u["booking_place"],
            u["booking_arrival"],
            u["booking_departure"],
            u["booking_vehicle"],
            u["booking_amount"],
            u["booking_payment_date"],
            u["booking_status"],
            u["booking_payment_status"]);
        users.add(user);
      }
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              // color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  const AutoSizeText(
                    "Bookings",
                    style: TextStyle(fontSize: 50),
                    maxLines: 1,
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                    indent: MediaQuery.of(context).size.width * 0.2,
                    endIndent: MediaQuery.of(context).size.width * 0.2,
                  ),
                ],
              ),
            ),
            SizedBox(
              // color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: FutureBuilder(
                      future: _getUsers(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          );
                        } else if (snapshot.data.length == 0) {
                          return const Center(
                            child: Text("No bookings have been made yet"),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return BookingCards(
                                bowner: snapshot.data[index].booking_owner,
                                bcity: snapshot.data[index].booking_city,
                                bplace: snapshot.data[index].booking_place,
                                barrival: snapshot.data[index].booking_arrival,
                                bdeparture:
                                    snapshot.data[index].booking_departure,
                                bvehicle: snapshot.data[index].booking_vehicle,
                                bamount: snapshot.data[index].booking_amount,
                                bstatus: snapshot.data[index].booking_status,
                                bpaymentstatus:
                                    snapshot.data[index].booking_payment_status,
                              );
                            },
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          shape: const CircleBorder(side: BorderSide(color: Colors.black)),
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, FlutterScaleRoute(page: const AddBooking()))
                .then((_) {
              setState(() {});
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class BookingData {
  final String bookingId;

  final String bookingOwner;

  final String bookingCity;

  final String bookingPlace;

  final String bookingArrival;

  final String bookingDeparture;

  final String bookingVehicle;

  final String bookingAmount;

  final String bookingPaymentDate;

  final String bookingStatus;

  final String bookingPaymentStatus;
  BookingData(this.bookingId, this.bookingOwner, this.bookingCity, this.bookingPlace, this.bookingArrival, this.bookingDeparture, this.bookingVehicle, this.bookingAmount, this.bookingPaymentDate, this.bookingStatus, this.bookingPaymentStatus);
}
