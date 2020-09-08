
import 'package:flutter/material.dart';
import 'package:vehispace/provider/appbartitle.dart';
import 'package:vehispace/provider/cartbloc.dart';
import 'package:vehispace/provider/towingbloc.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:vehispace/provider/vehiclepapersbloc.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';
import 'package:vehispace/screens/addcard.dart';
import 'package:vehispace/screens/cart.dart';
import 'package:vehispace/screens/change_password.dart';
import 'package:vehispace/screens/contact.dart';
import 'package:vehispace/screens/editprofile.dart';
import 'package:vehispace/screens/login_screen.dart';
import 'package:vehispace/screens/maintenanceupdate.dart';
import 'package:vehispace/screens/myvehicle.dart';
import 'package:vehispace/screens/new_user_registration.dart';
import 'package:vehispace/screens/notification.dart';
import 'package:vehispace/screens/offered_services.dart';
import 'package:vehispace/screens/product_details.dart';
import 'package:vehispace/screens/products.dart';
import 'package:vehispace/screens/profile.dart';
import 'package:vehispace/screens/settings.dart';
import 'package:vehispace/screens/splashscreen.dart';
import 'package:vehispace/screens/towingordersnotification.dart';
import 'package:vehispace/screens/user_mgt_screen.dart';
import 'package:vehispace/screens/forget_password.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/screens/vehicledetails.dart';
import 'package:vehispace/screens/vehiclepapers.dart';
import 'package:vehispace/screens/vehiclepapersnotification.dart';
import 'package:vehispace/screens/vehiclereg.dart';
import 'package:vehispace/screens/vehiclereginapp.dart';
import 'package:vehispace/screens/verificationlogin.dart';
import 'package:vehispace/screens/verificationsent.dart';
import 'package:vehispace/services/image_service.dart';
import 'package:vehispace/services/state_lga_service.dart';
import 'package:vehispace/userauth/EmailAndPasswordAuth.dart';
import 'package:vehispace/userauth/facebookauth.dart';
import 'package:vehispace/userauth/googleAuth.dart';
import 'provider/productbloc.dart';


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
        ChangeNotifierProvider(create: (context) => GoogleAuth(),),
        ChangeNotifierProvider(create: (context) => UserProfile(),),
        ChangeNotifierProvider(create: (context) => ImageService()),
        ChangeNotifierProvider(create: (context) => MyVehicleBloc()),
        ChangeNotifierProvider(create: (context) => AppBarTitle()),
        ChangeNotifierProvider(create: (context) => TowingBloc(),),
        ChangeNotifierProvider(create: (context) => FetchStateAndLGA(),),
        ChangeNotifierProvider(create: (context) => VehiclePaperBloc(),),
      ],
      child: MaterialApp(
        // navigatorKey: navKey, 
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
          '/myprofile' : (context) => MyProfile(),
          '/myprofileedit' : (context) => MyProfileEdit(),
          '/myvehicle' : (context) => MyVehicle(),
          '/myvehiclerge' : (context) => MyVehicleRegistration(),
          '/myvehicledetail' : (context) => MyVehicleDetail(),
          '/changepassword' : (context) => ChangePassword(),
          '/towingorder' : (context) => MyTowingOrders(),
          '/vehiclepapers' : (context) => VehiclePapers(),
          '/verificationmail' : (context) => VerificationMail(),
          '/verificationlogin' : (context) => MyVerificationLoginScreen(),
          '/addcard' : (context) => AddCard(),
          '/vehiclereginapp' : (context) => MyVehicleRegistrationInApp(),
          '/setting' : (context) => MySettings(),
          '/contact' : (context) => ContactPage(),
          '/notification' : (context) => MyNotification(),
          '/vehiclepaperorders' : (context) => MyVehiclePaperOrders(),

        },
//    initialRoute: ,
      ),
    );
  }
}




