class BaseResponse {
  bool? success;
  String? error;

  BaseResponse({this.success, this.error});

  BaseResponse.fromJson(json) {
    success = true;
    error = null;
  }

  toJson() {
    return {
      'success': success,
      'message': error,
    };
  }
}
