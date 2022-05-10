abstract class IRepository<T> {
  Future<List<T>> getEntityList(int coupleId);
  void insert(T entity, int coupleId);
}
