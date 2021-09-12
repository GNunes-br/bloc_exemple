// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bloc_exemple/endereco_model.dart';
import 'package:bloc_exemple/myhompage_bloc.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyHomePageBloc bloc = MyHomePageBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) {
                  bloc.input.add(value);
                },
                decoration: InputDecoration(
                  hintText: 'Digite se CEP',
                  border: OutlineInputBorder(),
                ),
              ),
              Center(
                child: StreamBuilder<EnderecoModel>(
                    stream: bloc.output,
                    initialData: EnderecoModel(localidade: ''),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                          'Não foi possível realizar a pesquisa',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        );
                      }

                      EnderecoModel? model = snapshot.data;
                      return Text('Cidade: ${model?.localidade}');
                    }),
              )
            ],
          ),
        ));
  }
}
