import 'package:flutter/material.dart';
import 'package:vehispace/screens/notification.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:vehispace/widgets/datepicker.dart';

class AddCard extends StatelessWidget {
  final format = DateFormat('MM / yy');
  DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      appBar: AppBar(
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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                CustomTextField(
                  suffix: Icon(Icons.credit_card),
                  intialValue: '',
                  labelText: 'Card Number',
                  hint: 'Card Number',
                  onSaved: (val) {},
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

                CustomTextField(
                  intialValue: '',
                  labelText: 'Card Holder Name',
                  hint: 'Card Holder Name',
                  onSaved: (val) {},
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
                        labelText: 'Expory Date',
                        hintText: 'Expiry Date',
                        onSaved: (val) {
                          dateTime = val;
                        },
                        customFormat: format,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2024),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: CustomTextField(
                        intialValue: '',
                        hint: 'Security Code',
                        onSaved: (val) {},
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Field is Required';
                          }
                          return null;
                        },
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
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyNotification()));
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
          )
        ],
      ),
    );
  }
}
