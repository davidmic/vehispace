import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatelessWidget {

  MyDatePicker({this.hintText, this.labelText, this.onSaved, this.customFormat, this.firstDate, this.lastDate, this.validator, this.initialValue});
  final String labelText;
  final String hintText;
  final Function onSaved;
  final customFormat;
  final format = DateFormat('dd-MM-yyyy');
  final DateTime firstDate;
  final DateTime lastDate;
  final validator;
  final initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(labelText, style: TextStyle(fontSize: 14, fontFamily: 'Sansation', fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          height: MediaQuery.of(context).size.height*0.07 ,
          child: DateTimeField(
            initialValue: initialValue,
            validator: validator,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.pink.withOpacity(0.09),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(fontSize: 14, fontFamily: 'Sansation',),
                hintText: hintText,
            ),
            format: customFormat ?? format,
            onShowPicker: (context, value) {
              return showDatePicker(
                  context: context,
                  initialDate: value ?? DateTime.now(),
                  firstDate: firstDate ?? DateTime(1990),
                  lastDate: lastDate ?? DateTime(2030)
              );
            },
            onSaved: onSaved,
          ),
        ),
      ],
    );
  }
}

class MyTimePicker extends StatelessWidget {

  MyTimePicker({this.hintText, this.labelText, this.onSaved});
  final String labelText;
  final String hintText;
  final Function onSaved;
  final format = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(labelText, style: TextStyle(fontSize: 14, fontFamily: 'Sansation', fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          height: MediaQuery.of(context).size.height*0.07 ,
          child: DateTimeField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.pink.withOpacity(0.09),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(fontSize: 14, fontFamily: 'Sansation',),
              hintText: hintText,
            ),
            format: format,
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
            onSaved: onSaved,
          ),
        ),
      ],
    );
  }
}