
import 'dart:convert';

PlacesModel placesModelFromJson(String str) =>
    PlacesModel.fromJson(json.decode(str));

String placesModelToJson(PlacesModel data) => json.encode(data.toJson());

class PlacesModel {
  PlacesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<Datum>? data;

  factory PlacesModel.fromJson(Map<String, dynamic> json) => PlacesModel(
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
    required this.id,
    required this.placeName,
    required this.placeAvailableSlots,
    required this.placeSlotAvailableTime,
    required this.placeTotalSlots,
    required this.placeCity,
  });

  final int? id;
  final String? placeName;
  final int? placeAvailableSlots;
  final DateTime? placeSlotAvailableTime;
  final int? placeTotalSlots;
  final int? placeCity;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        placeName: json["place_name"],
        placeAvailableSlots: json["place_available_slots"],
        placeSlotAvailableTime: json["place_slot_available_time"] == null
            ? null
            : DateTime.parse(json["place_slot_available_time"]),
        placeTotalSlots: json["place_total_slots"],
        placeCity: json["place_city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "place_name": placeName,
        "place_available_slots": placeAvailableSlots,
        "place_slot_available_time": placeSlotAvailableTime == null
            ? null
            : placeSlotAvailableTime!.toIso8601String(),
        "place_total_slots": placeTotalSlots,
        "place_city": placeCity,
      };
}
