
class VehicleModel {
  String userId;
  String vehicleId;
  String vehicle;
  String manufacturer;
  String model;
  String regNo;
  String engineNo;
  String engineCapacity;
  String imageURL;
  String dateOfLastService;
  String millege;
  String createdDate;

  VehicleModel({
    this.userId,
    this.vehicleId,
    this.vehicle,
    this.manufacturer,
    this.model,
    this.regNo,
    this.engineNo,
    this.engineCapacity,
    this.imageURL,
    this.dateOfLastService,
    this.millege,
    this.createdDate,
  });

  // factory VehicleModel.fromFirebase (Map<String, dynamic> json) {
  //   return
  //   json['userId'] = '';
  //   json['vehicleId'] = '';
  //   json['vehicle'] = '';
  //   json['manufacturer'] = '';
  //   json['regNo'] = '';
  //   json['engineNo'] = '';
  //   json['engineCapacity'] = '';
  //   json['imageURL'] = '';
  // }

}