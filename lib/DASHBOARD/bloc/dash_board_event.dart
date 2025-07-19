part of 'dash_board_bloc.dart';

sealed class DashBoardEvent extends Equatable {
  const DashBoardEvent();
}

class LoadChartData extends DashBoardEvent {
  String? site;
  String? individual;
  String? date;

  LoadChartData({this.site, this.individual, this.date});

  @override
  List<Object?> get props => [site, individual, date];
}

class FilterChartData extends DashBoardEvent {
  @override
  List<Object?> get props => [];
}
