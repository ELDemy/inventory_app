import 'abstract_failure_class.dart';

class Result<T> {
  final T? data;
  final Failure? error;

  Result._(this.data, this.error);

  factory Result.success(T data) => Result._(data, null);
  factory Result.failure(Failure error) => Result._(null, error);

  bool get isSuccess => data != null;
  bool get isFailure => error != null;
}
