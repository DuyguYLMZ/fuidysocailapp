import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  final String dp;
  final String name;
  final String time;
  final String img;

  PostItem(
      {Key key,
      @required this.dp,
      @required this.name,
      @required this.time,
      @required this.img})
      : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  List<String> someList = [
    "imageLink1",
    "imageLink2",
    "imageLink3",
    "imageLink4"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  "${widget.dp}",
                ),
              ),
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "${widget.name}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                "10.10.2000",
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Etkinlik adı: ",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "aaa ",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Konu: ",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "aaa ",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Etkinlik ne yapıyor kardeeeeş!!! sdkfmskldfvksdbaladkaldjalskdjalkjsdklajsdljasljdaklsjdljasdl",
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 30,
                          width: 50,
                          child: TextButton(
                            child: Text(
                              "Katıl",
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.white70,
                              ),
                            ),
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                backgroundColor: Colors.blue,
                                primary: Colors.grey),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  "assets/images/cm0.jpeg",
                  height: kIsWeb ? 180 : 100,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                            children: List.generate(3, (index) {
                          return Positioned(
                              left: (index * (1 - .4) * 40).toDouble(),
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  "${widget.dp}",
                                ),
                              ));
                        })),
                      ),
                    ),
                    Container(
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                            ),
                            onPressed: () {},
                          ),IconButton(
                            icon: Icon(
                              Icons.comment,
                            ),
                            onPressed: () {},
                          ),],
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
