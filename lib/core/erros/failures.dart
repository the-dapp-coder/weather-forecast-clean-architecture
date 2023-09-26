import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  const Failures([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class InternetConnectionFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class UnknownFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class PermissionBlockedFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class PermissionBlockedForeverFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class LocationServiceDisabledFailure extends Failures {
  @override
  List<Object?> get props => [];
}
