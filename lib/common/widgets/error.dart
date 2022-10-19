



import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({required this.error});

  @override
  Widget build(BuildContext context) {
     return Center(
      child: Text(error),
     );
  }
}