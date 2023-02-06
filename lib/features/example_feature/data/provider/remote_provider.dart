import '../../../../core/api_client/index.dart';
import '../responses/counter_response.dart';
import 'interface.dart';

class CounterRemoteProvider extends ICounterProvider {
  int _currentNumber = 0;

  @override
  Future<CounterResponse> getCurrentNumber() async {
    //call api here
    //call sample api to check curl log
    final response = await ApiClient.get('https://api.thecatapi.com/v1/images/search');


    if (response != null ) {
      return CounterResponse(statusCode: (response.statusCode ?? 400).statusHttpCode,  data: _currentNumber);
    }

    return CounterResponse(statusCode: 404.statusHttpCode);
  }

  @override
  Future<CounterResponse> decrement({int? number}) async {
    //call api here
    // final response = ApiRequest.call(get...;
    return CounterResponse(statusCode: 200.statusHttpCode, data: --_currentNumber);
  }


  @override
  Future<CounterResponse> increment({int? number}) async {
    //call api here
    // final response = ApiRequest.call(get...;
    return CounterResponse(statusCode: 200.statusHttpCode, data: ++_currentNumber);
  } //Hard Code here
}

