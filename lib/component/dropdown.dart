import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  @override
  _Dropdown createState() => _Dropdown();
}

class _Dropdown extends State<Dropdown> {

  final FocusNode _focusNode = FocusNode();

  OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {

        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);

      } else {
        this._overlayEntry.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {

    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: this._layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  title: Text('Syria'),
                  onTap: () {
                    print('Syria Tapped');
                  },
                ),
                ListTile(
                  title: Text('Lebanon'),
                  onTap: () {
                    print('Lebanon Tapped');
                  },
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: TextFormField(
          focusNode: this._focusNode,
        decoration: InputDecoration(
          labelText: 'Country'
        ),
      ),
    );
  }
}