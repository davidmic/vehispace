class TowingModel {
  String userId;
  String vehicleId;
  String vehicle;
  String brand;
  String model;
  String country;
  String state;
  String lga;
  String location;
  double latitude;
  double longitude;
  String destination;
  double destLatitude;
  double destLongitude;
  String conditionOfVehicle;
  String casualty;
  String additionalInfo;
  String requestDate;
  String requestTime;

  TowingModel({
    this.userId,
    this.vehicleId,
    this.vehicle,
    this.brand,
    this.model,
    this.country,
    this.state,
    this.lga,
    this.location,
    this.latitude,
    this.longitude,
    this.destination,
    this.destLatitude,
    this.destLongitude,
    this.conditionOfVehicle,
    this.casualty,
    this.additionalInfo,
    this.requestTime,
    this.requestDate
  });

  TowingModel.fromFirebase (Map<String, dynamic> data) {
    TowingModel(
      userId: data['userId'],
      vehicleId: data['vehicleId'],
      vehicle: data['vehicle'],
      brand: data['brand'],
      model: data['model'],
      country: data['country'],
      state: data['state'],
      lga: data['lga'],
      location: data['location'],
      destination: data['desination'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      destLatitude: data['destLatitude'],
      destLongitude: data['destLongitude'],
      conditionOfVehicle: data['conditionOfVehicle'],
      casualty: data['casualty'],
      additionalInfo: data['additionalInfo'],
      requestTime: data['requestTime'],
      requestDate: data['requestDate'],

    );
  }
}