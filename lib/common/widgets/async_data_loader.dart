import 'package:flutter/material.dart';

class AsyncDataLoader<T> extends StatelessWidget {
  final Future<T?> future; // Accepts a Future<T?>
  final Widget Function(T data) builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? nullDataWidget; // Widget to display when data is null

  const AsyncDataLoader({
    super.key,
    required this.future,
    required this.builder,
    this.loadingWidget,
    this.errorWidget,
    this.nullDataWidget,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ?? Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return errorWidget ?? Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return nullDataWidget ?? Center(child: Text('No data available'));
        } else {
          return builder(snapshot.data!);
        }
      },
    );
  }
}