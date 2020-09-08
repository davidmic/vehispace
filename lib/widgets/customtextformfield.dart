import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {
//        this.icon,
        this.hint,
        this.obsecure = false,
        this.validator,
        this.onSaved,
        this.keyboardType,
        this.labelText,
        this.intialValue,
        this.readOnly:false,
        this.suffixIcon,
        this.suffix,
        this.controller,
        this.inputFormatters,
//        this.maxLines: 1,
//        this.maxLength: 50,
      });
  final FormFieldSetter<String> onSaved;
//  final Icon icon;
  final String hint;
  final bool obsecure;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final String labelText;
  final String intialValue;
  final bool readOnly;
  final Widget suffixIcon;
  final Widget suffix;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
//  final int maxLines;
//  final int maxLength;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(labelText ?? hint, style: TextStyle(fontSize: 14, fontFamily: 'Sansation', fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          height: MediaQuery.of(context).size.height*0.07 ,
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
//        maxLength: maxLines,
//        maxLines: maxLength,
            inputFormatters: inputFormatters,
            initialValue: intialValue,
            keyboardType: keyboardType,
            onSaved: onSaved,
            // onChanged: onSaved,
            validator: validator,
            autofocus: false,
            obscureText: obsecure,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Sansation',
              fontStyle: FontStyle.normal
            ),
            decoration: InputDecoration(
                suffixIcon: suffix,
                suffix: suffixIcon,
                filled: true,
                fillColor: Colors.pink.withOpacity(0.09),
//                labelText: hint,
                hintStyle: TextStyle(fontSize: 14, fontFamily: 'Sansation',),
                hintText: hint,
//            enabledBorder: OutlineInputBorder(
////              borderRadius: BorderRadius.circular(30),
//              borderSide: BorderSide(
//                color: Theme.of(context).primaryColor,
//                width: 2,
//              ),
//            ),
//            focusedBorder: OutlineInputBorder(
////              borderRadius: BorderRadius.circular(30),
//              borderSide: BorderSide(
//                color: Theme.of(context).primaryColor,
//                width: 3.0,
//              )
//            ),
                border: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
//            prefixIcon: Padding(
//              child: IconTheme(
//                data: IconThemeData(color: Theme.of(context).primaryColor),
//                child: icon,
//              ),
//              padding: EdgeInsets.only(left: 30, right: 10),
//            )
          ),
          ),
        ),
      ],
    );
  }
}