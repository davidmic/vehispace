
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vehispace/provider/userprofilebloc.dart';
import 'package:vehispace/provider/appbartitle.dart';
import 'package:vehispace/provider/vehiclepapersbloc.dart';
import 'package:vehispace/provider/vehicleregbloc.dart';
import 'package:vehispace/screens/firebasemessaging.dart';
import 'package:vehispace/screens/maintenanceupdate.dart';
import 'package:vehispace/screens/notification.dart';
import 'package:vehispace/screens/spartpart.dart';
import 'package:vehispace/screens/towing/towingservice.dart';
import 'package:vehispace/screens/papers/vehiclepapers.dart';
import 'package:vehispace/screens/papers/vehiclepapersevice.dart';
import 'package:vehispace/services/state_lga_service.dart';
import 'package:vehispace/userauth/EmailAndPasswordAuth.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/utils/notificationpersistence.dart';
import 'package:vehispace/utils/searchdelegate.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/drawer.dart';
import 'package:vehispace/utils/vehispaceicons.dart';
import 'package:vehispace/models/user.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  State createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static List<Message> messages = [];
  static int _newNotification = 0;

  String userToken;

  get newNotification => _newNotification;
  set newNotification (int val) => _newNotification = val;


//  get message => _messages;

  List<BottomNavigationBarItem> bottombar = [
    BottomNavigationBarItem(icon: Icon(VehispaceIcon.car1), title: Text('Update', style:Constants.navBarStyle)),
    BottomNavigationBarItem(icon: Icon(VehispaceIcon.tow_truck__2__1), title: Text('Towing', style:Constants.navBarStyle)),
    BottomNavigationBarItem(icon: Icon(Icons.time_to_leave, color: Colors.white,), title: Text('', style: TextStyle(color: Colors.white),)),
    BottomNavigationBarItem(icon: Icon(VehispaceIcon.wheel_1), title: Text('Parts', style:Constants.navBarStyle)),
    BottomNavigationBarItem(icon: Icon(VehispaceIcon.list_1), title: Text('Papers', style:Constants.navBarStyle)),
  ];

  List<Widget> bodyBuilder = [MaintenanceUpdate(), TowingService(), Container(), SpareParts(), VehiclePaperService()];

  int selectedIndex = 0;
  List<int> tweak = [0];

  Widget title ({int index}) {
    // print(AppBarTitle().appBarTitle.toString());
      if (selectedIndex == 0 ) {
        return _appBarTitle = Text(  'Maintenance Update', style: Constants.appBarTitleColor,);
      }
      else if (selectedIndex == 1 ) {
        return _appBarTitle = Text(  'Towing Information', style: Constants.appBarTitleColor,);
      }
      else if (selectedIndex == 3 ) {
        return _appBarTitle = Text(  'Spare Part', style: Constants.appBarTitleColor,);
      } 
      else if (selectedIndex == 4 ) {
        return _appBarTitle = Text( 'Vehicle Renewal', style: Constants.appBarTitleColor,);
      }
      else if (selectedIndex == 2 ) {
        tweak.removeLast();
        selectedIndex = tweak.last;
        print('Tweak' + selectedIndex.toString());
        return _appBarTitle = title();
      }

  }

  String _searchText = "";
  List names = List();
  List filteredNames = List();
  Icon _searchIcon = Icon(Icons.search);
  var _appBarTitle; // = Text('Search Example');


  void currentIndex (int index) {
    setState(() {
      selectedIndex = index;
      tweak.add(index);
    });
  }
EmailAndPasswordAuth em;
// var c;
var x;
String userid;
FirebaseAuth auth = FirebaseAuth.instance;
Firestore store = Firestore.instance;
DocumentSnapshot loggedinUser;
NewUser userDetail;
String firstName;
String lastName;
String email;
String imageurl;
Map<String, dynamic> dd = {};
var scaffoldkey = GlobalKey<ScaffoldState>();

 Future getCurrentUserDoc () async  {
    FirebaseUser cuser = await auth.currentUser();
    var userDoc = store.collection('usermanagement').document(cuser.uid).snapshots();
    var x = userDoc.listen((userData){
      
      setState(() {
        dd = userData.data;
      });
      print('I am One');
      print(dd);
      return dd;
    });
    return x;
  }
  getToken () async {
    await _firebaseMessaging.getToken().then((deviceToken){
      userToken = deviceToken.toString();
      print(deviceToken.toString());
      return userToken;
    });
  }

  configureFirebaseListeners () async {
   await  _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage $message');
        await _setMessage(message);
        newNotification = 1;
        Fluttertoast.showToast(
          msg: 'You have a new notification',
          textColor: Colors.black,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Color(0xffe5e5e5),
          fontSize: 16,
        );
//        _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch $message');
        newNotification = 1;
        await _setMessage(message);
        MyNotification();
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume $message');
        newNotification = 1;
       await _setMessage(message);
        MyNotification();
      },
    );
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'] ?? message;
    final String title = notification['title'];
    final String body = notification['body'];
    final String dataMessage = data['message'];
    final String date = notification['date'];
    setState(() {
      Message m = Message(
        title: title, 
        body:body, 
        message: dataMessage,
        date: date,
        );
      messages.add(m);
      StoreNotification().userNotification(m);
    });
    print('content');
    print(messages);
//    StoreNotification().writeToStorage(messages);
//    StoreNotification().save(title, messages)
//    Navigator.push(context, MaterialPageRoute(builder: (context) => MyNotification(
//      message: _messages,
//    )));
  }

  Future<bool> onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new CupertinoAlertDialog(
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("YES"),
          ),
        ],
      ),
    ) ?? false;
  }
