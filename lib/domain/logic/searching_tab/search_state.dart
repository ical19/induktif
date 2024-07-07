part of 'search_bloc.dart';

abstract class SearchState {}

class SearchStarting extends SearchState {}

class SearchLoaded extends SearchState {
  List<SearchingModel>? searchingModel;
  Widget? pesan;

  SearchLoaded({this.searchingModel, this.pesan});
}
