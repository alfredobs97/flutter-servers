import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:servers/model/server_model.dart';
import 'package:servers/repository/resource_repository.dart';

part 'resources_event.dart';
part 'resources_state.dart';

class ResourcesBloc extends Bloc<ResourcesEvent, ResourcesState> {
  final ResourceRepository _resourceRepository;

  ResourcesBloc({resourceRepository}) : _resourceRepository = resourceRepository ?? ResourceRepository();
  @override
  ResourcesState get initialState => ResourcesInitial();

  @override
  Stream<ResourcesState> mapEventToState(
    ResourcesEvent event,
  ) async* {
    if (event is GetResourcesOfServer) yield* _mapGetResourcesFromServerToState(event.server);
  }

  Stream<ResourcesState> _mapGetResourcesFromServerToState(ServerModel server) async* {
    final responses = await _resourceRepository.getResources(server);
    yield ResourcesLoaded(responses);
  }
}
