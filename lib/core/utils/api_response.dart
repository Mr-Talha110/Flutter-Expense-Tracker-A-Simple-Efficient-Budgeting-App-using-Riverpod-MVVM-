class ApiResponse<T> {
  LoadStatus? status;
  T? data;
  String? message;
  bool? isSuccessful;

  ApiResponse.idle(this.message) : status = LoadStatus.idle;
  ApiResponse.loading(this.message) : status = LoadStatus.loading;
  ApiResponse.completed(this.data) : status = LoadStatus.completed;
  ApiResponse.error(this.message) : status = LoadStatus.error;

  ApiResponse.isSuccessful(this.isSuccessful)
      : status = LoadStatus.isSuccessful;
}

enum LoadStatus {
  idle,
  loading,
  completed,
  error,
  isSuccessful,
}
