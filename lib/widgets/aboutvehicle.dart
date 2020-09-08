import 'package:flutter/material.dart';

class MoreDetailsVehicle extends StatelessWidget {
  MoreDetailsVehicle({this.manufacturer, this.vehicleType, this.engineType, this.imageURL, this.closeCallback, this.content = '', this.model});
  final String manufacturer;
  final String vehicleType;
  final String engineType;
  final Widget imageURL;
  final Function closeCallback;
  final String content;
  final String model;
  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 5,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.93,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
              image: AssetImage('assets/images/landscape.png'),
              fit: BoxFit.cover,
            )
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: closeCallback,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Container(
                  child:
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.width * 0.37,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: imageURL,
//                                imageUrl != null ? Image.network(imageUrl) :
                          // IconButton(
                          //   icon: Icon(Icons.add),
                          //   onPressed: (){},
                          // ),
                        ),
                        SizedBox(width: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(manufacturer ?? 'Add New Vehicle', style: TextStyle(color: Colors.white),),
                                Text(model.substring(0, model.length < 20 ? model.length : 20) ?? 'Add New Vehicle', style: TextStyle(color: Colors.white),),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text('Vehicle Type', style: TextStyle(color: Colors.white)),
                            SizedBox(height: 5,),
                            Text( vehicleType ?? 'N/A', style: TextStyle(color: Colors.white)),
                            SizedBox(height: 5,),
                            Text('Engine Type', style: TextStyle(color: Colors.white)),
                            SizedBox(height: 5,),
                            Text( engineType ?? 'N/A', style: TextStyle(color: Colors.white)),
                            SizedBox(height: 5,),
                          ],
                          )
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0,10.0,0,5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Vehicle Overview: ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Sensation'), ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Scrollbar(
                    controller: ScrollController(),
                    child: Text(content ?? 'No Specific Tip', style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12, fontFamily: 'Sensation'),
//                                  readMore,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                ]
              ),
//                Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Vehicle Overview:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Sensation'), ),
//                    Padding(
//                      padding: EdgeInsets.all(15.0),
//                      child: Scrollbar(
//                        controller: ScrollController(),
//                        child: Text( 'tdhd hdhdhhd dhdhdhd dshsdhdss dshsdhhsdhsd dshsdhsdh shshsd d hshs shshsd shs s hshs s shshsdhdhsd dhsdhs shd s shdhdhhd dhshsh sdhks chhd shd dhcbhdh c c',
////                                  readMore,
//                          softWrap: true,
//                          overflow: TextOverflow.fade,
//                        ),
//                      ),
//                    ),
//                  ],
//                ),

                Positioned(
                  bottom: 10,
                  left: 25,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.85,
                        height: MediaQuery.of(context).size.height*0.07,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                        child: Center(
                          child: Text(
                            "Go Back",
                            style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: closeCallback,
              ),
            ),
                ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
