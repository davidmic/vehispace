import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/userauth/EmailAndPasswordAuth.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/widgets/customdropdown.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:vehispace/services/image_service.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  var _formKey = GlobalKey<FormState>();
  String gender;
  List<String> genderList = ['Male', 'Female'];
  Firestore _store = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String userid = '';
  
  Future getCurrentUserDoc () async  {

    FirebaseUser cuser = await auth.currentUser();
    userid = cuser.uid;
    print ('My User Id: ' + userid);
    return userid;
  }

  @override

  void initState() {
    super.initState();
    setState(() {
      getCurrentUserDoc();
    });
  }
  @override

  Widget build(BuildContext context) {
    var userprofile = Provider.of<UserProfile>(context);
    var imageService = Provider.of<ImageService>(context);
    var logOut = Provider.of<EmailAndPasswordAuth>(context);
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      // appBar: AppBar(
      //   iconTheme: IconThemeData(
      //     color: Color(0xff003399),
      //   ),
      //   backgroundColor: Color(0xfff4f4f4),
      //   centerTitle: true,
      //   title: Text(
      //     'My Profile',
      //     style: Constants.appBarTitleColor,
      //   ),
      //   actions: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: PopupMenuButton(
      //         elevation: 2,
      //         color: Colors.white,
      //         child: Icon(
      //           Icons.more_vert,
      //         ),
      //         itemBuilder: (context) {
      //           return [
      //             PopupMenuItem(
      //               child: ListTile(
      //                 leading: Icon(Icons.edit),
      //                 title: Text('Edit'),
      //                 onTap: () {
      //                   Navigator.pushNamed(context, '/myprofileedit');
      //                 },
      //               ),
      //             ),
      //             PopupMenuItem(
      //               child: ListTile(
      //                 leading: Icon(Icons.credit_card),
      //                 title: Text('Add Card'),
      //                 onTap: () {
      //                   Navigator.pushNamed(context, '/addcard');
      //                 },
      //               ),
      //             ),
      //             PopupMenuItem(
      //               child: ListTile(
      //                 leading: Icon(Icons.perm_identity),
      //                 title: Text('Change Password'),
      //                 onTap: () {
      //                   Navigator.pushNamed(context, '/changepassword');
      //                 },
      //               ),
      //             ),
      //             PopupMenuItem(
      //               child: ListTile(
      //                 leading: Icon(Icons.exit_to_app),
      //                 title: Text('Log Out'),
      //                 onTap: () {},
      //               ),
      //             ),
      //             PopupMenuItem(
      //               child: ListTile(
      //                 leading: Icon(Icons.delete_forever),
      //                 title: Text('Delete Account'),
      //                 onTap: () {},
      //               ),
      //             ),
      //           ];
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _store.collection('usermanagement').document(userprofile.userid).snapshots(),
        builder: (context, snapshot) {
          // print('User ID from StreamBuilder' + userid.toString());
          if (!snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          } else if (snapshot.hasData) {
            print(snapshot.data.toString());
            DocumentSnapshot user = snapshot.data;
            return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  height: 200,
                  color: Color(0xffe5e5e5),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/landscape.png',
                              ),
                              fit: BoxFit.cover,
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                child: Icon(Icons.arrow_back, color: Colors.white),
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                              Text('My Profile', 
                                style: TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'Sansation', fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                              ),
                              PopupMenuButton(
                                elevation: 2,
                                color: Colors.white,
                                child: Icon(
                                  Icons.more_vert, color: Colors.white,
                                ),
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/myprofileedit');
                                  },
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.credit_card, color: Color(0xff333333), size: 25,),
                                  title: Text('Add Card'),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/addcard');
                                  },
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.perm_identity, color: Color(0xff333333), size: 25,),
                                  title: Text('Change Password'),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/changepassword');
                                  },
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.exit_to_app, color: Color(0xff333333), size: 25,),
                                  title: Text('Log Out'),
                                  onTap: () async {
                                    await logOut.signOutUser();
                                    Navigator.pop(context);
//                                    Navigator.pop(context);
                                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                                  },
                                ),
                              ),
