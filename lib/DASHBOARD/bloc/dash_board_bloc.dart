import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_dashboard/DASHBOARD/repo/dash_board_repository.dart';

import '../model/dash_board_model.dart';

part 'dash_board_event.dart';
part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  DashBoardRepository dashBoardRepository;

  DashBoardBloc({required this.dashBoardRepository})
    : super(DashBoardInitial()) {
    on(onLoadFilter);
    on(onLoadChart);
  }

  onLoadFilter(FilterChartData event, Emitter<DashBoardState> emit) async {
    try {
      emit(DashBoardLoadingState());
      List<DashBoardModel> data = await dashBoardRepository.fetchData();
      emit(FilterLoadedState(dashBoardModel: data));
    } catch (e) {
      emit(DashBoardErrorState(erMsg: e.toString()));
    }
  }

  onLoadChart(LoadChartData event, Emitter<DashBoardState> emit) async {
    print("shiva");
    print("shiva ${event.site}");
    print("shiva ${event.individual}" );
    print("shiva ${event.date}");
    try {
      emit(DashBoardLoadingState());

      List<DashBoardModel> data = await dashBoardRepository.fetchData(
        date: event.date,site: event.site,individual: event.individual
      );
      print("data length => ${data.length}");

      List<DashBoardModel> filterData = await dashBoardRepository.fetchData();


      emit(DashBoardLoadedState(dashBoardModel: data,filterData: filterData
      ));

    } catch (e) {
      emit(DashBoardErrorState(erMsg: e.toString()));
    }
  }
}
