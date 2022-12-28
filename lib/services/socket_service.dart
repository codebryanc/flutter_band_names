import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  online,
  offline,
  connecting
}

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.connecting;
  get serverStatus => _serverStatus;

  // Constructor
  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    IO.Socket socket = IO.io('http://localhost:3000/', {
      'transports': ['websocket'],
      'autoConnect': true
    });
    
    socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    // Events
    socket.on('nuevo-mensaje', (payload) {
      print('nuevo-mensaje:');
      
      printAndValidateProperty('nombre', payload);
      printAndValidateProperty('mensaje', payload);
      printAndValidateProperty('mensaje2', payload);
    });
  }

  void printAndValidateProperty(String property, dynamic sourcePayload) {
    if(sourcePayload.containsKey(property)) {
      if (kDebugMode) {
        print('$property: ' + sourcePayload[property]);
      }
    }
  }

}