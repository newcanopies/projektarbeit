import 'package:flutter/material.dart';
import 'package:turtlebot/frameworks/top_app_bar_logout.dart';
import 'package:turtlebot/services/routing.dart';
import 'package:turtlebot/main.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class Controls extends StatefulWidget {
  final ControlController controller = new ControlController();
  Color textColor = Colors.white;
  Color backgroundColor = Colors.green;
  Color borderActionButtonColor = Colors.white;
  Color controlPadBackground = Color(0xffe7ebda);
  Color borderConrolPadBackground = Colors.green;
  double borderFloatingWidth = 3.0;

  Controls({Key key}) : super(key: key);

  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBarLogout(
          colorTheme: widget.backgroundColor,
          page: "Controlling"
      ),
      body: Container(
        child: Container(
          height: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.grey,
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                        child: Center(child: Mjpeg(
                          isLive: true,
                          stream:"http://192.168.2.105:8080/stream?topic=/Face_Recognition_Stream",
                        ) )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.borderConrolPadBackground,
                      width: 4.0,
                    ),
                    shape: BoxShape.circle,
                    color: widget.controlPadBackground,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: widget.borderActionButtonColor,
                              width: widget.borderFloatingWidth,
                            )),
                        child: FloatingActionButton(
                            backgroundColor: widget.backgroundColor,
                            heroTag: "up",
                            onPressed: () {
                              widget.controller.up();
                            },
                            child: Icon(Icons.arrow_upward,
                                color: widget.textColor)),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: widget.borderActionButtonColor,
                                      width: widget.borderFloatingWidth,
                                    )),
                                margin: EdgeInsets.fromLTRB(0, 0, 70, 0),
                                child: FloatingActionButton(
                                    onPressed: () {
                                      widget.controller.left();
                                    },
                                    backgroundColor: widget.backgroundColor,
                                    heroTag: "left",
                                    child: Icon(Icons.arrow_back_rounded,
                                        color: widget.textColor))),
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: widget.borderActionButtonColor,
                                      width: widget.borderFloatingWidth,
                                    )),
                                child: FloatingActionButton(
                                    onPressed: () {
                                      widget.controller.right();
                                    },
                                    backgroundColor: widget.backgroundColor,
                                    heroTag: "right",
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      color: widget.textColor,
                                    )))
                          ],
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: widget.borderActionButtonColor,
                                  width: widget.borderFloatingWidth)),
                          child: FloatingActionButton(
                              onPressed: () {
                                widget.controller.down();
                              },
                              heroTag: "down",
                              backgroundColor: widget.backgroundColor,
                              child: Icon(Icons.arrow_downward_rounded,
                                  color: widget.textColor))),
                    ],
                  ),
                ),
                Container(
                    width: 200,
                    height: 40,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: RaisedButton(
                      onPressed: () {
                        widget.controller.stop();
                      },
                      child: Text("Stop"),
                    ))
              ]),
        ),
      ),
    );
  }
}

class ControlController {
  void up() {
    WebSocketChannel channel = MyApp.con();
    String data = '{"action": "UP"}';
    channel.sink.add(data);
  }

  void down() {
    WebSocketChannel channel = MyApp.con();
    String data = '{"action": "DOWN"}';
    channel.sink.add(data);
  }

  void right() {
    WebSocketChannel channel = MyApp.con();
    String data = '{"action": "RIGHT"}';
    channel.sink.add(data);
  }

  void left() {
    WebSocketChannel channel = MyApp.con();
    String data = '{"action": "LEFT"}';
    channel.sink.add(data);
  }

  void stop() {
    WebSocketChannel channel = MyApp.con();
    String data = '{"action": "STOP"}';
    channel.sink.add(data);
  }
}