import 'package:flutter/material.dart';
import 'package:vehispace/widgets/customtextformfield.dart';

class MySecondProfileOne extends StatefulWidget {
  @override
  _MySecondProfileOneState createState() => _MySecondProfileOneState();
}

class _MySecondProfileOneState extends State<MySecondProfileOne> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Image.asset('assets/images/profilepic.png'),
            ),
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
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: (){},
                  ),
                  Text('My Profile'),
                  PopupMenuButton(
                    elevation: 2,
                    color: Colors.white,
                    child: Icon(
                      Icons.more_vert,
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
                            leading: Icon(Icons.perm_identity),
                            title: Text('Change Password'),
                            onTap: () {
                              Navigator.pushNamed(context, '/changepassword');
                            },
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(Icons.exit_to_app),
                            title: Text('Log Out'),
                            onTap: () {},
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(Icons.delete_forever),
                            title: Text('Delete Account'),
                            onTap: () {},
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('John Doe'),
            Text('johndoe@gmail.com'),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        CustomTextField(
          intialValue: '',
          hint: 'Driver License (Optional)',
          onSaved: (val) {},
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
          intialValue: '',
          hint: 'Driver License Expiry',
          onSaved: (val) {},
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
          intialValue: '',
          labelText: 'Card',
          hint: 'No Card',
          onSaved: (val) {},
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
      ],
    );
  }
}
