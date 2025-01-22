class RequestResponse {
  late bool success;
  String? error;
  // ignore: prefer_typing_uninitialized_variables
  late var data;

  RequestResponse(this.success, {this.error, this.data});

  RequestResponse.fromJson(json) {
    data = json;
    success = json["success"];
    error = json['error'];
  }

  toJson() {
    return {
      'success': success,
      'error': error,
      // 'body': this.data,
    };
  }
}
