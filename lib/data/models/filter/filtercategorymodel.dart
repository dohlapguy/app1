// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../models.dart';

class CategoryFilter extends Equatable {
  final int id;
  final Category category;
  final bool value;

  const CategoryFilter(
      {required this.id, required this.category, required this.value});

  @override
  List<Object?> get props => [id, category, value];

  CategoryFilter copyWith({
    int? id,
    Category? catergory,
    bool? value,
  }) {
    return CategoryFilter(
      id: id ?? this.id,
      category: catergory ?? this.category,
      value: value ?? this.value,
    );
  }

  static List<CategoryFilter> filters = Category.categories
      .map((category) =>
          CategoryFilter(id: category.id, category: category, value: false))
      .toList();
}
