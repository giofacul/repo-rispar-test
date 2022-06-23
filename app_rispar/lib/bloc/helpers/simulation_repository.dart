
import 'package:dio/dio.dart';

class SimulationRepository{
  Dio? dio;
  final url = 'https://api.rispar.com.br/acquisition/simulation';

  SimulationRepository([Dio? client]){
    if(client == null){
      this.dio = Dio();
    }else {
      this.dio = client;
    }
  }
}