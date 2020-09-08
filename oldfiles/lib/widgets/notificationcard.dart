import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class NotifcationCard extends StatelessWidget {
  NotifcationCard({this.title, this.titleBody, this.fullBody, this.dateTime});
  final String title;
  final String titleBody;
  final String fullBody;
  final String dateTime;


  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xff003399), width: 1.0),
                      ),
                      child: Icon(Icons.notifications)),
                  SizedBox(height: 30,),
                  Text(dateTime.toString(),
                    style: TextStyle(color: Color(0xffFF0000),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(title,
                      style: TextStyle(color: Color(0xff003399),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                collapsed: Text(
                  titleBody,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                        for (var _ in Iterable.generate(5))
                    Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          fullBody,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
