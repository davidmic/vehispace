import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/provider/appbartitle.dart';
import 'package:vehispace/provider/towingbloc.dart';
import 'package:vehispace/screens/towinginfo.dart';
import 'package:vehispace/screens/towinginfomap.dart';
import 'package:vehispace/screens/towingoderpayment.dart';
import 'package:vehispace/screens/towingorderrequest.dart';


enum Towing {Order, Request, Payment, Information}

class TowingService extends StatefulWidget {
  @override
  _TowingServiceState createState() => _TowingServiceState();
}

class _TowingServiceState extends State<TowingService> {
//  Completer<GoogleMapController> _controller = Completer();

  Towing page = Towing.Order;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var appTitle = Provider.of<AppBarTitle>(context);
    var towingBloc = Provider.of<TowingBloc>(context);
    Widget myPage;
if (page == Towing.Order) {
  myPage = TowingInformation(
    onPressed: (){
      setState(() {
        page = Towing.Request;
      });
       appTitle.changeTitle(
          pageTitle: 'Towing Order',
        );
    },
  );
} else if (page == Towing.Request) {
    myPage = TowingOrderRequest(
      editOnPressed: (){
        setState(() {
          page = Towing.Order;
        });
      },
      onPressed: (){
        setState(() {
          page = Towing.Payment;
        });
        appTitle.changeTitle(
          pageTitle: 'Payment Options',
        );
      },
    );
} else if (page == Towing.Payment) {
    myPage = TowingOrderPayment(
      editOnPressed: (){
        setState(() {
          page = Towing.Order;
        });
      },
      onPressed: (){
//        Navigator.push(context, MaterialPageRoute(builder: (context) => TowingInformationMap()));
        setState(() {
          page = Towing.Information;
        });
        appTitle.changeTitle(
          pageTitle: 'Towing Information',
        );
      },
    );
} 
else if (page == Towing.Information) {
  myPage = TowingInformationMap(
    // editOnPressed: (){
    //     setState(() {
    //       page = Towing.Order;
        //   appTitle.changeTitle(
        //   pageTitle: 'Towing Information',
        // );
      //   });
      // },
    // latitude: towingBloc.towingDetails.latitude,
    // longitude: towingBloc.towingDetails.longitude,
  );
}  
    return myPage;
  }
}
