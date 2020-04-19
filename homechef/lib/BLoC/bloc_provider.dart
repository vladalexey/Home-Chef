import 'package:flutter/material.dart';
import 'package:homechef/BLoC/bloc.dart';
import 'package:homechef/BLoC/bloc_filter_noti.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  // 3
  static Type _providerType<T>() => T;

  // 2
  static T of<T extends Bloc>(BuildContext context) {
    final Type type = _providerType<BlocProvider<T>>();
    print("Type: " + type.toString());
    final BlocProvider provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider.bloc;
  }

  

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  // 4
  @override
  Widget build(BuildContext context) => widget.child;

  // 5
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}