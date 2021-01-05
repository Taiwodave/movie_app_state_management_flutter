//Generic Interface for all BLoCs
import 'package:flutter/widgets.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  const BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final Widget child;
  final T bloc;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    //final type = _typeOf<BlocProvider<T>>();
    final provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider.bloc;
  }

  //static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
