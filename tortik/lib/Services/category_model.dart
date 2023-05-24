import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;

  const CategoryModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  static List<CategoryModel> categories = [
    const CategoryModel(id: 1, name: "Выпечка"),
    const CategoryModel(id: 2, name: "Десерты"),
    const CategoryModel(id: 3, name: "Кофе"),
    const CategoryModel(id: 4, name: "Торты"),
  ];
}
