import 'package:flutter/material.dart';
import 'package:turtlebot/databaseObjects/data_base_objects.dart';

class CustomDropdownMenu<T> extends StatefulWidget {
  @override
  T value;
  int counter;
  double fontSize;
  double leftStart;
  String label;
  double labelRightSpace;
  double topSpace;
  List<DatabaseObject> data;
  ControllerCustomDropdown<T> controller;
  State<CustomDropdownMenu> version;

  CustomDropdownMenu(
      {this.counter,
      @required this.controller,
      this.fontSize = 18,
      this.leftStart = 40,
      this.label,
      this.labelRightSpace = 20,
      this.topSpace = 15,
      @required this.data});

  State<StatefulWidget> createState() {
    controller.initialize(this);

    if (label == null)
      return _StateCustomDropdownMenuWithoutLabel();
    else
      return _StateCustomDropdownMenu();
  }
}

class _StateCustomDropdownMenu extends State<CustomDropdownMenu> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, widget.topSpace, 0, 0),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              child: Text(widget.label + ":",
                  style: TextStyle(fontSize: widget.fontSize)),
              margin: EdgeInsets.fromLTRB(
                  widget.leftStart, 0, widget.labelRightSpace, 0),
            ),
          ),
          Expanded(
            flex: 3,
            child: DropdownButton(
              isExpanded: true,
              value: widget.counter,
              hint: Text(widget.label),
              items: widget.controller._createDropdownMenuItem(widget.data),
              onChanged: (value) {
                setState(() {
                  widget.controller.resetState(value);
                });
              },
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}

class _StateCustomDropdownMenuWithoutLabel extends State<CustomDropdownMenu> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, widget.topSpace, 0, 0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: DropdownButton(
              isExpanded: true,
              value: widget.counter,
              items: widget.controller._createDropdownMenuItem(widget.data),
              onChanged: (value) {
                setState(() {
                  widget.controller.resetState(value);
                });
              },
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}

class ControllerCustomDropdown<T> {
  CustomDropdownMenu _widgetDrop;

  initialize(CustomDropdownMenu child) {
    this._widgetDrop = child;
  }

  T getValue() {
    if (_widgetDrop.value != null)
      return _widgetDrop.value;
    else
      return null;
  }

  List<DropdownMenuItem> _createDropdownMenuItem(List<DatabaseObject> objects) {
    return objects.map((row) {
      return DropdownMenuItem(
        value: row.id,
        child: Text(row.name),
      );
    }).toList();
  }

  void resetState(dynamic value) {
    _widgetDrop.counter = value;
    _widgetDrop.value = _widgetDrop.data[value - 1];
  }
}
