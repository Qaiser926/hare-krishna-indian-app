
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:harekrishnagoldentemple/NoInternet.dart';

class CheckInterConnection extends StatefulWidget {
  final AsyncSnapshot<ConnectivityResult> snapshot;
  final Widget widget;
  CheckInterConnection({required this.snapshot,required this.widget});

  @override
  State<CheckInterConnection> createState() => _CheckInterConnectionState();
}

class _CheckInterConnectionState extends State<CheckInterConnection> {
  @override
  Widget build(BuildContext context) {
   
    switch(widget.snapshot.connectionState){
      case ConnectionState.active:
        final state=widget.snapshot.data;
        switch(state){
          case ConnectivityResult.none:
            return Center(child: NoInternet(),);
          default:
            return widget.widget;
        }
      default:
        return widget.widget;
    }
  }
}