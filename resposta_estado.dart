import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RespostaEstado extends StatefulWidget {
  const RespostaEstado({super.key});

  @override
  State<RespostaEstado> createState() => _RespostaEstadoState();
}

class _RespostaEstadoState extends State<RespostaEstado> {
  String res = "...";
  int pontos = 0;
  String num = "X";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(num),
        ElevatedButton(
          onPressed: () {
            // tentar gerar novo texto
            buscaTexto();
          },
          child: const Text('novo!'),
        ),
        Text("sistema: $res"),
        Text("Pontos: $pontos")
      ],
    );
  }

  FutureBuilder geraSaida() {
    return FutureBuilder(
        future: buscaTexto(),
        builder: (context, registro) {
          if (registro.hasData) {
            setState(() {
              num = registro.data.toString();
            });
          } else if (registro.hasError) {
            return const Text('Houve um erro');
          }
          return const CircularProgressIndicator();
        });
  }

  Future<String> buscaTexto() async {
    // receber da Internet
    // https://89251fa1-c1cc-432f-a9c6-f40c20048c08-00-fbjdp3ey1vbj.spock.replit.dev/
    var url = Uri.https(
        '89251fa1-c1cc-432f-a9c6-f40c20048c08-00-fbjdp3ey1vbj.spock.replit.dev');

    var resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      var respostaJSON = jsonDecode(resposta.body);
      print(resposta.body);
      // Gerar agora:
      setState(() {
        num = respostaJSON['dado'];

        switch (respostaJSON['dado']) {
          case "1":
            res = "Passou a vez!";
            break;
          case "2":
            res = "+2!";
            pontos += 2;
            break;
          case "3":
            res = "Passou a vez!";
            break;
          case "4":
            res = "+4!";
            pontos += 4;
            break;
          case "5":
            res = "Passou a vez!";
            break;
          case "6":
            res = "+6!";
            pontos += 6;
            break;
        }
        if (pontos == 10) {
          res = "Você ganhou parabéns!";
          pontos = 0;
          return;
        } else if (pontos > 10) {
          pontos = 0;
          res = "Pedeu por exceder os pontos!";
        }
      });

      return respostaJSON['dado'];
    } else {
      print('Falha com estado: ${resposta.statusCode}.');
      return 'erro';
    }
  }
}
