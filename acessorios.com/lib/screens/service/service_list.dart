import 'package:flutter/material.dart';
import 'package:get_profit/components/centered_message.dart';
import 'package:get_profit/components/progress.dart';
import 'package:get_profit/http/webclients/service_webclient.dart';
import 'package:get_profit/models/servico.dart';
import 'package:get_profit/screens/client/client_list.dart';
import 'package:get_profit/screens/client/cliente_screen.dart';
import 'package:get_profit/screens/service/service_screen.dart';
import 'package:get_profit/screens/user/user_list.dart';
import 'package:get_profit/screens/user/user_screen.dart';

class ServiceList extends StatefulWidget {
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  final ServiceOrderWebClient _webClient = ServiceOrderWebClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('SERVIÇOS', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.close),
            onPressed: ()=> Navigator.pop(context),)
        ],
      ),
      drawer: Drawer(
          elevation: 1.5,
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  ListTile(
                    leading:  IconButton(icon: Icon(Icons.person),color: Colors.blueAccent,),
                    title: Text('USUÁRIOS', style: TextStyle(color: Colors.grey, fontSize: 15),),
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserList()),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey ,
                    height: 5,
                  ),
                  ListTile(
                    title: Text('CLIENTES', style: TextStyle(color: Colors.grey, fontSize: 15),),
                    leading: IconButton(icon: Icon(Icons.person),color: Colors.blueAccent,),
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ClientList()),
                      );
                    },
                  ),
                ],
              ),
            ],
          )
      ),

      body: FutureBuilder<List<ServicesOrder>>(
        future: _webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:

              if(snapshot.hasData){
                final List<ServicesOrder> servicos = snapshot.data;
                if (servicos.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final ServicesOrder servico = servicos[index];
                      return Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.only(right: 60,left: 20),
                          trailing: IconButton(icon:Icon(Icons.keyboard_arrow_right), onPressed: (){},),
                          title: Text(servico.id.toString() + " - "+
                            servico.idClienteNavigation.nome.toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text("Data de Entrada: "+ servico.dataEntrada.substring(0,10) + "\n" + "Valor: " +
                              servico.valorOrcado.toString() + "\n" +"${servico.tipo}: " + servico.marca +" - " + servico.modelo
                            ,
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ServiceScreen(servico: servico,),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    itemCount: servicos.length,
                  );
                }
              }
              return CenteredMessage(
                'Nenhum Serviço encontrado!',
                icon: Icons.warning,
              );
              break;
          }

          return CenteredMessage('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ServiceScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

