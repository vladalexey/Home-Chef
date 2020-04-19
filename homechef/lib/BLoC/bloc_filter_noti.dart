import 'dart:async';

import 'package:homechef/BLoC/bloc.dart';

class NotiFilterBloc implements Bloc {
  
  int _numNoti = 0;
  int get selectedNoti => _numNoti;
  
  final _numNotiController = StreamController<int>.broadcast();

  Stream<int> get notiStream => _numNotiController.stream;

  void modifyNoti(int numNoti) {
    _numNoti = numNoti;
    _numNotiController.sink.add(numNoti);
  }

  @override
  void dispose() {
    _numNotiController.close();
  }
}