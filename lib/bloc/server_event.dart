part of 'server_bloc.dart';

@immutable
abstract class ServerEvent {}

class InitApp extends ServerEvent {}

class LoadServers extends ServerEvent{}

class TryConnectWithServer extends ServerEvent{
  final ServerModel server;

  TryConnectWithServer(this.server);
}

class SaveServer extends ServerEvent{
  final ServerModel server;

  SaveServer(this.server);
}