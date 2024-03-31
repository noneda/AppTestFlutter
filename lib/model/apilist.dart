class Apires<T> {
  T data;
  bool error;
  String errorMessage;

  Apires({required this.data, this.error = false, required this.errorMessage});
}
