import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable{
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  @override
  List<Object?> get props => [
    id,name
  ];


  static List<CategoryModel> categories = [
    CategoryModel(id: 1, name: "Выпечка"),
    CategoryModel(id: 2, name: "Десерты"),
    CategoryModel(id: 3, name: "Кофе"),
    CategoryModel(id: 4, name: "Торты"),
  ];
}