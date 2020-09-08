
class User{
  String email;
  String password;
  User.create({
    this.email, 
    this.password
  });
}

class NewUser {
  String uid;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String phoneNumber;
  String country;
  String state;
  String lga;
  String passoword;
  String referralCode;
  String driverLicense;
  String driverLicenseExpiry;
  String gender;
  String imageURL;
  String createdDate;

  NewUser({
    this.firstName,
    this.middleName, 
    this.lastName, 
    this.country = '', 
    this.email, 
    this.state = '', 
    this.lga = '', 
    this.uid, 
    this.phoneNumber = '', 
    this.passoword, 
    this.referralCode = '', 
    this.driverLicense = '',
    this.driverLicenseExpiry = '',
    this.gender = '',
    this.imageURL = '',
    this.createdDate,
  });
}