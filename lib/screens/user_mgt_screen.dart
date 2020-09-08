import 'package:dots_indicator/dots_indicator.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';
import 'package:vehispace/screens/contact.dart';
import 'package:vehispace/screens/profile.dart';
import 'package:vehispace/services/paystack.dart';
import '../widgets/customraisedbutton.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//import 'dart:async';

class MyUserManagement extends StatefulWidget {
  @override
  _MyUserManagementState createState() => _MyUserManagementState();
}

class _MyUserManagementState extends State<MyUserManagement> {
  double currentpage = 0;
  var cars;
//  List<dynamic> allCars = [];
  PageController controller = PageController(
    initialPage: 0,
  );

  @override

  void initState () {
    super.initState();
    loadCarJson();
//    PayStack().initializePayment();
  }
  @override

  Future<Map<String, dynamic>> loadCarJson () async {
//    cars = '';
    final carList = await DefaultAssetBundle.of(context).loadString('assets/json/Car_Model_List.json');
    setState(() {
      cars = jsonDecode(carList);
    });
  }
//  void initState(){
//    super.initState();
// //    Timer.periodic(Duration(seconds: 2), (Timer timer) {
//      if (currentpage < 3) {
//        setState(() {
//          currentpage++;
//        });
//      }
//      else{
//        currentpage = 0;
    //  }
////      print('Current Page is' + currentpage.toString());
//      controller.animateToPage(currentpage.toInt(), duration: Duration(microseconds: 300), curve: Curves.bounceIn);
//    });
//  }

  Widget build(BuildContext context) {
    print(cars.toString().length);
    MyVehicleBloc.allVehicle = cars;
//    MyVehicleBloc().allVehicleList = cars;
    print(MyVehicleBloc.allVehicle.toString().length);
    print(MyVehicleBloc.allVehicle.toString());
//    print(MyVehicleBloc().allVehicleList.toString().length);
    return Scaffold(
      body: SafeArea(
        child: ListView(
//          shrinkWrap: true,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1,
                ),
                Image(
                  image: AssetImage('assets/logo/mylogo.png',),
                  height: 80,
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1,
                ),
                SizedBox(
                  height: 205,
                  child:
                  PageView(
                    pageSnapping: true,
                    controller: controller,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image.asset('assets/images/Asset1.png',
                            height: 155,
                            width: 350,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16, bottom: 8),
                            child: Text("Maintenance Updates", style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sansation'),),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('assets/images/Asset4.png',
                            height: 155,
                            width: 350,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16, bottom: 8),
                            child: Text("Towing Service", style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sansation'),),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('assets/images/Asset2.png',
                            height: 155,
                            width: 350,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16, bottom: 8),
                            child: Text("Spare Parts Merchandize",
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sansation'),),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('assets/images/Asset3.png',
                            height: 155,
                            width: 350,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Text("Vehicle Papers Renewal",
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sansation'),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.1,
                ),
                // Container(
                //     alignment: Alignment.center,
                //     child: DotsIndicator(
                //       dotsCount: 4,
                //       position: currentpage,
                //       decorator: DotsDecorator(
                //         size: Size(25.0, 10.0),
                //         activeSize: Size(25.0, 10.0),
                //         activeColor: Color(0xff003399),
                //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                //         activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                //       ),
                //     ),
                //   ),
                Container(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 4,
                    effect: SlideEffect(
                      spacing: 8.0,
                      radius: 4.0,
                      dotWidth: 25.0,
                      dotHeight: 10.0,
                      dotColor: Colors.grey.withOpacity(0.3),
                      // paintStyle: PaintingStyle.stroke,
                      strokeWidth: 2,
                      activeDotColor: Color(0xff003399),),
                  ),
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: CustomRaisedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          text: 'LOGIN',
                          elevation: 1.0,
                          color: Color(0xff003399),
                          textColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.02,
                      ),
                      Expanded(
                        child: CustomRaisedButton(
                          onPressed: () {
//                            PayStack().checkoutPaystack(context);
                             Navigator.pushNamed(context, '/register');
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
                          },
                          text: 'REGISTER',
                          elevation: 1.0,
                          color: Colors.white,
                          textColor: Color(0xff003399),
                          borderWidth: 2.0,
                          borderColor: Color(0xff003399),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
