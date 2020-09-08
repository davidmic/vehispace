import 'package:flutter/material.dart';
//import 'package:dio/dio.dart';


class Search extends StatefulWidget {
 final String appBarTitle;
 Search({this.appBarTitle});
  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();

//  final dio = new Dio();
  String _searchText = "";
  List names = List();
  List filteredNames = List();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle; // = Text('Search Example');

  _SearchState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });

      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
//    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
// AppBar
  Widget buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        ),
      ],
    );
  }
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text(widget.appBarTitle);
        filteredNames = names;
        _filter.clear();
      }
    });
  }
  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name'].toLowerCase().contains(
            _searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: () => print(filteredNames[index]['name']),
        );
      },
    );
  }



//  void _getNames() async {
//    final response = await dio.get('https://swapi.co/api/people');
//    List tempList = new List();
//    for (int i = 0; i < response.data['results'].length; i++) {
//      tempList.add(response.data['results'][i]);
//    }
//    setState(() {
//      names = tempList;
//      names.shuffle();
//      filteredNames = names;
//    });
//  }
//

}


// AppBar Title Widget

class AppBarTitle extends StatefulWidget {

  AppBarTitle({this.appBarTitle});
  final String appBarTitle;
  @override
  _AppBarTitleState createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  String _searchText = "";
  List names = List();
  List filteredNames = List();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle; // = Text('Search Example');

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
        this._appBarTitle = Text(widget.appBarTitle);
        filteredNames = names;
//        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        ),
      ],
    );
  }

  }

