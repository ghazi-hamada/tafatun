import 'package:tafatun/core/class/crud.dart';

class SendEmail {
  Crud crud;
  SendEmail(this.crud);
  postdata({
    required String email,
    required String subject,
    required String message,
  }) async {
    var response =
        await crud.postData("https://appghazi.tech/ecommerce/test.php", {
      'email': email,
      'subject': subject,
      'message': message,
    });
    return Future.value(response.fold((l) => l, (r) => r));
  }
}
