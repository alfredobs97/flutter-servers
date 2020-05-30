part of 'resources_bloc.dart';

@immutable
abstract class ResourcesEvent {}

class GetResourcesOfServer extends ResourcesEvent{
  final ServerModel server;

  GetResourcesOfServer(this.server);
}