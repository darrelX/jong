import 'package:dio/dio.dart';

void main() {
  const token = '2000'; // Remplacez par votre propre token

  const url = 'http://localhost:3000/register';
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    'email': '',
    'password': '',
    'name': ''
  };

  Dio().post(url, options: Options(headers: headers)).then((response) {
    print(response.headers);
    if (response.statusCode == 200) {
      final data = response.data;
      print(data);
      // Traitez la réponse de la requête ici
    } else {
      throw Exception('Erreur de requête');
    }
  }).catchError((error) {
    print(error);
    // Traitez les erreurs de requête ici
  });
}
