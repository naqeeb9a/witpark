import 'dart:convert';

VehiclesModel vehiclesModelFromJson(String str) =>
    VehiclesModel.fromJson(json.decode(str));

String vehiclesModelToJson(VehiclesModel data) => json.encode(data.toJson());

class VehiclesModel {
  VehiclesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<Datum>? data;

  factory VehiclesModel.fromJson(Map<String, dynamic> json) => VehiclesModel(
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
    required this.vehicleId,
    required this.vehicleOwner,
    required this.vehicleName,
    required this.vehicleModel,
    required this.vehicleColor,
    required this.vehicleNoPlate,
  });

  final int? vehicleId;
  final String? vehicleOwner;
  final String? vehicleName;
  final int? vehicleModel;
  final String? vehicleColor;
  final String? vehicleNoPlate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        vehicleId: json["vehicle_id"],
        vehicleOwner: json["vehicle_owner"],
        vehicleName: json["vehicle_name"],
        vehicleModel: json["vehicle_model"],
        vehicleColor: json["vehicle_color"],
        vehicleNoPlate: json["vehicle_no_plate"],
      );

  Map<String, dynamic> toJson() => {
        "vehicle_id": vehicleId,
        "vehicle_owner": vehicleOwner,
        "vehicle_name": vehicleName,
        "vehicle_model": vehicleModel,
        "vehicle_color": vehicleColor,
        "vehicle_no_plate": vehicleNoPlate,
      };
}
