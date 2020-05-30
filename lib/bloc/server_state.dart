part of 'server_bloc.dart';

@immutable
abstract class ServerState {}

class ServerInitial extends ServerState {}

class TryingConnect extends ServerState{}

class ServerConnected extends ServerState{}

class ServerUnrechable extends ServerState {}

class ServersLoaded extends ServerState {
  final List<ServerModel> servers;

  ServersLoaded(this.servers);
}