//                              PopupMenuItem(
//                                child: ListTile(
//                                  leading: Icon(Icons.delete_forever, color: Color(0xff333333), size: 25,),
//                                  title: Text('Delete Account'),
//                                  onTap: () {},
//                                ),
//                              ),
                                  ];
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        left: MediaQuery.of(context).size.width * 0.37,
                        child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: <Widget>[
                            user['imageURL'] != null ? Container(
                              // radius: 50,
                              // margin: EdgeInsets.only(left),
                              alignment: Alignment.center,
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(user['imageURL']),
                                  fit: BoxFit.fill
                                  ),
                              ),
                              // child: CachedNetworkImage(
                              //   imageUrl: user['imageURL'], 
                              //   placeholder: (contxt, url) => Center(child: CircularProgressIndicator()),
                              //   fit: BoxFit.fill,
                              //   ),
                            ) : Image.asset('assets/images/userimage.png'),
                            user['imageURL'] != null ? Container() : Positioned(
                              left: 80,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                 color: Color(0xffff0000),
                                  shape: BoxShape.circle,
                                ),
                              child: 
                                 InkWell(
                                   onTap: () async {
                                     await imageService.fromGallery();
                                    ImageService.image.path != null ? await imageService.uploadFile(ImageService.image, 'user_profilepics/'):
                                      print('Just tapped');
                                   },
                                   child: Icon(Icons.add, 
                                   size: 20, color: 
                                   Color(0xff003399),
                                   ),
                                 ),
                          ),
                            ),
                          ],
                        ),
                ),
                      ),
                    ],
                  ),
                ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user['firstname'] + " " + user['lastname'],
            style: TextStyle(fontSize: 20, fontFamily: 'Sansation', fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Color(0xff003399)),
            ),
            Text(user['email'],
            style: TextStyle(fontSize: 12, fontFamily: 'Sansation', fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Color(0xff003399)),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15,10,15,10),
                  color: Color(0xffe5e5e5),
                  child: Column(
                      children: <Widget>[
//                     CustomTextField(
//                       // intialValue: user['firstname'],
//                       labelText: 'First Name',
//                       readOnly: true,
//                       hint: user['firstname'] ?? '',
//                       onSaved: (val) {
// //            lastName = val;
//                       },
//                       keyboardType: TextInputType.text,
//                       validator: (val) {
//                         if (val.isEmpty) {
//                           return 'First Name is Required';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.02,
//                     ),
//                     CustomTextField(
//                       hint: user['lastname'] ?? '',
//                       readOnly: true,
//                       labelText: 'Last Name',
//                       onSaved: (val) {
// //            lastName = val;
//                       },
//                       keyboardType: TextInputType.text,
//                       validator: (val) {
//                         if (val.isEmpty) {
//                           return 'Last Name is Required';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.02,
//                     ),
//                     CustomTextField(
//                       hint: user['email'] ?? '',
//                       // readOnly: true,
//                       labelText: 'Email Address',
//                       onSaved: (val) {
// //            lastName = val;
//                       },
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (val) {
//                         if (val.isEmpty) {
//                           return 'Email Address is Required';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.02,
//                     ),
//                     CustomDropdown(
//                         value: gender,
//                         hintText: user['gender'] ?? '',
//                         onChanged: null,
//                         items: genderList,
//                         labelText: 'Gender'),
                        CustomTextField(
                          intialValue: user['phone'] ?? "",
                          hint: "",
                          readOnly: true,
                          labelText: 'Mobile Number',
                          onSaved: (val) {
//            lastName = val;
                          },
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Field is Required';
                            }
                            return null;
                          },
                        ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextField(
                      hint: user['driverlicense'] ?? "",
                      readOnly: true,
                      labelText: 'Driver License (Optional)',
                      onSaved: (val) {
//            lastName = val;
                      },
                      keyboardType: TextInputType.text,

                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextField(
                      hint: user['driverlicenseexpiry'] ?? "",
                      readOnly: true,
                      labelText: 'Driver License Expiry',
                      onSaved: (val) {
//            lastName = val;
                      },
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Field is Required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextField(
                      suffixIcon: Image.asset('assets/images/cardtypea.png'),
                      hint: user['cardNumber'] ?? "No Card",
                      readOnly: true,
                      labelText: 'Card',
                      onSaved: (val) {
//            lastName = val;
                      },
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Field is Required';
                        }
                        return null;
                      },
                    ),
                  ]
                  ),
                ),
              ],
            ),
          );
          }
          // var data = snapshot.data;
          // String x = data['firstname'];
          // print ('my fsts:  + ${data['firstname']}');
          
        }
      ),
    );
  }
}
