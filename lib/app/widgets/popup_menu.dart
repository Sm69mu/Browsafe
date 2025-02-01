import 'package:flutter/material.dart';

class PopupMenuOnLongPress extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Popup Menu on Long Press'),
            ),
            body: Center(
                child: GestureDetector(
                    onLongPress: () {
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(100, 100, 100, 100),
                            items: [
                                PopupMenuItem(
                                    child: Text('Item 1'),
                                    value: 'item1',
                                ),
                                PopupMenuItem(
                                    child: Text('Item 2'),
                                    value: 'item2',
                                ),
                            ],
                        ).then((value) {
                            if (value != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('You selected: $value')),
                                );
                            }
                        });
                    },
                    child: Container(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.blue,
                        child: Text(
                            'Long Press Me',
                            style: TextStyle(color: Colors.white),
                        ),
                    ),
                ),
            ),
        );
    }
}

