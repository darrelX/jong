import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final List<int> list;

  const Person({required this.list});

  @override
  List<Object?> get props => [list];
}

void main() {
  const person1 = Person(list: [3, 4]);
  final person2 = const Person(list: [3, 4]);
  final person3 = const Person(list: [6, 5]);

  print(person1 == person2); // true, car les propriétés sont identiques
  print(person1 == person3); // false, car les propriétés sont différentes
}
