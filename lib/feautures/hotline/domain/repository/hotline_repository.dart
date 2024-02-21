abstract class HotlineRepository {
  Future<void> callHotline();
  Future<int> getHotlineCountForUser();
}