import 'package:stripe/core/error/failure.dart';

class ServerFailure extends Failure {
  ServerFailure({required super.errMsg});
}
