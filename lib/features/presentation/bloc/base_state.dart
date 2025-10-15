abstract class BaseState<K> {
  const BaseState();
}

class BaseInitial extends BaseState {}

class APIFailureState<K> extends BaseState<K> {
  final String error;

  APIFailureState({required this.error});
}
class APILoadingState<K> extends BaseState<K> {}

class UploadLoadingState<K> extends BaseState<K> {}

class ConnectionFailureState<K> extends BaseState<K> {
  final String error;

  ConnectionFailureState({required this.error});
}

class ServerFailureState<K> extends BaseState<K> {
  final String error;

  ServerFailureState({required this.error});
}

