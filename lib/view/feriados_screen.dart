import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeriadosScreen extends StatefulWidget {
  @override
  _FeriadosScreenState createState() => _FeriadosScreenState();
}

class _FeriadosScreenState extends State<FeriadosScreen> {
  final int ano = 2023;

  Future<List<Map<String, String>>> _getFeriados() async {
    final Uri uri = Uri.parse('https://brasilapi.com.br/api/feriados/v1/$ano');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Parse da resposta JSON
      dynamic jsonResponse = json.decode(response.body);

      // Ajuste aqui: verifique se a resposta é uma lista
      if (jsonResponse is List) {
        List<Map<String, String>> feriados = jsonResponse.map((json) {
          return {
            'name': json['name'].toString(),
            'date': json['date'].toString(),
            'type': json['type'].toString(),
          };
        }).toList();
        return feriados;
      } else {
        // Se for um objeto, trate como um único feriado
        Map<String, String> feriado = {
          'name': jsonResponse['name'].toString(),
          'date': jsonResponse['date'].toString(),
          'type': jsonResponse['type'].toString(),
        };
        return [feriado];
      }
    } else {
      // Trate erros de solicitação
      throw Exception('Falha ao carregar feriados');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feriados $ano'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _getFeriados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum feriado encontrado'));
          } else {
            List<Map<String, String>> feriados = snapshot.data!;

            return ListView.builder(
              itemCount: feriados.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text('Nome: ${feriados[index]['name']}'),
                    subtitle: Text('Data: ${feriados[index]['date']}, Tipo: ${feriados[index]['type']}'),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
        
        },
      ),
    );
  }
}
