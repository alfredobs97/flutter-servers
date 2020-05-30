part of 'resources_bloc.dart';

@immutable
abstract class ResourcesState {}

class ResourcesInitial extends ResourcesState {}


class ResourcesLoaded extends ResourcesState{
  final Map<String, String> resources;

  ResourcesLoaded(this.resources);
}