import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/ViewModels/Authentication/login_view_model.dart';
import 'package:witpark/MVVM/ViewModels/Authentication/signup_view_model.dart';
import 'package:witpark/MVVM/ViewModels/BookingViewModel/booking_view_model.dart';
import 'package:witpark/MVVM/ViewModels/Cities/city_view_model.dart';
import 'package:witpark/MVVM/ViewModels/Profile/update_password_view_model.dart';
import 'package:witpark/MVVM/ViewModels/Profile/update_profile_view_model.dart';
import 'package:witpark/MVVM/ViewModels/Vehicles/edit_vehicle_view_model.dart';
import 'package:witpark/MVVM/ViewModels/Vehicles/new_vehicle_view_model.dart';
import 'package:witpark/MVVM/ViewModels/Vehicles/vehicle_view_model.dart';
import 'package:witpark/MVVM/Views/Page%20Decider/page_decider.dart';
import 'package:witpark/Provider/user_data_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginModelView(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingModelView(),
        ),
        ChangeNotifierProvider(
          create: (context) => VehicleModelView(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewVehicleModelView(),
        ),
        ChangeNotifierProvider(
          create: (context) => CityModelView(),
        ),
        ChangeNotifierProvider(
          create: (context) => UpdateProfileModelView(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditVehicleModelView(),
        ),
        ChangeNotifierProvider(
          create: (context) => UpdatePasswordModelView(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignupModelView(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.amber,
            textTheme: GoogleFonts.poppinsTextTheme()),
        home: const PageDecider(),
      ),
    ),
  );
}
