import 'dart:async';

import 'package:homechef/BLoC/bloc.dart';

class NotiFilterBloc implements Bloc {
  
  int _numNoti = 0;
  bool _saveProfileSelect = false;
  Map<String, dynamic> _filterChanges = {
    'numNoti': 0,
    'saveProfileSeleect': false
  };

  int get selectedNoti => _numNoti;
  bool get saveProfileSelect => _saveProfileSelect;
  Map get filterChanges => _filterChanges;

  final _numNotiController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get notiStream => _numNotiController.stream;

  void modifyNoti(Map<String, dynamic> filterChanges) {
    if (filterChanges.containsKey('numNoti')) _numNoti = filterChanges['numNoti'];
    if (filterChanges.containsKey('saveProfileSelect')) _saveProfileSelect = filterChanges['saveProfileSelect'];
    _numNotiController.sink.add(filterChanges);
  }

  @override
  void dispose() {
    _numNotiController.close();
  }
}