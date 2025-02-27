class ApiResponse<T> {
  LoadStatus? status;
  T? data;
  String? message;
  bool? isSuccessful;

  ApiResponse.idle(this.message) : status = LoadStatus.idle;
  ApiResponse.loading(this.message) : status = LoadStatus.loading;
  ApiResponse.loadingNextPage(this.message)
      : status = LoadStatus.loadingNextPage;
  ApiResponse.completed(this.data) : status = LoadStatus.completed;
  ApiResponse.error(this.message) : status = LoadStatus.error;

  ApiResponse.emailConfirmed(this.message) : status = LoadStatus.emailConfirmed;
  ApiResponse.codeVerified(this.message) : status = LoadStatus.codeVerified;
  ApiResponse.isSuccessful(this.isSuccessful)
      : status = LoadStatus.isSuccessful;
  ApiResponse.usernameLoading(this.message)
      : status = LoadStatus.usernameLoading;
}

enum LoadStatus {
  idle,
  loading,
  loadingNextPage,
  completed,
  error,
  emailConfirmed,
  codeVerified,
  isSuccessful,
  usernameLoading,
}
