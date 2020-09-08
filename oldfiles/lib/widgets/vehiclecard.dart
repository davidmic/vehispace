import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';

class VehicleCard extends StatelessWidget {
VehicleCard({this.vehicle, this.vehicleType, this.engineType, this.readMore, this.imageUrl});
  final String vehicle;
  final String vehicleType;
  final String engineType;
  final String readMore;
  final String imageUrl;
//  double h;

  @override
  Widget build(BuildContext context) {

    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5,
              child: Container(
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
                      child: Builder  (
                        builder: (context) {
                          var controller = ExpandableController.of(context);
                          return controller.expanded ? Container(
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: (){
                                controller.toggle();
                              },
                            ),
                          )
                              :
                          Container(
                          );
                        },
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  height: MediaQuery.of(context).size.width * 0.37,

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: imageUrl != null ? Image.network(imageUrl) : IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: (){},
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 5,),
                                    Text(vehicleType ?? 'Add New Vehicle', style: TextStyle(color: Colors.white),),
                                    SizedBox(height: 5,),
                                    Text('Vehicle Type', style: TextStyle(color: Colors.white)),
                                    SizedBox(height: 5,),
                                    Text( vehicleType ?? 'N/A', style: TextStyle(color: Colors.white)),
                                    SizedBox(height: 5,),
                                    Text('Engine Type', style: TextStyle(color: Colors.white)),
                                    SizedBox(height: 5,),
                                    Text( engineType ?? 'N/A', style: TextStyle(color: Colors.white)),
                                    SizedBox(height: 5,),
                                    Builder(
                                      builder: (context) {
                                        var controller = ExpandableController.of(context);
                                        return controller.expanded ? Container()
                                            :
                                        GestureDetector(
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              border: Border.all(color: Colors.white, width: 1.0),
                                            ),
                                            child: Text(
                                              "More Details",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                          onTap: () {
//                                            h = MediaQuery.of(context).size.height;
                                            controller.toggle();
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

//                        ),
                        ),
                        Expandable(
                          collapsed: Container(),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Scrollbar(
                                  controller: ScrollController(),
                                  child: Text(
                                    readMore,
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Builder(
                            builder: (context) {
                              var controller = ExpandableController.of(context);
                              return controller.expanded ?
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
                                onTap: () {
                                  controller.toggle();
                                },
                              )
                                  :
                              Container();
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),


                  ],
                ),
              ),
            ),
//            Text('Ussjhdshjdhjdfhj')
          ],
        ),
      ),
    );
  }
}
