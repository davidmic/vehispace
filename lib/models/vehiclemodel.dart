
class VehicleModel {
  String userId;
  String vehicleId;
  String vehicleType;
  String manufacturer;
  String model;
  String regNo;
  String engineNo;
  String engineCapacity;
  String imageURL;
  String dateOfLastService;
  String millege;
  String createdDate;
  String userToken;
  String year;
  String engineType;

  VehicleModel({
    this.userId,
    this.vehicleId,
    this.vehicleType,
    this.manufacturer,
    this.model,
    this.regNo,
    this.engineNo,
    this.engineCapacity,
    this.imageURL,
    this.dateOfLastService,
    this.millege,
    this.createdDate,
    this.userToken,
    this.year,
    this.engineType,
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