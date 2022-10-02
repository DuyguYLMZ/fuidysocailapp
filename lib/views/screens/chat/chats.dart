import 'package:flutter/material.dart';
import 'package:social_app_ui/views/widgets/chat_item.dart';
import 'package:social_app_ui/util/data.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 1);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Message'),
      ),
      body: Container(
        child: ListView.separated(
          padding: EdgeInsets.all(10),
          separatorBuilder: (BuildContext context, int index) {
            return Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 0.5,
                width: MediaQuery.of(context).size.width / 1.3,
                child: Divider(),
              ),
            );
          },
          itemCount: chats.length,
          itemBuilder: (BuildContext context, int index) {
            Map chat = chats[index];
            return Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Expanded(
                child: ChatItem(
                  dp: chat['dp'],
                  name: chat['name'],
                  isOnline: chat['isOnline'],
                  counter: chat['counter'],
                  msg: chat['msg'],
                  time: chat['time'],
                ),
              ),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.search,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {},
      // ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
