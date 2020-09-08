import 'package:flutter/material.dart';
import 'package:vehispace/provider/cartbloc.dart';
import 'package:vehispace/screens/cart.dart';
import 'package:vehispace/screens/login_screen.dart';
import 'package:vehispace/screens/maintenanceupdate.dart';
import 'package:vehispace/screens/new_user_registration.dart';
import 'package:vehispace/screens/offered_services.dart';
import 'package:vehispace/screens/product_details.dart';
import 'package:vehispace/screens/products.dart';
import 'package:vehispace/screens/splashscreen.dart';
import 'package:vehispace/screens/user_mgt_screen.dart';
import 'package:vehispace/screens/forget_password.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/screens/vehiclereg.dart';
import 'package:vehispace/userauth/EmailAndPasswordAuth.dart';
import 'package:vehispace/userauth/facebookauth.dart';
import 'package:vehispace/userauth/googleAuth.dart';
import 'provider/productbloc.dart';
//import '';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductBloc()),
        ChangeNotifierProvider(create: (context) => Cartbloc(),),
        ChangeNotifierProvider(create: (context) => FacebookAuth(),),
        ChangeNotifierProvider(create: (context) => EmailAndPasswordAuth(),),
        // ChangeNotifierProvider(create: (context) => GoogleAuth(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/' : (context) => MySplashScreen(),
          '/usermgt' : (context) => MyUserManagement(),
          '/login' : (context) => MyLoginScreen(),
          '/forgotpassword' : (context) => MyForgotPassword(),
          '/register' : (context) => MyNewUserRegistration(),
          '/offerservices' : (context) => MyHomePage(),
          '/productlist' : (context) => MyProductList(),
          '/productdetails' : (context) => ProductDetails(),
          '/cart' : (context) => MyCart(),
          '/vehiclereg' : (context) => MyVehicleRegistration(),
          '/maintenanceupdate' : (context) => MaintenanceUpdate(),
        },
//    initialRoute: ,
      ),
    );
  }
}




