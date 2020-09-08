
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/models/user.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:vehispace/services/image_service.dart';
import 'package:vehispace/userauth/facebookauth.dart';
import 'package:vehispace/userauth/googleAuth.dart';
import 'package:vehispace/utils/vehispaceicons.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/userauth/EmailAndPasswordAuth.dart';

class MyDrawer extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String email;
  final String imageURL;
  MyDrawer({this.firstname, this.lastname, this.email, this.imageURL});
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  EmailAndPasswordAuth em;
  FirebaseAuth s = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
  var x;
  var c;
  @override

  Widget build(BuildContext context) {
    var imageService = Provider.of<ImageService>(context);
    var userProfile = Provider.of<UserProfile>(context);
    var logOut = Provider.of<EmailAndPasswordAuth>(context);
    var gLogOut = Provider.of<GoogleAuth>(context);
    var fbLogOut = Provider.of<FacebookAuth>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
//              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/landscape.png',
                    ),
                    fit: BoxFit.cover,
                  )
              ),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 22.0),
                            child: CircleAvatar(
                              radius: 40,
                              child: widget.imageURL != null ? Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(widget.imageURL),
                                    fit: BoxFit.fill,
                                    ),
                                ),
                              //   child: CachedNetworkImage(
                              //     imageUrl: widget.imageURL, 
                              //     placeholder: (context, url) => Center(child: CircularProgressIndicator()), 
                              //     fit: BoxFit.fill,
                              //     ),
                              ) 
                              : Image.asset('assets/images/userimage.png',
                               height: 100,
                               fit: BoxFit.fill,
                              ),
                            ),
                          ),
                           widget.imageURL == null ? Positioned(
                              left: 45,
                              child: Container(
                                decoration: BoxDecoration(
                                 color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              child: 
                                 GestureDetector(
                                   onTap: () async {
                                    await imageService.fromGallery();
                                    ImageService.image.path.isNotEmpty ? await imageService.uploadFile(ImageService.image, 'user_profilepics/'):
                                      print('Just tapped');
                                    await  userProfile.updateUserPhoto(
                                      user: NewUser( 
                                        imageURL: ImageService.uploadFileURL,
                                      )
                                    );
                                   },
                                   child: Icon(Icons.add, 
                                   size: 20, color: 
                                   Color(0xff003399),
                                   ),
                                 ),
                          ),
                            ): Container(),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 50,),
                          Text(widget.firstname + " " + widget.lastname, style: TextStyle(fontSize: 14, fontFamily: 'Sansation', fontWeight: FontWeight.bold, color: Colors.white),),
                          Text(widget.email, style: TextStyle(fontSize: 14, fontFamily: 'Sansation', fontWeight: FontWeight.bold, color: Colors.white),),
                        ],
                      ),
                    ],
                  ),
              //     ;
              //   }
              // )
          ),
//          SizedBox(height: 10,),
//          buildDrawerNav(
//            icon: VehispaceIcon.profile_1,
//            text: 'Profile',
//            onpressed: () {
//              Navigator.pushNamed(context, '/myprofile');
//            }
//          ),
           ListTile(
             dense: true,
             leading: Icon(VehispaceIcon.profile_1, color: Color(0xff333333), size: 25,),
             title: Text('Profile', style: Constants.drawerliststyle,),
             onTap: (){
               Navigator.pushNamed(context, '/myprofile');
             },
           ),
//           buildDrawerNav(
//            icon: VehispaceIcon.tow_truck__2__1,
//            text: 'Towing Orders',
//            show: true,
//            onpressed: () {
//              Navigator.pushNamed(context, '/towingorder');
//            }
//          ),
           ListTile(
             dense: true,
             leading: Icon(VehispaceIcon.tow_truck__2__1, color: Color(0xff333333), size: 25,),
             title: Text('Towing Orders', style: Constants.drawerliststyle,),
             onTap: (){
               Navigator.pushNamed(context, '/towingorder');
             },
             trailing: Badge(
               badgeColor: Color(0xffff0000),
               showBadge: true,
               shape: BadgeShape.circle,
             ),
           ),
//           buildDrawerNav(
//            icon: VehispaceIcon.list_1,
//            text: 'Manage Vehicle Papers',
//            show: true,
//            onpressed: () {
////              Navigator.pushNamed(context, '/vehiclepapers');
//            }
//          ),
           ListTile(
             dense: true,
             leading: Icon(VehispaceIcon.list_1, color: Color(0xff333333), size: 25,),
             title: Text('Manage Vehicle Papers', style: Constants.drawerliststyle,),
             onTap: (){
               Navigator.pushNamed(context, '/vehiclepaperorders');
             },
             trailing: Badge(
               badgeColor: Color(0xffff0000),
               showBadge: true,
               shape: BadgeShape.circle,
             ),
           ),
          // Padding(
          //   padding: const EdgeInsets.only(left:15.0, right: 15.0,),
          //   child: Divider(),
          // ),
          //  buildDrawerNav(
          //   icon: VehispaceIcon.shop_1,
          //   text: 'Shop',
          //   onpressed: () {
          //     Navigator.pushNamed(context, '/vehiclereg');
          //   }
          // ),
