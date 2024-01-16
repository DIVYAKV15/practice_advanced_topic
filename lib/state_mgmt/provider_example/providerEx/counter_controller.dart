import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/state_mgmt/provider_example/models/count.dart';

//to set the changes
//changeNotifier in supporting class form material
//it helps to notify the provider
//then provider will reflect the changes in ui
class CounterProvider extends ChangeNotifier {
  Count _incValue = Count(0);
  Count get counter_value =>//value from _incValue accessible through this get property
      _incValue; //to acces the  private variable outside we have to use get properties
  void increment_counter() {
    _incValue.value++; //.value is using because incvalue is object
    notifyListeners(); //to update changes in the provider then only it reflect in ui
  }
}
