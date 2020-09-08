import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/customdropdown.dart';
import '../widgets/customtextformfield.dart';
import '../widgets/customraisedbutton.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class TowingService extends StatefulWidget {
  @override
  _TowingServiceState createState() => _TowingServiceState();
}

class _TowingServiceState extends State<TowingService> {
//  Completer<GoogleMapController> _controller = Completer();
  String vehicle;

  String manufacturer;

  List<String> vehiclelist = ['Honda, Toyota, Kia'];

  List<String> manufacturerlist = ['Honda, Toyota, Kia'];

  int wbuild = 0;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget v;
    wbuild == 0 ?
    v = Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,5,15,10),
          child: Container(
            color: Color(0xffe5e5e5),
            child: Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               SizedBox(height: 10,),
            CustomTextField(
            hint: 'Country',
              onSaved: (val) {
//            lastName = val;
              },
              keyboardType: TextInputType.text,
              validator: (val) {
                if(val.isEmpty){
                  return 'Country is Required';
                }
                return null;
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
                CustomTextField(
                  hint: 'State',
                  onSaved: (val) {
//            lastName = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'State is Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  hint: 'Local Government Area',
                  onSaved: (val) {
//            lastName = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'LGA is Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  hint: 'Vehile Make',
                  onSaved: (val) {
//            lastName = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'Vehicle Make is Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  hint: 'Brand',
                  onSaved: (val) {
//            lastName = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'Brand is Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  hint: 'Model/Year',
                  onSaved: (val) {
//            lastName = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'Model/Year is Required';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  hint: 'Location',
                  onSaved: (val) {
//            lastName = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'Location is Required';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  hint: 'Destination',
                  onSaved: (val) {
//            lastName = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'Destination is Required';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomDropdown(
                    value: vehicle,
                    onChanged: (val){
                      vehicle = val;
                    },
                    items: vehiclelist,
                    labelText: 'Condition of Vehicle'
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  hint: 'Casaulty',
                  onSaved: (val) {
//            lastName = val;
                  },
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if(val.isEmpty){
                      return 'Casaulty is Required';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

                CustomTextField(
                  hint: 'Additional Information',
                  onSaved: (val) {
//            lastName = val;
                  },
                  keyboardType: TextInputType.text,
//              validator: (val) {
//                if(val.isEmpty){
//                  return 'Location is Required';
//                }
//                return null;
//              },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Builder(
                  builder: (context) => SizedBox(
                    width: MediaQuery.of(context).size.width*0.95,
                    height: MediaQuery.of(context).size.height*0.07,
                    child: CustomRaisedButton(
                      onPressed: () {
                        setState(() {
                          wbuild = 1;
                        });
//                        if (!_formkey.currentState.validate()) {
//                          return;
//                        }
//                        _formkey.currentState.save();
//                        Scaffold.of(context).showSnackBar(
//                          SnackBar(
//                            content: Text('Processing Data'),
//                          ),
//                        );
                      },
                      text: 'REQUEST TOWING SERVICE',
                      elevation: 5.0,
                      color: Color(0xff003399),
                      textColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ):
    v = Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
    fit: StackFit.expand,
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(6.605874, 3.349149),
            zoom: 10,
          ),
          mapType: MapType.normal,
        ),
      ],
    ),
    );
    return v;
  }
}
