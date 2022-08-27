class FireBaseAuthErrorsModel {
  String? code;
  String? message;

  FireBaseAuthErrorsModel({
      this.code, 
      this.message,});

  FireBaseAuthErrorsModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message
  };

}