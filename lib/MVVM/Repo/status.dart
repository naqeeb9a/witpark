class Failure {
  int code;
  Object errorResponse;
  Failure(this.code, this.errorResponse);
}

class Success {
  int? code;
  late Object response;
  Success(this.code, this.response);
}
