import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';

class VehiclePaperRequestCard extends StatelessWidget {
 VehiclePaperRequestCard({
    this.title,
    this.dateTime,
    this.vehicleMake,
    this.registrationNumber,
    this.engineNumber,
    this.engineCapacity,
    this.roadWorthiness,
    this.insuranceRenewal,
    this.onPressed,
    this.status,
    this.isExpanded = false,
   this.model,
   this.year,
    });
  final String title;
  final String status;
  final String dateTime;
  final String vehicleMake;
  final String registrationNumber;
  final String engineNumber;
  final String engineCapacity;
  final String roadWorthiness;
  final String insuranceRenewal;
  final Function onPressed;
  final bool isExpanded;
  final String year;
  final String model;

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
                          child: Text(title ?? 'Vehicle Papers Renewal Requested',
                                style: TextStyle(color: Color(0xff003399),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sansation'
                                ),
                              ),
                        ),
                      ),
                   SizedBox(height: 15),
                   Text( status ?? 'Status: Order is being processed',
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
                headerAlignment: ExpandablePanelHeaderAlignment.center,
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
                    buildVehicleInfo(label: 'Vehicle Make:  ', value: vehicleMake ?? '',),
                    buildVehicleInfo(label: 'Model:  ', value: model ?? '',),
                    buildVehicleInfo(label: 'Year:  ', value: year ?? '',),
                    buildVehicleInfo(label: 'Registration Number:  ', value: registrationNumber ?? '',),
                    buildVehicleInfo(label: 'Engine Capacity:  ', value: engineCapacity ?? '0',),
                    buildVehicleInfo(label: 'Road Worthiness Renewal:  ', value: roadWorthiness ?? '',),
                    buildVehicleInfo(label: 'Insurance Renewal:  ', value: insuranceRenewal ?? '',),
                    // buildVehicleInfo(label: 'Additional Information', value: additionInfo ?? '',),
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


class OtherVehiclePaperRequestCard extends StatelessWidget {
 OtherVehiclePaperRequestCard({
    this.title, 
    this.dateTime, 
    this.vehicleMake, 
    this.brand, 
    this.modelYear, 
    this.engineCapacity, 
    this.roadWorthiness, 
    this.insuranceRenewal, 
    this.onPressed,
    this.isExpanded = false,
   this.status,
    });
  final String title;
  final String dateTime;
  final String vehicleMake;
  final String brand;
  final String modelYear;
  final String engineCapacity;
  final String roadWorthiness;
  final String insuranceRenewal;
  final Function onPressed;
  final bool isExpanded;
  final String status;

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0,8,5,0),
      child: Card(
        elevation: 1,
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
                          child: Text(title ?? 'No Text',
                                style: TextStyle(color: Color(0xff003399),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sansation'
                                ),
                              ),
                        ),
                      ),
                   SizedBox(height: 15),
                   Text( status ?? 'Status: ',
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
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
              ),
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //  width: MediaQuery.of(context).size.width * 0.55,
                     margin: EdgeInsets.only(left:75),
                     child: CustomRaisedButton(
                       onPressed: onPressed ?? (){},
                       text: 'Request Now',
                       textColor: Color(0xffff0000),
                       borderWidth: 1,
                       borderColor: Color(0xffff0000),
                       color: Colors.white,
                     )
                       ),
                ],
              ),
              collapsed: Container(),
              expanded: Container(),
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
          Text(
          label ?? '', 
            style: TextStyle(color: Color(0xff333333),
                    fontSize: 12  ,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sansation'
                    ),
            ),
          SizedBox(width: 20,),
          Text(value ?? '',
            style: TextStyle(color: Color(0xff333333),
                    fontSize: 12  ,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sansation'
                    ),
          ),
        ]
      ),
    );
  }
}
