part of 'dash_board_bloc.dart';

sealed class DashBoardState extends Equatable {
  const DashBoardState();
}

final class DashBoardInitial extends DashBoardState {
  @override
  List<Object> get props => [];
}

class DashBoardLoadingState extends DashBoardState {
  @override
  List<Object?> get props => [];
}

class DashBoardLoadedState extends DashBoardState {
  List<DashBoardModel> dashBoardModel;
  List<DashBoardModel> filterData;

  DashBoardLoadedState({required this.dashBoardModel,required this.filterData});

  @override
  List<Object?> get props => [dashBoardModel];
}



class FilterLoadedState extends DashBoardState {
  List<DashBoardModel> dashBoardModel;

  FilterLoadedState({required this.dashBoardModel});

  @override
  List<Object?> get props => [dashBoardModel];
}

class DashBoardErrorState extends DashBoardState {
  String? erMsg;

  DashBoardErrorState({this.erMsg});

  @override
  List<Object?> get props => [erMsg];
}
