import 'package:flutter/material.dart';

import 'package:bloc_state_management/bloc/counter_bloc.dart';

class BtnAction extends StatefulWidget {
  final CounterAction type;

  BtnAction(this.type);

  @override
  _BtnActionState createState() => _BtnActionState();
}

class _BtnActionState extends State<BtnAction> {
  String tooltip;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    getAction();
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        counterBloc.eventSink.add(this.widget.type);
      },
      tooltip: tooltip,
      child: Icon(icon),
    );
  }

  void getAction() {
    if (this.widget.type == CounterAction.Increment) {
      tooltip = 'Increment';
      icon = Icons.add;
    } else if (this.widget.type == CounterAction.Dicrement) {
      tooltip = 'Dicrement';
      icon = Icons.remove;
    } else if (this.widget.type == CounterAction.Reset) {
      tooltip = 'Reset';
      icon = Icons.loop;
    }
  }
}
