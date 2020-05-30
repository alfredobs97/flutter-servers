import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servers/bloc/resources_bloc.dart';
import 'package:servers/model/server_model.dart';

class Server extends StatefulWidget {
  final ServerModel server;

  const Server({Key key, this.server}) : super(key: key);
  @override
  _ServerState createState() => _ServerState();
}

class _ServerState extends State<Server> {
  _getResourcesFromServer(context){
    Timer.periodic(Duration(seconds: 20), (timer) {
      BlocProvider.of<ResourcesBloc>(context).add(GetResourcesOfServer(widget.server));
     });
  }

  @override
  void initState() {
    super.initState();
    _getResourcesFromServer(context);
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      child: Row(
        children: <Widget>[
          Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Logo-ubuntu_cof-orange-hex.svg/1200px-Logo-ubuntu_cof-orange-hex.svg.png',
              height: 100,
              width: 100),
         BlocBuilder<ResourcesBloc, ResourcesState>(
           builder: (context, state) {
             if(state is ResourcesLoaded)
             return  Column(
            children: <Widget>[
              Text(widget.server.host),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('CPU: ' + state.resources['CPU'] + '%'),
                  Text('RAM: ' + state.resources['RAM']),
                  Text('DISK: ' + state.resources['DISK']),
                ],
              )
            ],
          );
           },
         )
        ],
      ),
    );
  }
}
