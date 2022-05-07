import 'dart:convert';

abstract class IHttp<T> {
  Future<T> get();
  Future<T> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
  Future<T> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
  Future<T> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
}
