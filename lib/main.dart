import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:witpark/MVVM/ViewModels/Authentication/login_view_model.dart';
import 'package:witpark/MVVM/Views/Page%20Decider/page_decider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginModelView(),
        )
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
