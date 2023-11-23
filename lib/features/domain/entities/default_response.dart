class DefaultResponse {
  const DefaultResponse({this.message});

  final String? message;

  factory DefaultResponse.fromJson(Map<String, dynamic> json) {
    return DefaultResponse(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
