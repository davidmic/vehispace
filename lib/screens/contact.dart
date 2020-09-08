import 'package:flutter/material.dart';
import 'package:vehispace/utils/constants.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import 'package:vehispace/widgets/customtextformfield.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {

  _launchURL({String value}) async {
    final url = value;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        title: Text(
          'Contact',
          style: Constants.appBarTitleColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              CustomTextField(
                hint: 'contact@vehispace.com',
                labelText: 'Email',
                readOnly: true,
                suffix: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.26,
                  child: CustomRaisedButton(
                    elevation: 0,
                    color: Color(0xff003399),
                    textColor: Colors.white,
                    borderWidth: 0.0,
                    borderColor: Color(0xff003399),
                    text: 'Send Mail',
                    onPressed: (){
                      _launchURL(value: 'mailto:contact@vehispace.com?subject=Vehispace&body=Vehispace');
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              CustomTextField(
                hint: '+2347030398576',
                labelText: 'Phone Number',
                readOnly: true,
                suffix: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.26,
                  child: CustomRaisedButton(
                    elevation: 0,
                    color: Color(0xff003399),
                    textColor: Colors.white,
                    borderWidth: 0.0,
                    borderColor: Color(0xff003399),
                    text: 'Call',
                    onPressed: (){
                      _launchURL(value: 'tel:+2347030398576');
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              CustomTextField(
                hint: 'www.vehispace.com',
                labelText: 'Website',
                readOnly: true,
                suffix: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.26,
                  child: CustomRaisedButton(
                    elevation: 0,
                    color: Color(0xff003399),
                    textColor: Colors.white,
                    borderWidth: 0.0,
                    borderColor: Color(0xff003399),
                    text: 'Visit',
                    onPressed: (){
                      _launchURL(value: 'https://www.vehispace.com');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
