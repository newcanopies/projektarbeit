import 'package:flutter/material.dart';
import 'package:turtlebot/objects/data_base_objects.dart';

class CustomDropdownMenu<T extends DatabaseObject> extends StatefulWidget {
  final double fontSize;
  final ControllerCustomDropdown<T> controller;
  final double dropButtonSize;

  CustomDropdownMenu(
      {int startValueId,
      @required this.controller,
      this.fontSize = 18,
        this.dropButtonSize = 130,
      List<T> data,
      Function onChanged}) {
    controller.initialize(startValueId, onChanged, data);
  }

  State<StatefulWidget> createState() {
    return _StateCustomDropdownMenu();
  }
}

class _StateCustomDropdownMenu extends State<CustomDropdownMenu> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        children: [
          Container(
            width: widget.dropButtonSize,
            child: DropdownButton(
                isExpanded: true,
                value: widget.controller.startValueId,
                items: widget.controller
                    ._createDropdownMenuItem(widget.controller.data),
                onChanged: (value) {
                  setState(() {
                    widget.controller.currentIndexValue = value;
                    widget.controller.resetState(value);
                    if(widget.controller.onChanged != null)
                      {
                        widget.controller.onChanged();
                      }
                  });
                }),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}

class ControllerCustomDropdown<T extends DatabaseObject> {
  T value;
  int startValueId;
  int currentIndexValue;

  int getCurrentIndex()
  {
    if(currentIndexValue == null)
      return null;
    else
      return currentIndexValue;
  }

  List<DatabaseObject> data;
  Function onChanged;

  initialize(int startValueId, Function onChanged, List<DatabaseObject> data) {
    this.startValueId = startValueId;
    currentIndexValue = startValueId;
    this.onChanged = onChanged;
    this.data = data;
  }

  void setValue(T value) {
    this.value = value;
  }

  T getValue() {
    if (value != null)
      return value;
    else
      return null;
  }

  List<DropdownMenuItem> _createDropdownMenuItem(List<DatabaseObject> objects) {
    int counter = 0;
    return objects.map((item) {
      return DropdownMenuItem(
        value: counter++,
        child: Text(item.name),
      );
    }).toList();
  }

  void resetState(int value) {
    startValueId = value;
    this.value = data[value];
  }
}

class CustomDropdownLabel extends StatelessWidget {
  final CustomDropdownMenu child;
  final double fontSize;
  final double leftStart;
  final Text label;
  final double labelRightSpace;
  final double topSpace;

  CustomDropdownLabel(
      {@required this.child,
      this.fontSize = 18,
      this.leftStart = 30,
      @required this.label,
      this.labelRightSpace = 20,
      this.topSpace = 15});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, topSpace, 0, 0),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              child: label,
              margin: EdgeInsets.fromLTRB(leftStart, 0, labelRightSpace, 0),
            ),
          ),
          Expanded(
            flex: 5,
            child: child,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
