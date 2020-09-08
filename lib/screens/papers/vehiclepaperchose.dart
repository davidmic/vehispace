import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';
import 'package:vehispace/screens/papers/vehiclepapersevice.dart';
import 'package:vehispace/screens/towing/towingservice.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';

class ChooseVehiclePapers extends StatefulWidget {
  Function onPressed;
  Function existingVehicleOnpressed;
  int index;
  ChooseVehiclePapers({this.onPressed, this.existingVehicleOnpressed, this.index});
  @override
  _ChooseVehiclePapersState createState() => _ChooseVehiclePapersState();
}

class _ChooseVehiclePapersState extends State<ChooseVehiclePapers> {
  @override
  Widget build(BuildContext context) {
    var myVehicleBloc = Provider.of<MyVehicleBloc>(context);
    return ListView(
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Request Vehicle Paper Renewal for new or existing vehicle',
                  style: TextStyle(
                    color: Colors.black,
                                fontWeight: FontWeight.bold,
                    fontFamily: 'Sansation',
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  title: Text('Existing Vehicle',
                    style: TextStyle(
                      color: Color(0xff003399),
                              fontWeight: FontWeight.bold,
                      fontFamily: 'Sansation',
//                      fontSize: 14,
                    ),
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: myVehicleBloc.vehiclesDetails.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(myVehicleBloc.vehiclesDetails[index]['manufacturer'] + " " + myVehicleBloc.vehiclesDetails[index]['model'] + " " + myVehicleBloc.vehiclesDetails[index]['year'],
                              style: TextStyle(
                                color: Colors.black,
//                              fontWeight: FontWeight.bold,
                                fontFamily: 'Sansation',
//                                fontSize: 16,
                              ),
                            ),
                            onTap: (){
                              VehiclePaperService.itemIndex = index;
                              widget.existingVehicleOnpressed();
                            },
                          );
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.95,
                  height: MediaQuery.of(context).size.height*0.06 ,
                  child: CustomRaisedButton(
                    onPressed: (){
                      widget.onPressed();
                    },
                    text: 'Use Unregistered Vehicle',
                    color: Colors.white,
                    borderColor: Color(0xff003399),
                    textColor: Color(0xff003399),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
