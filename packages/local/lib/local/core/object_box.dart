abstract class ObjectBox {
  Future<void> init();
  Future<void> save<T>(T localEntity);
  Future<List<T>> getAll<T>();
  Future<T?> get<T>(int id);
  Future<void> removeAll<T>();
  Future<void> remove<T>(int id);
  Future<void> put<T>(T localEntity);
}
