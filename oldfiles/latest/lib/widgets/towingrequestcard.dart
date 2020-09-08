import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';

class TowingRequestCard extends StatelessWidget {
  TowingRequestCard({
    this.title,
    this.status, 
    this.dateTime, 
    this.vehicleMake, 
    this.brand, 
    this.modelYear, 
    this.location, 
    this.destination,
    this.conditionOfVehicle, 
    this.casaulty, 
    this.additionInfo,
    this.onPressed,
    this.isExpanded = false,
    });
  final String title;
  final String dateTime;
  final String vehicleMake;
  final String brand;
  final String modelYear;
  final String location;
  final String destination;
  final String conditionOfVehicle;
  final String casaulty;
  final String additionInfo;
  final Function onPressed;
  final bool isExpanded;
  final String status;

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0,8,8,0),
      child: Card(
        elevation: 10,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Row(
                children: [
                  Padding(
                padding: EdgeInsets.fromLTRB(10,10,0,0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color(0xff003399), width: 1.0),
                        ),
                        child: Icon(Icons.notifications, color: Color(0xff003399),)),
                    SizedBox(height: 15,),
                    Text(dateTime ?? '00/00/00',
                      style: TextStyle(color: Color(0xffFF0000),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
                Container(
                  margin: EdgeInsets.only(left:15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height:17),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(title ?? 'Towing Service Requested',
                                style: TextStyle(color: Color(0xff003399),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sansation'
                                ),
                              ),
                        ),
                      ),
                   SizedBox(height: 15),
                   Text( status ?? 'Status', 
                     style: TextStyle(color: Color(0xff333333),
                     fontSize: 12,
                     fontWeight: FontWeight.normal,
                     fontFamily: 'Sansation'
                   ),
                   ),
                     ],
                    ),
                ),
                ],
              ),
            ),
            
            ExpandablePanel(
              theme: const ExpandableThemeData(
                // headerAlignment: ExpandablePanelHeaderAlignment.center,
                bodyAlignment: ExpandablePanelBodyAlignment.left,
                tapBodyToExpand: true,
                tapBodyToCollapse: true,
              ),
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                     width: MediaQuery.of(context).size.width * 0.55,
                     margin: EdgeInsets.only(left:75),
                     child: LinearProgressIndicator()
                       ),
                ],
              ),
              collapsed: Container(),
              expanded: Container(
                margin: EdgeInsets.only(left: 55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // SizedBox(height:20),
                    buildVehicleInfo(label: 'Vehicle Make: ', value: vehicleMake ?? '',),
                    buildVehicleInfo(label: 'Brand: ', value: brand ?? '',),
                    buildVehicleInfo(label: 'Model/Year: ', value: modelYear ?? '',),
                    buildVehicleInfo(label: 'Location: ', value: location ?? '',),
                    buildVehicleInfo(label: 'Destination: ', value: destination ?? ''),
                    buildVehicleInfo(label: 'Condition of Vehicle: ', value: conditionOfVehicle ?? '',),
                    buildVehicleInfo(label: 'Casaulty: ', value: casaulty ?? '',),
                    buildVehicleInfo(label: 'Additional Information: ', value: additionInfo ?? '',),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CustomRaisedButton(
                        color: Colors.white,
                        borderWidth: 1.0,
                        borderColor: Color(0xff003399),
                        onPressed: onPressed ?? (){}, 
                        text: 'Edit',
                        textColor: Color(0xff003399),
                        ),
                    ),
                  ],
                ),
              ),
            builder:  isExpanded == true ?  (_, collapsed, expanded) {
                return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Expandable(
                    collapsed: expanded,
                    expanded: collapsed,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  ),
                );
              } : (_, collapsed, expanded) {
                return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVehicleInfo({
    String label,
    String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Column(
            children: [
              Text(
              label ?? '', 
            style: TextStyle(color: Color(0xff333333),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sansation'
                    ),
            ),
            ]
          ),
          // Spacer(),
          // SizedBox(width: 20), 
           Flexible(
              child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(value ?? '',
                 softWrap: true,
                 style: TextStyle(color: Color(0xff333333),
                         fontSize: 12  ,
                         fontWeight: FontWeight.bold,
                         fontFamily: 'Sansation'
                         ),
                   ),
              ]
            ),
           ),
          
          // SizedBox(width: 60,),
        ]
      ),
    );
  }
}
