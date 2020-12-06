import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turtlebot/main.dart';
import 'package:turtlebot/objects/data_base_objects.dart';
import 'package:turtlebot/frameworks/custom_dropdown_menu.dart';
import 'package:turtlebot/services/routing.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class Messages extends StatefulWidget {
  final MessageController controller = new MessageController();
  final channel = MyApp.con();
  final User selectedUser;

  static List<User> items = [];

  Messages(this.selectedUser, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MessageState();
  }
}

class _MessageState extends State<Messages> {
  TextEditingController _subject = new TextEditingController();
  TextEditingController _message = new TextEditingController();

  ControllerCustomDropdown dropController = ControllerCustomDropdown<User>();

  final colorTheme = Colors.orange;

  double _fontsize = 18;
  double _leftStart = 40;
  double _topSpace = 15;
  double _spaceRightLabel = 20;

  get spaceRightLabel {
    return _spaceRightLabel;
  }

  get topSpace {
    return _topSpace;
  }

  get fontsize {
    return _fontsize;
  }

  get leftStart {
    return _leftStart;
  }

  @override
  void initState() {
    super.initState();

    widget.controller.getData(widget.channel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              RouteGenerator.onTapToHome(context);
            }),
        title: Text("Nachricht senden"),
        backgroundColor: colorTheme,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                  stream: widget.channel.stream,
                  builder: (context, snapshot) {

                    widget.controller.setData(snapshot.data);

                    // Logic for Send Message directly Button on Friends Page
                    int startValueIndex;
                    if(widget.selectedUser != null) {
                      for(int i = 0; i < Messages.items.length; i++) {
                        if(widget.selectedUser.id == Messages.items[i].id) {
                          dropController.setValue(widget.selectedUser);
                          startValueIndex = i;
                        }
                      }
                    }

                    return CustomDropdownLabel(
                      label: "Empfänger",
                      child: CustomDropdownMenu<User>(
                        controller: dropController,
                        data: Messages.items,
                        startValueId: startValueIndex,
                      ),
                    );
                  }
              ),
              Container(
                margin: EdgeInsets.fromLTRB(leftStart, 15, 20, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Container(
                          child: Text(
                        "Betreff:",
                        style: TextStyle(fontSize: fontsize),
                      )),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _subject,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(),
                        maxLength: 25,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.fromLTRB(
                        leftStart, topSpace, 0, 0),
                    child: Text("Nachricht: ",
                        style: TextStyle(fontSize: fontsize))),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    leftStart, topSpace, leftStart, 0),
                child: TextFormField(
                  controller: _message,
                  maxLines: null,
                  maxLength: 300,
                )),
              Container(
                margin: EdgeInsets.fromLTRB(0, topSpace, 0, 0),
                child: RaisedButton(
                  onPressed: () {

                    if(dropController.getValue() != null && _subject.text.isNotEmpty && _message.text.isNotEmpty) {
                      widget.controller.sendMessage(dropController.getValue(), _subject.text, _message.text);
                      _showAlertDialog(true);
                    }
                    else {
                      _showAlertDialog(false);
                    }
                  },
                  child: Text("Auftrag starten"),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  void _showAlertDialog(bool success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: success ? Text('Geklappt!'): Text('Fehler'),
          content: success ? Text(
              'Du hast den Auftrag für ${dropController.getValue().name} gestartet:\n\n${_message.text}'
          ) : Text('Alle Felder ausfüllen'),
          actions: <Widget> [
              FlatButton(
                onPressed: (){
                  if(success) {
                    RouteGenerator.onTapToMessages(context);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Ok'))
          ]
        );
      }
    );
  }
}

class MessageController {

  void getData(WebSocketChannel channel) {
    String data = '{"action": "GET USERS"}';
    channel.sink.add(data);
  }

  void setData(json) {
    Messages.items = [];

    String jsonDataString = json.toString();
    var users = jsonDecode(jsonDataString);

    for (int i = 0; i < users.length; i++) {
      User u = new User(
          users[i]['id'], users[i]['location_id'],
          users[i]['name']);
      Messages.items.add(u);
    }
  }

  void sendMessage(User user, String subject, String message) {
    WebSocketChannel channel = MyApp.con();

    String data = '{"action": "SEND MESSAGE", "from_user": ${MyApp.id}, "to_user": ${user.id}, "subject": "$subject", "message": "$message"}';
    channel.sink.add(data);
  }
}
