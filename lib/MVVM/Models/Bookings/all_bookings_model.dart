// To parse this JSON data, do
//
//     final allBookingsModel = allBookingsModelFromJson(jsonString);

import 'dart:convert';

AllBookingsModel allBookingsModelFromJson(String str) =>
    AllBookingsModel.fromJson(json.decode(str));

String allBookingsModelToJson(AllBookingsModel data) =>
    json.encode(data.toJson());

class AllBookingsModel {
  AllBookingsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<Datum>? data;

  factory AllBookingsModel.fromJson(Map<String, dynamic> json) =>
      AllBookingsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.bookingId,
    required this.bookingOwner,
    required this.bookingCity,
    required this.bookingPlace,
    required this.bookingArrival,
    required this.bookingDeparture,
    required this.bookingVehicle,
    required this.bookingAmount,
    required this.bookingPaymentDate,
    required this.bookingStatus,
    required this.bookingPaymentStatus,
    required this.bookingEntranceTime,
    required this.bookingExitTime,
  });

  final int? bookingId;
  final String? bookingOwner;
  final String? bookingCity;
  final String? bookingPlace;
  final DateTime? bookingArrival;
  final DateTime? bookingDeparture;
  final String? bookingVehicle;
  final String? bookingAmount;
  final DateTime? bookingPaymentDate;
  final String? bookingStatus;
  final String? bookingPaymentStatus;
  final dynamic bookingEntranceTime;
  final dynamic bookingExitTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bookingId: json["booking_id"],
        bookingOwner: json["booking_owner"],
        bookingCity: json["booking_city"],
        bookingPlace: json["booking_place"],
        bookingArrival: json["booking_arrival"] == null
            ? null
            : DateTime.parse(json["booking_arrival"]),
        bookingDeparture: json["booking_departure"] == null
            ? null
            : DateTime.parse(json["booking_departure"]),
        bookingVehicle: json["booking_vehicle"],
        bookingAmount: json["booking_amount"],
        bookingPaymentDate: json["booking_payment_date"] == null
            ? null
            : DateTime.parse(json["booking_payment_date"]),
        bookingStatus: json["booking_status"],
        bookingPaymentStatus: json["booking_payment_status"],
        bookingEntranceTime: json["booking_entrance_time"],
        bookingExitTime: json["booking_exit_time"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "booking_owner": bookingOwner,
        "booking_city": bookingCity,
        "booking_place": bookingPlace,
        "booking_arrival": bookingArrival == null
            ? null
            : "${bookingArrival!.year.toString().padLeft(4, '0')}-${bookingArrival!.month.toString().padLeft(2, '0')}-${bookingArrival!.day.toString().padLeft(2, '0')}",
        "booking_departure": bookingDeparture == null
            ? null
            : "${bookingDeparture!.year.toString().padLeft(4, '0')}-${bookingDeparture!.month.toString().padLeft(2, '0')}-${bookingDeparture!.day.toString().padLeft(2, '0')}",
        "booking_vehicle": bookingVehicle,
        "booking_amount": bookingAmount,
        "booking_payment_date": bookingPaymentDate == null
            ? null
            : "${bookingPaymentDate!.year.toString().padLeft(4, '0')}-${bookingPaymentDate!.month.toString().padLeft(2, '0')}-${bookingPaymentDate!.day.toString().padLeft(2, '0')}",
        "booking_status": bookingStatus,
        "booking_payment_status": bookingPaymentStatus,
        "booking_entrance_time": bookingEntranceTime,
        "booking_exit_time": bookingExitTime,
      };
}
