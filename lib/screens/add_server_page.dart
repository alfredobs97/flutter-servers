import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servers/bloc/server_bloc.dart';
import 'package:servers/model/server_model.dart';

class AddServerPage extends StatefulWidget {
  @override
  _AddServerPageState createState() => _AddServerPageState();
}

class _AddServerPageState extends State<AddServerPage> {
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController();
  final _portController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passController = TextEditingController();

  _generateServer() {
    return ServerModel(
        _hostController.text, int.parse(_portController.text), _usernameController.text, _passController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    autocorrect: false,
                    controller: _hostController,
                    decoration: InputDecoration(
                      hintText: 'Dirección servidor',
                    ),
                    validator: (host) {
                      if (host.isEmpty) return 'Introduce una dirección válida';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _portController,
                    decoration: InputDecoration(
                      hintText: 'Puerto SSH',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (port) {
                      if (int.parse(port) <= 0) return 'Introduce un puerto válido';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                    ),
                    validator: (host) {
                      if (host.isEmpty) return 'Introduce un usuario válida';
                      return null;
                    },
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _passController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: MaterialButton(
                            color: Theme.of(context).primaryColor,
                            child: Text('Comprobar conexión'),
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                BlocProvider.of<ServerBloc>(context).add(TryConnectWithServer(_generateServer()));
                              }
                            }),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        fit: FlexFit.tight,
                        child: MaterialButton(
                            color: Theme.of(context).primaryColor,
                            child: Text('Guardar'),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                BlocProvider.of<ServerBloc>(context).add(SaveServer(_generateServer()));
                                Navigator.pop(context);
                              }
                            }),
                      )
                    ],
                  ),
                  BlocBuilder<ServerBloc, ServerState>(
                    builder: (context, state) {
                      if (state is ServerConnected) return Text('Ok');
                      if (state is ServerUnrechable) return Text('Ko');
                      return Container();
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
