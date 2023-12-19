abstract interface class IApiClient {
  Future<T?> fetch<T>({required Uri apiUri, String? param});
}
