import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class Parent {
  int a;
  Parent({required this.a});
}

class Child extends Parent {
  Child({
    required super.a,
  });
}

void main() {
  Parent parent = Parent(a: 10);
  print(parent.a);
  Child child = Child(a: 23);
  print(child.a);
  print(parent.a);

}