@override

  void initState() {
    super.initState();
    // setState(() {
      getCurrentUserDoc();
      FetchStateAndLGA().getStates();
      messages = List<Message>();
      VehiclePaperBloc().getPriceList();
      MyVehicleBloc().getVehicles();
      getToken();
      configureFirebaseListeners();
    // });
  }
  @override

 
  Widget build(BuildContext context) {
    var userprofile = Provider.of<UserProfile>(context);
    var appTitle = Provider.of<AppBarTitle>(context);
    // userprofile.getCurrentUser();
    print(AppBarTitle.appBartilte.toString());
     print('I am Two');
     print (dd);
     userprofile.firstName = dd['firstname'];
     userprofile.lastName = dd['lastname'];
     Widget page;
     try{
       page = DefaultTabController(
         length: 1,
         child: StreamBuilder<Object>(
             stream: auth.onAuthStateChanged,
             builder: (context, snapshot) {
               if(snapshot.hasData){
                 FirebaseUser data = snapshot.data;
                 userprofile.userid = data.uid;
                 print(data.uid);
                 return Scaffold(
                   key: scaffoldkey,
                   backgroundColor: Color(0xffe5e5e5),
                   appBar: AppBar(
                     elevation: 0,
                     iconTheme: IconThemeData(
                       color: Color(0xff003399),
                     ),
                     backgroundColor: Color(0xfff4f4f4),
                     centerTitle: true,
                     title: appTitle.appBarTitle != null ? Text(AppBarTitle.appBartilte, style: Constants.appBarTitleColor,) : title(),
                     actions: <Widget>[
                       IconButton(
                         icon: Icon(Icons.search),
                         onPressed: () {
                           showSearch(
                             context: context,
                             delegate: VehispaceSearch(),
                           );
                         },
                         color: Color(0xff003399),
                       ),
                     ],
                   ),
                   body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to exit'),
          ),
            child: TabBarView(
//                   shrinkWrap: true,
//                   physics: ScrollPhysics(),
                       children: <Widget>[
                         bodyBuilder[selectedIndex],
                       ],
                     ),
                   ),

                   bottomNavigationBar: BottomNavigationBar(
                     type: BottomNavigationBarType.fixed,
                     items: bottombar,
                     currentIndex: selectedIndex,
                     onTap: currentIndex,
                     selectedItemColor: Color(0xffff0000),
                     unselectedItemColor: Color(0xff003399),
                   ),
                   floatingActionButton: FloatingActionButton(
                     backgroundColor: Color(0xff003399),
                     elevation: 3,
                     onPressed: (){
                       showBottomSheet(
                           context: context,
                           builder: (context) {
                             // scaffoldkey.currentState.context;
                             return Container(
                               color: Color(0xffe5e5e5),
                               child: Container(
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.only(
                                     topLeft: Radius.circular(40),
                                     topRight: Radius.circular(40),
                                   ),
                                 ),
                                 height: MediaQuery.of(context).size.height * 0.35,
                                 width: double.infinity,
                                 child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       SizedBox(
                                         width: MediaQuery.of(context).size.width * 0.65,
                                         child: CustomRaisedButton(
                                           onPressed: (){
                                             setState(() {
                                               selectedIndex = 1;
                                             });
                                           },
                                           text: 'Request a towing service',
                                           color: Colors.white,
                                           textColor: Color(0xff003399),
                                           borderWidth: 1,
                                           borderColor: Color(0xff003399),
                                         ),
                                       ),
                                       SizedBox(height: 20,),
                                       SizedBox(
                                         width: MediaQuery.of(context).size.width * 0.65,
                                         child: CustomRaisedButton(
                                           onPressed: (){
                                             // ignore: unnecessary_statements
                                             print('touvh');
                                             setState(() {
                                               selectedIndex = 4;
                                             });
                                           },
                                           text: 'Request vehicle papers',
                                           color: Colors.white,
                                           textColor: Color(0xff003399),
                                           borderWidth: 1,
                                           borderColor: Color(0xff003399),
                                         ),
                                       ),
                                       SizedBox(height: 20,),
                                       FloatingActionButton(
                                         backgroundColor: Color(0xff003399),
                                         onPressed: (){
                                           Navigator.pop(context);
                                         },
                                         child: Icon(Icons.close, color: Colors.white,),
                                       ),
                                     ]
                                 ),
                               ),
                             );
                           }
                       );
                     },
                     child: Icon(Icons.add),
                     tooltip: '',
                   ),
                   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                   floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
                   drawer: MyDrawer(firstname: dd['firstname'] ?? '', lastname: dd['lastname'] ?? '', email: dd['email'] ?? '', imageURL: dd['imageURL'],),
                 );
               } else if (snapshot.connectionState == ConnectionState.waiting) {
                 return Scaffold(
                   body: Center(
                     child: CircularProgressIndicator(),
                   ),
                 );
               }
               else {
                 return Container(color: Colors.white,);
               }
             }
         ),
       );
     }
     catch (e) {
       page = Container();
     }
    return  Scaffold(body: page);
  }
}

class Message {
  String title;
  String body;
  String message;
  String date;

  Message({this.title,
  this.body,
  this.message,
  this.date,
  });

 factory Message.fromJson(Map<String, dynamic> data) {
    return Message(
      title: data['title'] as String,
      body: data['body'] as String,
      message: data['message'] as String,
      date: data['date'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['message'] = this.message;
    return data;
  }
}

