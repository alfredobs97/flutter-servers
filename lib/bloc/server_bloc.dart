import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:servers/model/server_model.dart';
import 'package:servers/repository/server_repository.dart';

part 'server_event.dart';
part 'server_state.dart';

class ServerBloc extends Bloc<ServerEvent, ServerState> {
  final ServerRepository _serverRepository;

  ServerBloc({serverRepository}) : _serverRepository = serverRepository ?? ServerRepository();

  @override
  ServerState get initialState => ServerInitial();

  @override
  Stream<ServerState> mapEventToState(
    ServerEvent event,
  ) async* {
    if (event is InitApp) yield* _mapInitAppToState();
    if (event is TryConnectWithServer) yield* _mapConnectServerToState(event.server);
    if (event is SaveServer) yield* _mapSaveServerToState(event.server);
    if (event is LoadServers) yield* _mapLoadServersToState();

  }

  Stream<ServerState> _mapInitAppToState() async* {
    _serverRepository.getServers().forEach((server) {
      _serverRepository.getOS(server);
    });
    yield ServersLoaded(_serverRepository.getServers());
  }

  Stream<ServerState> _mapConnectServerToState(ServerModel server) async* {
    yield TryingConnect();

    bool hasConnection = await _serverRepository.tryConectWithServer(server);

    if (hasConnection)
      yield ServerConnected();
    else
      yield ServerUnrechable();
  }

  Stream<ServerState> _mapSaveServerToState(ServerModel server) async* {
    _serverRepository.addServer(server);
    yield ServersLoaded(_serverRepository.getServers());
  }

  Stream<ServerState> _mapLoadServersToState() async* {
    _serverRepository.getServers().forEach((server) {
      _serverRepository.getOS(server);
    });
    yield ServersLoaded(_serverRepository.getServers());
  }
}
