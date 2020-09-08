//import 'package:flutter/material.dart';
//
//class MyServiceHome extends StatelessWidget {
//  List<Map<String, dynamic>> builder = [
//    {
//      'title' : 'Towing Service',
//      'image' : 'assets/images/towing.png',
//      'callback' : '/productlist'
//    },
//    {
//      'title' : 'Spare Part Sales',
//      'image' : 'assets/images/sparepart.png',
//      'callback' : '/productlist'
//    },
//    {
//      'title' : 'Maintence',
//      'image' : 'assets/images/mainten.png',
//      'callback' : '/productlist'
//    },
//    {
//      'title' : 'License Renewal',
//      'image' : 'assets/images/mainten.png',
//      'callback' : '/productlist',
//    },
//  ];
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Services'),
//      ),
//      body: Center(
//        child: CircularProgressIndicator()a,
//      )
////      Container(
////        padding: const EdgeInsets.all(8.0),
////        margin: EdgeInsets.only(top: 30.0),
////        child: GridView.builder(
////          shrinkWrap: true,
////            physics: ScrollPhysics(),
////            gridDelegate:
////                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
////            itemCount: builder.length,
////            itemBuilder: (BuildContext context, int index){
////              final currentitem = builder[index];
////              return  GestureDetector(
////                onTap: (){
////                    Navigator.pushNamed(context, currentitem['callback'].toString());
////                },
////                child: Card(
////                    child: Column(
////                        crossAxisAlignment: CrossAxisAlignment.center,
////                        children: <Widget>[
////                          Image.asset(currentitem['image']),
////                          Text(currentitem['title']),
////                        ],
////                    ),
////
////                ),
////              );
////            },
////        ),
////      ),
//    );
//  }
//}
import 'package:flutter/material.dart';
import 'package:vehispace/screens/maintenanceupdate.dart';
import 'package:vehispace/screens/towingservice.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/widgets/drawer.dart';
import 'package:vehispace/utils/vehispaceicons.dart';
import 'package:vehispace/widgets/customsearchbar.dart';

class MyHomePage extends StatefulWidget {
  @override
  State createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {

  List<BottomNavigationBarItem> bottombar = [
    BottomNavigationBarItem(icon: Icon(VehispaceIcon.car1), title: Text('Update')),
    BottomNavigationBarItem(icon: Icon(VehispaceIcon.tow_truck__2__1), title: Text('Towing')),
    BottomNavigationBarItem(icon: Icon(Icons.time_to_leave, color: Colors.white,), title: Text('', style: TextStyle(color: Colors.white),)),
    BottomNavigationBarItem(icon: Icon(VehispaceIcon.wheel_1), title: Text('Parts')),
    BottomNavigationBarItem(icon: Icon(VehispaceIcon.list_1), title: Text('Papers')),
  ];

  List<Widget> bodyBuilder = [MaintenanceUpdate(), TowingService(), Container(), CircularProgressIndicator(), CircularProgressIndicator()];

  int selectedIndex = 0;
  List<int> tweak = [0];

  Widget appBarTitle ({int index}) {
    // ignore: missing_return
      if (selectedIndex == 0 ) {
        return _appBarTitle = Text('Maintenance Update', style: Constants.appBarTitleColor,);
      }
      else if (selectedIndex == 1 ) {
        return _appBarTitle = Text('Towing Information', style: Constants.appBarTitleColor,);
      }
      else if (selectedIndex == 3 ) {
        return _appBarTitle = Text('Vehicle Renewal', style: Constants.appBarTitleColor,);
      }
      else if (selectedIndex == 4 ) {
        return _appBarTitle = Text('Spare Part', style: Constants.appBarTitleColor,);
      }
      else if (selectedIndex == 2 ) {
        tweak.removeLast();
        selectedIndex = tweak.last;
        print('Tweak' + selectedIndex.toString());
        return _appBarTitle = appBarTitle();
      }

  }

  String _searchText = "";
  List names = List();
  List filteredNames = List();
  Icon _searchIcon = Icon(Icons.search);
  var _appBarTitle; // = Text('Search Example');

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
//          controller: _filter,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        _appBarTitle;
        filteredNames = names;
//        _filter.clear();
      }
    });
  }

  void currentIndex (int index) {
    setState(() {
      selectedIndex = index;
      tweak.add(index);
      print(index.toString());
    });
  }
//void initState(){
//    super.initState();
//    _appBarTitle = appBarTitle();
//}
  @override
  Widget build(BuildContext context) {
    setState(() {
//      _appBarTitle = appBarTitle();
    });
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff003399),
        ),
        backgroundColor: Color(0xfff4f4f4),
        centerTitle: true,
        title:   appBarTitle(),
        actions: <Widget>[
          IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed,
            color: Color(0xff003399),
          ),
        ],
      ),
//      AppBar(
//        title: Text(appBarTitle()),
//      ),
      body: ListView(
        children: <Widget>[
          bodyBuilder[selectedIndex],
        ],
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
        onPressed: (){},
        child: Icon(Icons.add),
        tooltip: '',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      drawer: MyDrawer(),
    );
  }
}

