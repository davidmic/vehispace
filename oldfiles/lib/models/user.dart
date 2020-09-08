
class User{
  String email;
  String password;
  User.create({this.email, this.password});
}

class NewUser {
  String firstName;
  String middleName;
  String lastName;
  String email;
  String phoneNumber;
  String passowrd;
  String referralCode;

  NewUser({this.firstName, this.middleName, this.lastName, this.email, this.phoneNumber, this.passowrd, this.referralCode});
}