import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_app_ui/views/widgets/post_item.dart';
import 'package:social_app_ui/util/data.dart';

import '../widgets/custom_text_field.dart';
import 'notifications.dart';

class CreateActivite extends StatefulWidget {
  @override
  _CreateActivite createState() => _CreateActivite();
}

class _CreateActivite extends State<CreateActivite> {
  TextEditingController nameController = TextEditingController();
  String UserName = '';
  final now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Etkinlik oluştur"),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print("save");
              },
              child: const Text(
                "save",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(0, 139, 182, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child:Center(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                width:  kIsWeb?MediaQuery.of(context).size.width/2  :MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0.0),
                            ),
                          ),
                          backgroundColor: Colors.white70,
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.black26,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _filedRow(size, "Orginazyon Adı", "aaaaa"),
                          _filedRow(size, "Açıklama", "gelgleglelg"),
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            height: kIsWeb ? 30: 50,
                            child: DateTimeFormField(
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.event_note),
                                labelText: 'Tarih',
                                hintText: 'Taridddh',
                              ),
                              autovalidateMode: AutovalidateMode.always,
                              validator: (e) => ((e?.day ?? 0) == now.day && (e?.month ?? 0) == now.month && (e?.year ?? 0) == now.year ) ? 'Please not the first day' : null,
                              onDateSelected: (DateTime value) {
                                print(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _filedRow(Size size, String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: MediaQuery.of(context).size.width/3,
              color: Colors.white24,
              height: kIsWeb ? 30: 50,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: title,
                ),
                onChanged: (text) {
                  setState(() {
                    UserName = text;
                  });
                },
              )
          )
        ],
      ),
    );
  }
}
