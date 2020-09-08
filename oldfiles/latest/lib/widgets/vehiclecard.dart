import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
VehicleCard({this.manufacturer, this.vehicleType, this.engineType, this.imageUrl, this.callBack});
  final String manufacturer;
  final String vehicleType;
  final String engineType;
  final Function callBack;
  final Widget imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 5,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  image: AssetImage('assets/images/landscape.png'),
                  fit: BoxFit.cover,
                )),
            child: Column(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.width * 0.37,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: imageUrl ??
                        // imageUrl != null ? Image.network(imageUrl) :
                        IconButton(
                          icon: Icon(Icons.add, size: 40,),
                          onPressed: () {
                            Navigator.pushNamed(context, '/vehiclereginapp');
                          },
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            manufacturer ?? 'Add New Vehicle',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Vehicle Type',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(vehicleType ?? 'N/A',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Engine Type',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(engineType ?? 'N/A',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: Colors.white, width: 1.0),
                              ),
                              child: Text(
                                "More Details",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onTap: callBack ?? (){},
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
  }
}