//           ListTile(
//             leading: Icon(VehispaceIcon.shop_1, color: Color(0xff333333), size: 25,),
//             title: Text('Shop', style: Constants.drawerliststyle,),
//             onTap: (){},
// //            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
//           ),
          //  buildDrawerNav(
          //   icon: VehispaceIcon.vector__4_,
          //   text: 'Wishlist',
          //   onpressed: () {
          //     // Navigator.pushNamed(context, '/towingorder');
          //   }
          // ),
//           ListTile(
//             leading: Icon(VehispaceIcon.vector__4_, color: Color(0xff333333), size: 25,),
//             title: Text('Wishlist', style: Constants.drawerliststyle,),
//             onTap: (){},
// //            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
//           ),
          //  buildDrawerNav(
          //   icon: VehispaceIcon.supermarket_1,
          //   text: 'Cart',
          //   onpressed: () {
          //     // Navigator.pushNamed(context, '/towingorder');
          //   }
          // ),
//           ListTile(
//             leading: Icon(VehispaceIcon.supermarket_1, color: Color(0xff333333), size: 25,),
//             title: Text('Cart', style: Constants.drawerliststyle,),
//             onTap: (){},
// //            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
//           ),
          Padding(
            padding: const EdgeInsets.only(left:15.0, right: 15.0),
            child: Divider(),
          ),
//           buildDrawerNav(
//            icon: VehispaceIcon.car_1,
//            text: 'Vehicles',
//            onpressed: () {
//              Navigator.pushNamed(context, '/myvehicle');
//            }
//          ),
           ListTile(
             dense: true,
             leading: Icon(VehispaceIcon.car_1, color: Color(0xff333333), size: 25,),
             title: Text('Vehicles', style: Constants.drawerliststyle,),
             onTap: (){
               Navigator.pushNamed(context, '/myvehicle');
             },
            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
           ),
//           buildDrawerNav(
//            icon: VehispaceIcon.vector__3_,
//            text: 'Notification',
//            show: true,
//            onpressed: () {
//               Navigator.pushNamed(context, '/notification');
//            }
//          ),
           ListTile(
             dense: true,
             leading: Icon(VehispaceIcon.vector__3_, color: Color(0xff333333), size: 25,),
             title: Text('Notification', style: Constants.drawerliststyle,),
             onTap: (){
               Navigator.pushNamed(context, '/notification');
             },
             trailing: Badge(
               badgeColor: Color(0xffff0000),
               showBadge: true,
               shape: BadgeShape.circle,
             ),
           ),
//           buildDrawerNav(
//            icon: VehispaceIcon.settings_1,
//            text: 'Settings',
//            onpressed: () {
//              Navigator.pushNamed(context, '/setting');
//            }
//          ),
           ListTile(
             dense: true,
             leading: Icon(VehispaceIcon.settings_1, color: Color(0xff333333), size: 25,),
             title: Text('Settings', style: Constants.drawerliststyle,),
             onTap: (){
               Navigator.pushNamed(context, '/setting');
             },
 //            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
           ),
//           buildDrawerNav(
//            icon: VehispaceIcon.group_6,
//            text: 'Contacts',
//            onpressed: () {
//               Navigator.pushNamed(context, '/contact');
//            }
//          ),
           ListTile(
             dense: true,
             leading: Icon(VehispaceIcon.group_6, color: Color(0xff333333), size: 25,),
             title: Text('Contact', style: Constants.drawerliststyle,),
             onTap: (){
               Navigator.pushNamed(context, '/contact');
             },
 //            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
           ),
          // buildGestureDetector(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
//           buildDrawerNav(
//            icon:  Icons.exit_to_app,
//            text: 'Log Out',
//            iconSize: 40,
//            fontSize: 16,
//            fontWeight: FontWeight.bold,
//            iconColor: Color(0xffff0000),
//            onpressed: () async {
//              await logOut.signOutUser();
//              Navigator.pop(context);
//              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
//            }
//          ),
           ListTile(
             dense: true,
             leading: Icon(Icons.exit_to_app, size: 40,
             color: Color(0xffff0000),
             ),
             title: Text('Log Out', style: TextStyle(color: Color(0xffff0000), fontSize: 16, fontFamily: 'Sansation', fontWeight: FontWeight.bold),),
             onTap: () async {
               await logOut.signOutUser();
               Navigator.pop(context);
               Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
             },
 //            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
           ),
        ],
      ),
    );
  }

  GestureDetector buildDrawerNav({Function onpressed, IconData icon, String text, bool show = false, double iconSize, Color iconColor, FontWeight fontWeight, double fontSize}) {
    bool showBadge = show;
    return GestureDetector(
          onTap: onpressed,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 20, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Icon(icon, color: iconColor ?? Color(0xff333333), size: iconSize ?? 25,),
                    SizedBox(width: 30),
                    Text(text, style: TextStyle(color: iconColor, fontWeight: fontWeight, fontSize: fontSize) ?? Constants.drawerliststyle,),
                  ]
                ),
                showBadge ?
              Badge(
                badgeColor: Color(0xffff0000),
                showBadge: true,
                shape: BadgeShape.circle,
              ) : Container(),
            ],
         ),
          ),
        );
  }
}
