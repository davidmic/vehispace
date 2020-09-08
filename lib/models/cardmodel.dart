

enum CardType {Visa, Verve, MasterCard, Other, Invalid}

class PaymentCardModel{
  CardType type;
  String number;
  String name;
  String expiryDate;
  String cvv;
  bool hasCard;
  String email;

  PaymentCardModel(
      {this.type, this.number, this.name, this.expiryDate, this.cvv, this.hasCard:false, this.email});
}