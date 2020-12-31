import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turtlebot/frameworks/no_data_entered.dart';
import 'package:turtlebot/main.dart';
import 'package:turtlebot/objects/data_base_objects.dart';
import 'package:turtlebot/frameworks/custom_dropdown_menu.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:turtlebot/services/alertDialogs/error_messages.dart';

class Messages extends StatefulWidget {
  final MessageController controller = new MessageController();
  final User selectedUser;

  static List<User> items = [];

  Messages(this.selectedUser, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MessageState();
  }
}

class _MessageState extends State<Messages> {
  final channel = MyApp.con();

  TextEditingController _subject = new TextEditingController();
  TextEditingController _message = new TextEditingController();

  ControllerCustomDropdown dropController = ControllerCustomDropdown<User>();

  final colorTheme = Colors.orange;

  double _fontsize = 18;
  double _leftStart = 40;
  double _topSpace = 5;
  double _spaceRightLabel = 20;
  Color textColor = Colors.black;

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

    widget.controller.getData(channel);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            widget.controller.setData(snapshot.data);

            // Logic for Send Message directly Button on Friends Page
            int startValueIndex;
            if (widget.selectedUser != null) {
              for (int i = 0; i < Messages.items.length; i++) {
                if (widget.selectedUser.id == Messages.items[i].id) {
                  dropController.setValue(widget.selectedUser);
                  startValueIndex = i;
                }
              }
            }

            return Container(
              child: Column(
                children: [
                  CustomDropdownLabel(
                    label: Text("Empfänger:", style: TextStyle(
                        color: textColor
                    )),
                    child: CustomDropdownMenu<User>(
                      itemTextStyle: TextStyle(fontSize: Theme.of(context).textTheme.bodyText2.fontSize, color: Colors.black),
                      dropButtonSize: 130,
                      controller: dropController,
                      data: Messages.items,
                      startValueId: startValueIndex,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text("Betreff:", style: TextStyle(
                            color: textColor
                          ),),
                        ),
                        Container(
                          width: 130,
                          child: TextFormField(
                            cursorColor: textColor,
                            controller: _subject,
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              helperStyle: TextStyle(color: textColor),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: textColor, width: 0.25)
                              )
                            ),
                            maxLength: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(0, topSpace, 0, 0),
                        child: Text("Nachricht: ", style: TextStyle(
                            color: textColor
                        ))),
                  ),
                  Container(
                      child: TextFormField(
                    controller: _message,
                    maxLines: null,
                    maxLength: 300,
                        decoration: InputDecoration(
                            helperStyle: TextStyle(color: textColor),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: textColor, width: 0.5)
                            )
                        ),
                  )),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, topSpace, 0, 0),
                    child: RaisedButton(
                      onPressed: () {
                        if (dropController.getValue() != null &&
                            _subject.text.isNotEmpty &&
                            _message.text.isNotEmpty) {
                          widget.controller.sendMessage(
                              dropController.getValue(),
                              _subject.text,
                              _message.text);
                          _showAlertDialog();
                        } else {
                          ErrorMessages.fieldsNotFilled(context);
                        }
                      },
                      child: Text("Auftrag starten"),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text('Diese IP-Adresse führt leider nicht zu einem angemeldet ROS-Laptop, bitte probiere eine andere IP-Adresse');
          }
        });
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Geklappt!'),
              content: Text(
                  'Du hast den Auftrag für ${dropController.getValue().name} gestartet:\n\n${_message.text}'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      _subject.text = '';
                      _message.text = '';
                      Navigator.of(context).pop();
                    },
                    child: Text('Weiter'))
              ]);
        });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
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
      User u =
          new User(users[i]['id'], users[i]['location_id'], users[i]['name']);
      Messages.items.add(u);
    }
  }

  void sendMessage(User user, String subject, String message) {
    WebSocketChannel channel = MyApp.con();

    String data =
        '{"action": "SEND MESSAGE", "from_user": ${MyApp.id}, "to_user": ${user.id}, "subject": "$subject", "message": "$message"}';
    channel.sink.add(data);
  }
}
