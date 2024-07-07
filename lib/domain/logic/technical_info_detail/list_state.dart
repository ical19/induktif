part of 'list_bloc.dart';

abstract class TechInDetState {}

class TechInDetUninitialized extends TechInDetState {}

class TechInDetSecond extends TechInDetState {
  List<TechnicalModelDetail>? technicalModelDetail;
  Widget? pesan;
  TechInDetSecond({this.technicalModelDetail, this.pesan});
}

class TechInDetLoaded extends TechInDetState {
  List<TechnicalModelDetail>? technicalModelDetail;
  TechInDetLoaded({this.technicalModelDetail});
}
