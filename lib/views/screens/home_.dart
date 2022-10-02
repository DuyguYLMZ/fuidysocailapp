import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_app_ui/views/widgets/post_item.dart';
import 'package:social_app_ui/util/data.dart';

import 'create_activite_screen.dart';
import 'notifications.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // appBar: AppBar(
      //   title: Text("Etkinlikler"),
      //   centerTitle: true,
      //   actions: <Widget>[

      //   ],
      // ),
      navigationBar: CupertinoNavigationBar(
        middle: Text("Etkinlikler"),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  Notifications()),
                    );
                  },
                ),
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  CreateActivite()),
                );
              },
            ),
          ],
        ),
      ),
      child: kIsWeb ? Scaffold(
        body: SafeArea(
          child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.25 ,left: MediaQuery.of(context).size.width*0.25  ),
            child: Center(
              child:  ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  Map post = posts[index];
                  return Center(
                    child: PostItem(
                      img: post['img'],
                      name: post['name'],
                      dp: post['dp'],
                      time: post['time'],
                    ),
                  );
                },
              ),
            ),
          ),
        )
      )  :
      SafeArea(
        child: Scaffold(
          body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              Map post = posts[index];
              return PostItem(
                img: post['img'],
                name: post['name'],
                dp: post['dp'],
                time: post['time'],
              );
            },
          ), floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  CreateActivite()),
            );
          },
        ),
        ),
      ),

    );
  }
}
