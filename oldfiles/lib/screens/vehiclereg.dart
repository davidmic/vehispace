import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/customdropdown.dart';
import '../widgets/customtextformfield.dart';
import '../widgets/customraisedbutton.dart';


class MyVehicleRegistration extends StatelessWidget {
  String vehicle;
  String manufacturer;
  List<String> vehiclelist = ['Honda', 'Toyota', 'Kia'];
  List<String> manufacturerlist = ['Honda', 'Toyota', 'Kia'];
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.close,
                        size: 40,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Vehicle Registration',
                          style: TextStyle(
                            color: Color(0xff003399),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sansation',
                            fontSize: 34,
                          ),
                        ),
                        Text(
                          'Enter your vehicle, manufacturer and model',
                          style: TextStyle(
                            color: Colors.black54,
//                              fontWeight: FontWeight.bold,
                            fontFamily: 'Sansation',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    CustomDropdown(
                        value: vehicle,
                        onChanged: (val){
                          vehicle = val;
                        },
                        items: vehiclelist,
                        labelText: 'Vehicle'
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomDropdown(
                        value: manufacturer,
                        onChanged: (val){
                          manufacturer = val;
                        },
                        items: manufacturerlist,
                        labelText: 'Manufacturer'
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      validator: (val){
                        if (val.isEmpty){
                          return 'Enter Model';
                        }
                        return null;
                      },
//                        icon: Icon(Icons.security),
                      hint: 'Model',
                      onSaved: (val) {
//                        pass = val;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      validator: (val){
                        if (val.isEmpty){
                          return 'Enter Vehicle Registration Number';
                        }
                        return null;
                      },
//                        icon: Icon(Icons.security),
                      hint: 'Vehicle Registration Number',
                      onSaved: (val) {
//                        pass = val;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      validator: (val){
                        if (val.isEmpty){
                          return 'Enter Engine Number';
                        }
                        return null;
                      },
//                        icon: Icon(Icons.security),
                      hint: 'Engine Number',
                      onSaved: (val) {
//                        pass = val;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      validator: (val){
                        if (val.isEmpty){
                          return 'Enter Engine Capacity';
                        }
                        return null;
                      },
//                        icon: Icon(Icons.security),
                      hint: 'Engine Capacity',
                      onSaved: (val) {
//                        pass = val;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Builder(
                      builder: (context) => SizedBox(
                        width: MediaQuery.of(context).size.width*0.95,
                        height: MediaQuery.of(context).size.height*0.07,
                        child: CustomRaisedButton(
                          onPressed: () async {
                            Navigator.popAndPushNamed(context, '/offerservices');
//                            if (!_formkey.currentState.validate()) {
//                              return;
//                            }
//                            _formkey.currentState.save();
//                            Scaffold.of(context).showSnackBar(
//                              SnackBar(
//                                content: Text('Processing Data'),
//                              ),
//                            );
                          },
                          text: 'REGISTER',
                          elevation: 5.0,
                          color: Color(0xff003399),
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'Go Back',
                            style: Constants.redText,
                          ),
                          onPressed: () {
//                            Navigator.pushNamed(context, '/register');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
