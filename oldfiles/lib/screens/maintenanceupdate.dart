import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vehispace/widgets/customsearchbar.dart';
import 'package:vehispace/widgets/notificationcard.dart';
import 'package:vehispace/widgets/vehiclecard.dart';

class MaintenanceUpdate extends StatefulWidget {
  @override
  _MaintenanceUpdateState createState() => _MaintenanceUpdateState();
}

class _MaintenanceUpdateState extends State<MaintenanceUpdate> {
  Search search = Search();
  String lorem =
      'Take the 2010 Toyota Camrys buttery soft ride and roomy, serene cabin, for example, which have been endearing th excellent crash test scores and comfort and refinement to spare, the Camrys got what most family-sedan shoppers want. For 2010, the Camry receives a midcycle rejuvenation. Most notably.';
  String lorem2 =
      'Take the 2010 Toyota Camrys buttery soft ride and roomy, serene cabin, for example, which have been endearing th excellent crash test scores and comfort and refinement to spare,';
  PageController pagecontroller = PageController(
    initialPage: 0,
  );

  String vehicleType;
  String engineType;

  @override
  Widget build(BuildContext context) {
//    var controller = ExpandableController.of(context);
    return Column(
//      mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // NotifcationCard(
          //   title: 'New Year, New Brakes',
          //   titleBody: lorem2,
          //   fullBody: lorem2,
          //   dateTime: '09/02/2020',
          // ),
          Container(
            width: MediaQuery.of(context).size.width * 0.93,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  image: AssetImage('assets/images/landscape.png'),
                  fit: BoxFit.cover,
                )),
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {},
                  ),
                ),
              ),
              Column(children: <Widget>[
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
                          child:
                              // imageUrl != null ? Image.network(imageUrl) :
                              IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
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
                              vehicleType ?? 'Add New Vehicle',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Vehicle Type',
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 5,
                            ),
                            Text(vehicleType ?? 'N/A',
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Engine Type',
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 5,
                            ),
                            Text(engineType ?? 'N/A',
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      color: Colors.white, width: 1.0),
                                ),
                                child: Text(
                                  "More Details",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              onTap: () {
//                                            h = MediaQuery.of(context).size.height;
                                // controller.toggle();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

//                        ),
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.93,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/landscape.png'),
                          fit: BoxFit.cover,
                        )),
                    child: Stack(children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: Builder(
                          builder: (context) {
                            return Container(
                              child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {},
                              ),
                            );
                          },
                        ),
                      ),
                      Column(children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.width *
                                        0.37,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child:
                                        // imageUrl != null ? Image.network(imageUrl) :
                                        IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        vehicleType ?? 'Add New Vehicle',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Vehicle Type',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(vehicleType ?? 'N/A',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Engine Type',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(engineType ?? 'N/A',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 1.0),
                                          ),
                                          child: Text(
                                            "More Details",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        onTap: () {
//                                            h = MediaQuery.of(context).size.height;
                                          // controller.toggle();
                                        },
                                      ),
                                    ],
                                  ),

//          Container(
//            alignment: Alignment.center,
//            child: SmoothPageIndicator(
//              controller: pagecontroller ?? 0,
//              count: 2,
//              effect: SlideEffect(
//                spacing: 8.0,
//                radius: 4.0,
//                dotWidth: 24.0,
//                dotHeight: 10.0,
//                dotColor: Colors.grey,
//                paintStyle: PaintingStyle.stroke,
//                strokeWidth: 2,
//                activeDotColor: Color(0xff003399),),
//            ),
//
//
//
//         )
                                ]),
                          ),
                        ),
                      ]),
                    ]),
                  ),
                ),
              ]),
            ]),
          ),
        ]);
  }
}
