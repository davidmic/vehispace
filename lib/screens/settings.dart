import 'package:flutter/material.dart';
import 'package:vehispace/services/webview.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/widgets/customdropdown.dart';

class MySettings extends StatelessWidget {
  List<String> languageList = ['English'];
  String language = 'English';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff003399),
        ),
        backgroundColor: Color(0xfff4f4f4),
        centerTitle: true,
        title: Text('Settings', style: Constants.appBarTitleColor,),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,10,0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Language', style: TextStyle(fontFamily: 'Sansation', fontSize: 16),),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width * 0.35,
//                  height: MediaQuery.of(context).size.height  * 0.1,
                      child: CustomDropdown(
                        bgColor: Colors.transparent,
                        value: language,
                        onChanged: (val){
                          language = val;
                        },
                        items: languageList,
                        labelText: "",
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Change Password', style: TextStyle(fontFamily: 'Sansation', fontSize: 16)),
              onTap: (){
                Navigator.pushNamed(context, '/changepassword');
              },
            ),
            Divider(),
            ListTile(
              title: Text('FAQ', style: TextStyle(fontFamily: 'Sansation', fontSize: 16)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyWebView(title: 'FAQ', selectedUrl: 'https://vehispace.com/faq',)));
//                MyWebView(
//                  title: 'FAQ',
//                  selectedUrl: 'https://www.google.com',
//                  );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Privacy Policy', style: TextStyle(fontFamily: 'Sansation', fontSize: 16)),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyWebView( title: 'Privacy Policy',
                  selectedUrl: 'vehispace.com/privacypolicy',)));
                 MyWebView(
                  title: 'Privacy Policy', 
                  selectedUrl: 'vehispace.com/privacypolicy',
                  );
              },
            )
          ],
        ),
      ),
    );
  }
}
