import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/Models/Bookings/all_bookings_model.dart';
import 'package:witpark/MVVM/ViewModels/BookingViewModel/booking_view_model.dart';
import 'package:witpark/MVVM/Views/Bookings/booking_card.dart';
import 'package:witpark/Utils/app_routes.dart';
import 'package:witpark/Utils/utils.dart';
import 'package:witpark/Widgets/custom_text.dart';

import 'add_booking.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    BookingModelView bookingModelView = context.watch<BookingModelView>();
    return Scaffold(
      backgroundColor: Colors.amber,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          KRoutes.push(context, const AddBooking());
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
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
            const SizedBox(
              height: 20,
            ),
            Expanded(child: allBookingsView(bookingModelView))
          ],
        ),
      ),
    );
  }

  Widget allBookingsView(BookingModelView bookingModelView) {
    if (bookingModelView.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: kblack,
        ),
      );
    }
    if (bookingModelView.modelError != null) {
      return Center(
        child: CustomText(
            text: bookingModelView.modelError!.errorResponse.toString()),
      );
    }
    if (bookingModelView.allBookingsModel!.data!.isEmpty) {
      return const Center(
        child: CustomText(text: "No Bookings for Now !"),
      );
    }
    return ListView.builder(
      itemCount: bookingModelView.allBookingsModel!.data!.length,
      itemBuilder: (context, index) {
        Datum booking = bookingModelView.allBookingsModel!.data![index];
        return BookingCards(
          booking: booking,
        );
      },
    );
  }
}
