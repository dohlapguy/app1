import 'package:app1/core/error/failure.dart';
import 'package:dartz/dartz.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid<T> = ResultFuture<void>;
