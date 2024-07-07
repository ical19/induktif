part of 'list_bloc.dart';

abstract class TechInfoState {}

class TechInfoUninitialized extends TechInfoState {}

class TechInfoLoaded extends TechInfoState {
  List<TechnicalModel>? technicalModel;
  Widget? pesan;
  Widget? childApp;

  TechInfoLoaded({this.technicalModel, this.pesan, this.childApp});
}
