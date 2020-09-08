
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:vehispace/utils/vehispaceicons.dart';
import 'package:vehispace/utils/constants.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  CircleAvatar(
                    radius: 40,
                    child: Image.asset('assets/images/userimage.png',
                     height: 100,
                     fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 50,),
                      Text('John Doe', style: TextStyle(fontSize: 22, fontFamily: 'Sansation', fontWeight: FontWeight.bold, color: Colors.white),),
                      Text('johndoe@mail.com', style: TextStyle(fontSize: 14, fontFamily: 'Sansation', fontWeight: FontWeight.bold, color: Colors.white),),
                    ],
                  ),
//                  UserAccountsDrawerHeader(
//                    currentAccountPicture: CircleAvatar(
//                      backgroundColor: Colors.white,
//                      radius: 30,
//                    ),
//                    accountName: Text('John Doe'),
//                    accountEmail: Text('johndoe@mail.com'),
//                  ),
                ],
              )
          ),
          ListTile(
            leading: Icon(VehispaceIcon.profile_1, color: Color(0xff333333), size: 25,),
            title: Text('Profile', style: Constants.drawerliststyle,),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(VehispaceIcon.tow_truck__2__1, color: Color(0xff333333), size: 25,),
            title: Text('Towing Orders', style: Constants.drawerliststyle,),
            onTap: (){},
            trailing: Badge(
              badgeColor: Color(0xffff0000),
              showBadge: true,
              shape: BadgeShape.circle,
            ),
          ),
          ListTile(
            leading: Icon(VehispaceIcon.list_1, color: Color(0xff333333), size: 25,),
            title: Text('Manage Vehicle Papers', style: Constants.drawerliststyle,),
            onTap: (){},
            trailing: Badge(
              badgeColor: Color(0xffff0000),
              showBadge: true,
              shape: BadgeShape.circle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15.0, right: 15.0,),
            child: Divider(),
          ),
          ListTile(
            leading: Icon(VehispaceIcon.shop_1, color: Color(0xff333333), size: 25,),
            title: Text('Shop', style: Constants.drawerliststyle,),
            onTap: (){},
//            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
          ),
          ListTile(
            leading: Icon(VehispaceIcon.vector__4_, color: Color(0xff333333), size: 25,),
            title: Text('Wishlist', style: Constants.drawerliststyle,),
            onTap: (){},
//            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
          ),
          ListTile(
            leading: Icon(VehispaceIcon.supermarket_1, color: Color(0xff333333), size: 25,),
            title: Text('Cart', style: Constants.drawerliststyle,),
            onTap: (){},
//            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15.0, right: 15.0),
            child: Divider(),
          ),
          ListTile(
            leading: Icon(VehispaceIcon.car_1, color: Color(0xff333333), size: 25,),
            title: Text('Vehicles', style: Constants.drawerliststyle,),
            onTap: (){},
//            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
          ),
          ListTile(
            leading: Icon(VehispaceIcon.vector__3_, color: Color(0xff333333), size: 25,),
            title: Text('Notification', style: Constants.drawerliststyle,),
            onTap: (){},
            trailing: Badge(
              badgeColor: Color(0xffff0000),
              showBadge: true,
              shape: BadgeShape.circle,
            ),
          ),
          ListTile(
            leading: Icon(VehispaceIcon.settings_1, color: Color(0xff333333), size: 25,),
            title: Text('Settings', style: Constants.drawerliststyle,),
            onTap: (){},
//            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
          ),
          ListTile(
            leading: Icon(VehispaceIcon.group_6, color: Color(0xff333333), size: 25,),
            title: Text('Contact', style: Constants.drawerliststyle,),
            onTap: (){},
//            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, size: 40,
            color: Color(0xffff0000),
            ),
            title: Text('Log Out', style: TextStyle(color: Color(0xffff0000), fontSize: 16, fontFamily: 'Sansation', fontWeight: FontWeight.bold),),
            onTap: (){},
//            trailing: Text('.', style: TextStyle(color: Color(0xffff0000), fontWeight: FontWeight.bold, fontSize: 15),),
          ),
        ],
      ),
    );
  }
}
