import 'dart:async';

import 'package:bloc_exemple/endereco_model.dart';
import 'package:dio/dio.dart';

class MyHomePageBloc {
  final StreamController<String> _streamController = StreamController<String>();
  Sink<String> get input => _streamController.sink;
  Stream<EnderecoModel> get output => _streamController.stream
      .where((cep) => cep.length > 7)
      .asyncMap((cep) => _searchCep(cep));

  String url(String cep) => 'https://viacep.com.br/ws/$cep/json/unicode/';

  Future<EnderecoModel> _searchCep(String cep) async {
    Response response = await Dio().get(url(cep));
    return EnderecoModel.fromJson(response.data);
  }
}
