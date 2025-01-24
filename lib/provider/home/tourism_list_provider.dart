import 'package:flutter/widgets.dart';
import 'package:tourism_app/data/api/api_sevice.dart';
import 'package:tourism_app/static/tourism_list_result_state.dart';

class TourismListProvider extends ChangeNotifier {
  final ApiService _apiService;
  TourismListProvider(
    this._apiService,
  );

  TourismListResultState _resultState = TourismListNoneState();

  TourismListResultState get resulstState => _resultState;

  Future<void> fetchTourismList()async{
    try {
      _resultState = TourismListLoadingState();
      notifyListeners();

      final result = await _apiService.getTourismList();

      if (result.error) {
        _resultState = TourismListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = TourismListLoadedState(result.places);
        notifyListeners();
      }
    }on Exception catch (e) {
      _resultState = TourismListErrorState(e.toString());
      notifyListeners();
    }
  }
}
