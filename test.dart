import 'package:http/http.dart' as http;

void main() async {
  final url = Uri.parse('http://localhost:3000/register');

  try {
    // Les données à envoyer dans la requête POST
    final data = {
      'name': 'John',
      'password': 'Doe',
      'email': 'john.doe@example.com',
    };

    // Faire la requête POST
    final response = await http.post(
      url,
      body: data,
      headers: {'Content-Type': 'application/json'},
    );

    // Traiter la réponse
    print(response.body);
  } catch (error) {
    // Gérer les erreurs
    print('Erreur lors de la requête POST : $error');
  }
}
