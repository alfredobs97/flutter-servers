import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:servers/bloc/resources_bloc.dart';
import 'package:servers/bloc/server_bloc.dart';
import 'package:servers/screens/add_server_page.dart';
import 'package:servers/screens/server.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BlocBuilder<ServerBloc, ServerState>(
        builder: (context, state) {
          if (state is ServerInitial) context.bloc<ServerBloc>().add(InitApp());
          if (state is ServersLoaded) {
            _refreshController.refreshCompleted();
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                context.bloc<ServerBloc>().add(LoadServers());
              },
              child: ListView.builder(
                  itemCount: state.servers.length,
                  itemBuilder: (context, index) {
                    return BlocProvider(
                      create: (context) => ResourcesBloc(),
                      child: Server(server: state.servers[index]),
                    );
                  }),
            );
          }
          return Center(child: Text('Vacío'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddServerPage()));
        },
        child: Icon(Icons.add),
      ),
    ));
  }
}
