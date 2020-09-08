import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/models/cardmodel.dart';
import 'package:vehispace/provider/addcardbloc.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:vehispace/userauth/authchecker.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/utils/validator.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:intl/intl.dart';
import 'package:vehispace/widgets/datepicker.dart';

enum CardType {Visa, Verve, MasterCard, Other, Invalid}

class AddCard extends StatefulWidget {

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final format = DateFormat('MM/yy');
  var _formKey = GlobalKey<FormState>();
  String cardNumber;
  String cardName;
  String cardCVV;
  int expiryMonth;
  int expiryYear;
  bool _saving = false;

  var _store = Firestore.instance;

  DateTime dateTime;

  @override
  Widget build(BuildContext context) {
  var addCardBloc = Provider.of<AddCardBloc>(context);
  var userProBloc = Provider.of<UserProfile>(context);
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xff003399),
        ),
        backgroundColor: Color(0xfff4f4f4),
        centerTitle: true,
        title: Text(
          'Add Card',
          style: Constants.appBarTitleColor,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _store.collection('usermanagement').document(userProBloc.userid).snapshots(),
        builder: (context, snapshot) {
          Widget page;
          if (!snapshot.hasData) {
            page = ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        CustomTextField(
                          suffix: Icon(Icons.credit_card),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(19),
                          ],
                          intialValue: '',
                          labelText: 'Card Number',
                          hint: 'Card Number',
                          onSaved: (val) {
                            cardNumber = val;
                          },
                          keyboardType: TextInputType.number,
                          validator: MyValidator.validateCardNumWithLuhnAlgorithm,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                        CustomTextField(
                          intialValue: '',
                          labelText: 'Card Holder Name',
                          hint: 'Card Holder Name',
                          onSaved: (val) {
                            cardName = val;
                          },
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Field is Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child:
                              MyDatePicker(
                                labelText: 'Expiry Date',
                                hintText: 'Expiry Date',
                                onSaved: (val) {
                                  dateTime = val;
                                },
                                customFormat: format,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: CustomTextField(
                                  hint: 'Security Code',
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  onSaved: (val) {
                                    cardCVV = val;
                                  },
                                  keyboardType: TextInputType.number,
                                  validator: MyValidator.cVVCheck
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.95,
                          height: MediaQuery.of(context).size.height*0.08,
                          child: CustomRaisedButton(
                            onPressed: () async {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              _formKey.currentState.save();
                              print('Values are ready');
                              setState(() {
                                _saving = true;
                              });
                              await addCardBloc.addCard(
                                myCard: PaymentCardModel(
                                  name: cardName,
                                  number: cardNumber,
                                  cvv: cardCVV,
                                  expiryDate: format.format(dateTime),
                                ),
                              );
                              setState(() {
                                _saving = false;
                              });
                              if (addCardBloc.status == cardStatus.Added) {
                                showDialog(
                                  context: context,
                                  builder: (context) => ValidUser(),
                                );
                              } else if (addCardBloc.status == cardStatus.Failed) {
                                showDialog(
                                  context: context,
                                  builder: (context) => InValidUser(
                                    message: AddCardBloc.message,
                                  ),
                                );
                              }
//                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyNotification()));
                            },
                            text: 'SAVE',
                            textColor: Colors.white,
                            color: Color(0xff003399),
                            borderColor: Color(0xff003399),
                            borderWidth: 0.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          else if (snapshot.hasData){
            var data = snapshot.data;
            if (data['hasCard'] == false ) {
              page = ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          CustomTextField(
                            suffixIcon: Image.asset('assets/images/cardtypea.png'),
//                            suffix: Icon(Icons.credit_card),
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(19),
                            ],
                            intialValue: '',
                            labelText: 'Card Number',
                            hint: 'Card Number',
                            onSaved: (val) {
                              cardNumber = val;
                            },
                            keyboardType: TextInputType.number,
                            validator: MyValidator.validateCardNumWithLuhnAlgorithm,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          CustomTextField(
                            intialValue: '',
                            labelText: 'Card Holder Name',
                            hint: 'Card Holder Name',
                            onSaved: (val) {
                              cardName = val;
                            },
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Field is Required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child:
                                MyDatePicker(
                                  labelText: 'Expiry Date',
                                  hintText: 'Expiry Date',
                                  onSaved: (val) {
                                    dateTime = val;
                                  },
                                  customFormat: format,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2025),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: CustomTextField(
                                    hint: 'Security Code',
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(3),
                                    ],
                                    onSaved: (val) {
                                      cardCVV = val;
                                    },
                                    keyboardType: TextInputType.number,
                                    validator: MyValidator.cVVCheck
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),

                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.95,
                            height: MediaQuery.of(context).size.height*0.08,
                            child: CustomRaisedButton(
                              onPressed: () async {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                _formKey.currentState.save();
                                print('Values are ready');
                                setState(() {
                                  _saving = true;
                                });
                                await addCardBloc.addCard(
                                  myCard: PaymentCardModel(
                                    name: cardName,
                                    number: cardNumber,
                                    cvv: cardCVV,
                                    expiryDate: format.format(dateTime),
                                  ),
                                );
                                setState(() {
                                  _saving = false;
                                });
                                if (addCardBloc.status == cardStatus.Added) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AddCardSuccessful(),
                                  );
                                } else if (addCardBloc.status == cardStatus.Failed) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => InValidUser(
                                      message: AddCardBloc.message,
                                    ),
                                  );
                                }
//                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyNotification()));
                              },
                              text: 'SAVE',
                              textColor: Colors.white,
                              color: Color(0xff003399),
                              borderColor: Color(0xff003399),
                              borderWidth: 0.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              page = ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        CustomTextField(
//                            suffix: Icon(Icons.credit_card),
                          suffixIcon: Image.asset('assets/images/cardtypea.png'),
                          readOnly: true,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(19),
                          ],
                          intialValue: data['cardNumber'],
                          labelText: 'Card Number',
                          hint: 'Card Number',
                          onSaved: (val) {
                            cardNumber = val;
                          },
                          keyboardType: TextInputType.number,
                          validator: MyValidator.validateCardNumWithLuhnAlgorithm,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                        CustomTextField(
                          intialValue: data['cardName'],
                          readOnly: true,
                          labelText: 'Card Holder Name',
                          hint: 'Card Holder Name',
                          onSaved: (val) {
                            cardName = val;
                          },
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Field is Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child:
                              CustomTextField(
                                intialValue: data['expiryDate'],
                                readOnly: true,
                                labelText: 'Expiry Date',
                                hint: 'Expiry Date',
                                onSaved: (val) {
                                  cardName = val;
                                },
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: CustomTextField(
                                readOnly: true,
                                intialValue: data['cvv'],
                                  hint: 'Security Code',
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  onSaved: (val) {
                                    cardCVV = val;
                                  },
                                  keyboardType: TextInputType.number,
                                  validator: MyValidator.cVVCheck
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        _saving ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(backgroundColor: Color(0xff003399),),
                        ],) : Container(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.95,
                          height: MediaQuery.of(context).size.height*0.08,
                          child: CustomRaisedButton(
                            onPressed: () async {
                              setState(() {
                                _saving = true;
                              });
                              await addCardBloc.deleteCard();
                              setState(() {
                                _saving = false;
                              });
                            },
                            text: 'DELETE',
                            textColor: Colors.white,
                            color: Color(0xffff0000),
                            borderColor: Color(0xffff0000),
                            borderWidth: 0.0,
                          ),
                        ),
                        SizedBox(height: 20,),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            children: <Widget>[
//                              SizedBox(
//                                width: MediaQuery.of(context).size.width * 0.7,
//                                child: CustomTextField(
//                                  intialValue: data['cardNumber'],
//                                  suffixIcon: Image.asset('assets/images/cardtypea.png'),
//                                  hint: "Card",
//                                  readOnly: true,
//                                  labelText: 'Card',
//                                  onSaved: (val) {
//                                  },
//                                  keyboardType: TextInputType.text,
//                                  validator: (val) {
//                                    if (val.isEmpty) {
//                                      return 'Field is Required';
//                                    }
//                                    return null;
//                                  },
//                                ),
//                              ),
//                              SizedBox(width: 0,),
//                              IconButton(
//                                  icon: Icon(Icons.delete,
//                                  color: Colors.red,
//                                    size: 30,
//                                  ),
//                                  onPressed: null
//                              ),
//                            ],
//                          ),
                      ],
                    ),
                  )
                ],
              );
            }
          }
          return page;
        }
      ),
    );
  }
}
