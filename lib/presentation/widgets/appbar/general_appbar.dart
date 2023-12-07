import 'package:flutter/material.dart';

AppBar generalAppBar(BuildContext context, title) {
  return AppBar(
    shadowColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
    ),
    centerTitle: false,
  );
}
