

/// [Type} = Response
/// [T] = parameters
abstract class UseCases<TResult, TParams> {
  Future<TResult> call(TParams params);
}

class NoParams {}
