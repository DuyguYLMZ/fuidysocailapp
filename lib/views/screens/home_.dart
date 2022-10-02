import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_app_ui/views/widgets/post_item.dart';
import 'package:social_app_ui/util/data.dart';

import '../../util/searchdelegate.dart';
import '../widgets/storyviewpage.dart';
import 'create_activite_screen.dart';
import 'notifications.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  Animation<double> gap; //gap between the dashed
  Animation<double> base; //the point of anima
  Animation<double> reverse; //to reverse the animation
  AnimationController controller; // the controller
  var model = [
    "https://images-static.nykaa.com/uploads/f5a1d948-7947-4241-a08e-caac8d991c48.jpg?tr=w-300,cm-pad_resize",
    "https://images-static.nykaa.com/uploads/c622c7aa-7cdb-43ba-98b7-acb48df7f7c5.jpg?tr=w-300,cm-pad_resize",
    "https://images-static.nykaa.com/uploads/fea188e3-9067-4c1f-a3a3-07560f60d73d.jpg?tr=w-300,cm-pad_resize",
    "https://images-static.nykaa.com/uploads/2f2275d3-0b85-4189-8fb3-7318ca1c3bec.jpg?tr=w-300,cm-pad_resize",
    "https://images-static.nykaa.com/uploads/9a4d3606-9aeb-4285-8db1-4918428a1c76.jpg?tr=w-300,cm-pad_resize",
    "https://images-static.nykaa.com/uploads/455bf3cd-82d4-4b2c-ab5d-e56491edc0f1.jpg?tr=w-300,cm-pad_resize",
  ];

  @override
  void initState() {
    super.initState();

// We pass vsync: this to the animation controller to create an Animation controller in a class
// that uses this mixin
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
// curved animation  applies curves to animation
//it is especially used if we want different curves when animation is moving forward or backward

    base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
// A linear interpolation between a beginning and ending value.
    //to revert the animation of the image when borders are animating
    reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);

    gap = Tween<double>(begin: 15.0, end: 0.0)
        .animate(base) //the gap between the dots
      ..addListener(() {
        //.. This syntax means that the addListener() method is called
        // with the return value from animate().
        setState(() {});
      });

    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
       leading : Center(child: Text("Stories")),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CupertinoButton(
              onPressed: () {
                // method to show the search bar
                showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate: CustomSearchDelegate()
                );
              },
              child: const Icon(Icons.search),
            )
          ],
        ),
      ),
      child: kIsWeb
          ? Scaffold(
              body: SafeArea(
              child: Container(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.25,
                    left: MediaQuery.of(context).size.width * 0.25),
                child: Center(
                  child: ListView.builder(
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
            ))
          : SafeArea(
              child: Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.11,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListView.builder(
                              itemCount: model.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                        return StoryViewPage(model, index);
                                      })),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          child: RotationTransition(
                                            //it animates the rotation of widget
                                            turns: base,
                                            child: DashedCircle(
                                              gapSize: gap.value,
                                              dashes: 20,
                                              color: Theme.of(context).primaryColor,
                                              child: RotationTransition(
                                                turns: reverse,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: CircleAvatar(
                                                    radius: 25.0,
                                                    backgroundImage:
                                                    NetworkImage(model[index]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )),
                    Expanded(
                      child: Container(
                      child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map post = posts[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: PostItem(
                                img: post['img'],
                                name: post['name'],
                                dp: post['dp'],
                                time: post['time'],
                              ),
                            ),
                          );
                        },
                      ),
                  ),
                    )],
                ),

              ),
            ),
    );
  }
}
