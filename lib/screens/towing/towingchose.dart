import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/provider/appbartitle.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';
import 'package:vehispace/screens/towing/towingservice.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';

class ChooseVehicle extends StatefulWidget {
  Function onPressed;
  Function existingVehicleOnpressed;
  int index;
  ChooseVehicle({this.onPressed, this.existingVehicleOnpressed, this.index});
  @override
  _ChooseVehicleState createState() => _ChooseVehicleState();
}

class _ChooseVehicleState extends State<ChooseVehicle> {
  @override

  void initState(){
    super.initState();
    AppBarTitle().appBarTitle = 'Towing Information';
  }
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
                  'Request Towing Service for new or existing vehicle',
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
//                      fontSize: 20,
                    ),
                  ),
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: myVehicleBloc.vehiclesDetails.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(myVehicleBloc.vehiclesDetails[index]['manufacturer'] + " " + myVehicleBloc.vehiclesDetails[index]['model'] + " " + myVehicleBloc.vehiclesDetails[index]['year']),
                            onTap: (){
                              TowingService.itemIndex = index;
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
                  height: MediaQuery.of(context).size.height*0.05,
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
