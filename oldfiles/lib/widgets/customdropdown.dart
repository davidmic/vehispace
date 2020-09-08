import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  CustomDropdown(
      {this.hintText,
      this.isExpanded: true,
      this.isDense: false,
      @required this.value,
      this.icon,
      @required this.onChanged,
      @required this.items,
        @required this.labelText,
//      @required this.DMchild,
//      @required this.DMvalue
      });
  final String hintText;
  final bool isExpanded;
  final bool isDense;
  final dynamic value;
  final Icon icon;
  final Function onChanged;
  final List<dynamic> items;
  final String labelText;
//  final dynamic DMvalue;
//  final dynamic DMchild;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text(labelText ?? hintText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
    SizedBox(height: 10,),
        Container(
          height: MediaQuery.of(context).size.height*0.07,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.09),
          border: Border(top: BorderSide.none, bottom: BorderSide.none, left: BorderSide.none, right: BorderSide.none,),
          borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton(
        focusColor: Colors.pink.withOpacity(0.09),
        hint: Text(hintText ?? labelText),
        isDense: isDense,
        isExpanded: isExpanded,
        value: value,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem>((dynamic value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          );
        }).toList(),
      ),
    )
    ]
    );
  }
}
