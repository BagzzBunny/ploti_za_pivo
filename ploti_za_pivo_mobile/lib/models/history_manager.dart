import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ploti_za_pivo_mobile/utils/event_handler.dart';

import 'event.dart';
import 'member.dart';

class HistoryManager extends ChangeNotifier{
  List<Event> items = [];
  bool editingSequence = false;
  
  HistoryManager(){
    var cart = Cart(DateTime.now(),'Пример покупки');
    cart.addMember(Member('Вася',true,130));
    cart.addMember(Member('Маша',true,10));
    cart.addMember(Member('Петя',false,0));
    cart.addProduct(Product('A',5,100));
    cart.addProduct(Product('B',1,30));
    cart.addProduct(Product('C',1,10));
    cart.addBind(Bind(cart.getMember('Вася'),cart.getProduct('A'),5));
    cart.addBind(Bind(cart.getMember('Петя'),cart.getProduct('A'),5));
    cart.addBind(Bind(cart.getMember('Маша'),cart.getProduct('B'),1));
    cart.addBind(Bind(cart.getMember('Вася'),cart.getProduct('C'),1));
    cart.addBind(Bind(cart.getMember('Петя'),cart.getProduct('C'),1));
    cart.calculateResult();
    addEvent(cart);
    var anotherCart = Cart(DateTime.now(),'Пример покупки');
    anotherCart.copyCart(cart);
    addEvent(anotherCart);
    var sequence = EventSequence(DateTime.now(), 'Пример путешествия');
    var cart2 = Cart(DateTime.now(),'Пример покупки');
    cart2.copyCart(cart);
    sequence.addCart(cart2);
    var cart3 = Cart(DateTime.now(),'Пример покупки');
    cart3.copyCart(cart);
    sequence.addCart(cart3);
    sequence.calculateResult();
    addEvent(sequence);
  }

  void addEvent(Event event) {
    if (!items.contains(event)){
      items.add(event);
    }
    notifyListeners();
  }

  void removeEvent(Event event) {
    items.remove(event);
    notifyListeners();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/saved_coupons');
  }



  void _writeJson(String key, dynamic value) async {
    // Initialize the local _filePath
    final _filePath = await _localFile;
    Map<String, dynamic> _json = {};
    String _jsonString;

    //1. Create _newJson<Map> from input<TextField>
    Map<String, dynamic> _newJson = {key: value};
    print('1.(_writeJson) _newJson: $_newJson');

    //2. Update _json by adding _newJson<Map> -> _json<Map>
    _json.addAll(_newJson);
    print('2.(_writeJson) _json(updated): $_json');

    //3. Convert _json ->_jsonString
    _jsonString = jsonEncode(_json);
    print('3.(_writeJson) _jsonString: $_jsonString\n - \n');

    //4. Write _jsonString to the _filePath
    _filePath.writeAsString(_jsonString);
  }

  Future<dynamic> _readJson() async {
    // Initialize _filePath
    final _filePath = await _localFile;
    Map<String, dynamic> _json = {};
    String _jsonString;

    // 0. Check whether the _file exists
    bool _fileExists = await _filePath.exists();
    print('0. File exists? $_fileExists');

    // If the _file exists->read it: update initialized _json by what's in the _file
    if (_fileExists) {
      try {
        //1. Read _jsonString<String> from the _file.
        _jsonString = await _filePath.readAsString();
        print('1.(_readJson) _jsonString: $_jsonString');

        //2. Update initialized _json by converting _jsonString<String>->_json<Map>
        _json = jsonDecode(_jsonString);
        print('2.(_readJson) _json: $_json \n - \n');
        return _json;
      } catch (e) {
        // Print exception errors
        print('Tried reading _file error: $e');
        // If encountering an error, return null
      }
    }
  }


}