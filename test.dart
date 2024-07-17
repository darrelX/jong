// import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() async {
  // final url = Uri.parse('http://localhost:3000/register');

  // try {
  //   // Les données à envoyer dans la requête POST
  //   final data = {
  //     'name': 'John',
  //     'password': 'Doe',
  //     'email': 'john.doe@example.com',
  //   };

  //   // Faire la requête POST
  //   final response = await http.post(
  //     url,
  //     body: data,
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   // Traiter la réponse
  //   print(response.body);
  // } catch (error) {
  //   // Gérer les erreurs
  //   print('Erreur lors de la requête POST : $error');
  // }

  //  String dateString = '2024-07-09T03:35:22.000000Z';

  // DateTime dateTime = DateTime.parse(dateString);

  // final DateTime a = DateTime.now();
  // final b = DateFormat('dd/MM/yyyy').format(dateTime);
  // final c = DateFormat('HH:mm').format(dateTime);

  // print(dateTime); // Affiche : 2024-07-09 03:35:22.000Z
  // print("$b $c");
  // PartA part = PartA(a: 0);
  // print(part.b );

  final Map a = {
    '1': 1,
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
  };

  final dd = a.values.where((a) {
    return a > 0;
  }).map((i) {
    return i;
  });

  print(dd);
}
