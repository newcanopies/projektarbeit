import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turtlebot/frameworks/no_data_entered.dart';
import 'package:turtlebot/frameworks/on_delete.dart';
import 'package:turtlebot/frameworks/top_app_bar_logout.dart';
import 'package:turtlebot/main.dart';
import 'package:turtlebot/objects/data_base_objects.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Robos extends StatefulWidget {
  final RoboController controller = new RoboController();
  static final colorTheme = Colors.blue;

  static List<Robo> items = [];

  Robos({Key key}) : super(key: key);

  @override
  _RoboState createState() {
    return _RoboState();
  }
}

class _RoboState extends State<Robos> {
  final WebSocketChannel channel = MyApp.con();

  @override
  void initState() {
    super.initState();
    widget.controller.getData(channel);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              widget.controller.setData(snapshot.data);

              return Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text("Robos",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Theme.of(context)
                                .textTheme
                                .headline1
                                .fontSize)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: AnimatedList(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    key: widget.controller.key,
                    initialItemCount: Robos.items.length,
                    itemBuilder: (context, index, animation) {
                      return widget.controller.buildItem(
                          context, Robos.items[index], animation, index);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: RaisedButton(
                    onPressed: () {
                      addItemDialog(context);
                    },
                    child: Text("Hinzufügen"),
                  ),
                )
              ]);
            } else {
              return Text('');
            }
          });
  }

  void addItemDialog(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _ip = TextEditingController();

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: AlertDialog(
          title: Text("Neuen Robo hinzufügen"),
          content: Column(
            children: <Widget>[
              TextField(
                controller: _name,
                decoration: InputDecoration(labelText: "Name"),
                maxLines: null,
                maxLength: 20,
              ),
              TextField(
                controller: _ip,
                decoration: InputDecoration(labelText: "IP-Addresse"),
                maxLines: null,
                maxLength: 20,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Schließen"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Hinzufügen"),
              onPressed: () {
                if (_name.text.isNotEmpty && _ip.text.isNotEmpty) {
                  widget.controller.addItem(_name.text, _ip.text);
                  Navigator.of(context).pop();
                } else {
                  NoDataDialog.noLoginData(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}

class RoboController {
  final GlobalKey<AnimatedListState> key = GlobalKey();

  void getData(WebSocketChannel channel) {
    String data = '{"action": "GET ROBOS"}';
    channel.sink.add(data);
  }

  void setData(json) {
    Robos.items = [];

    String jsonDataString = json.toString();
    var robos = jsonDecode(jsonDataString);

    for (int i = 0; i < robos.length; i++) {
      Robo r = new Robo(robos[i]['id'], robos[i]['name'], robos[i]['ip']);
      Robos.items.add(r);
    }
  }

  void removeItem(Robo robo, int index) {
    WebSocketChannel channel = MyApp.con();
    String data = '{"action": "DELETE ROBO", "id": "${robo.id}"}';
    channel.sink.add(data);

    AnimatedListRemovedItemBuilder build = (context, animation) {
      return buildItem(context, robo, animation, index);
    };
    key.currentState.removeItem(index, build);
    Robos.items.remove(robo);
  }

  void addItem(String name, String ip) {
    WebSocketChannel channel = MyApp.con();
    String data = '{"action": "ADD ROBO", "name": "$name", "ip": "$ip"}';
    channel.sink.add(data);

    channel.stream.listen((json) async {
      if (json != '') {
        String jsonDataString = json.toString();
        final jsonData = jsonDecode(jsonDataString);

        Robo robo = new Robo(jsonData['id'], jsonData['name'], jsonData['ip']);

        AnimatedListItemBuilder build = (context, index, animation) {
          return buildItem(context, Robos.items[index], animation, index);
        };
        Robos.items.add(robo);
        key.currentState.insertItem(0);
        // print(key.currentState.length)
      }
    });
  }

  Widget buildItem(
      BuildContext context, Robo item, Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Row(
                  children: <Widget>[
                    Text(item.name),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    Text(item.iP),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        bool delete = await OnDelete.onDelete(context);
                        if (delete != null && delete) {
                          removeItem(item, index);
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
