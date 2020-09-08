
class VehiclePapersModel {
  String country;
  String state;
  String pin;
  String registrationNumber;
  String engineNumber;
  String vehicleMake;
  String colour;
  String engineCapacity;
  String transactionDate;
  String dateIssued;
  String expiryDate;
  String roadWorthiness;
  String insuranceRenewal;
  String requestTime;
  String vehicleId;
  String roadWorthinessType;
  String insuranceRenewalType;
  int roadWorthinessPrice;
  int insuranceRenewalPrice;
  int vehicleLicensePrice;
  String requestDate;
  String userToken;
  String year;
  String model;

  VehiclePapersModel({
    this.country,
    this.state,
    this.pin,
    this.registrationNumber,
    this.engineNumber,
    this.vehicleMake,
    this.colour,
    this.engineCapacity,
    this.transactionDate,
    this.dateIssued,
    this.expiryDate,
    this.roadWorthiness,
    this.insuranceRenewal,
    this.roadWorthinessType,
    this.insuranceRenewalType,
    this.roadWorthinessPrice,
    this.vehicleLicensePrice,
    this.insuranceRenewalPrice,
    this.requestTime,
    this.requestDate,
    this.vehicleId,
    this.userToken,
    this.year,
    this.model,
  });

  factory VehiclePapersModel.fromFirebase (Map<String, dynamic> data) {
    return VehiclePapersModel(
      country: data['country'],
      state: data['state'],
      pin: data['pin'],
      registrationNumber: data['registrationNumber'],
      engineNumber: data['engineNumber'],
      vehicleMake: data['vehicleMake'],
      colour: data['colour'],
      engineCapacity: data['engineCapacity'],
      transactionDate: data['transactionDate'],
      dateIssued: data['dateIssued'],
      expiryDate: data['expiryDate'],
      roadWorthiness: data['roadWorthiness'],
      insuranceRenewal: data['insuranceRenewal'],
      insuranceRenewalType: data['insuranceRenewalType'],
      roadWorthinessType: data['roadWorthinessType'],
      insuranceRenewalPrice: data['insuranceRenewalPrice'],
      roadWorthinessPrice: data['roadWorthinessPrice'],
      vehicleLicensePrice: data['vehicleLicensePrice'],
      requestTime: data['requestTime'],
      requestDate: data['requestDate'],
      vehicleId: data['vehicleId'],
    );
  }
}