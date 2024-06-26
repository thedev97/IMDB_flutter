import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_flutter/domain/Bloc/base_bloc.dart';
import 'package:imdb_flutter/domain/event/home_event.dart';
import 'package:imdb_flutter/domain/repositories/movie_repository.dart';
import 'package:imdb_flutter/domain/state/home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(this._movieRepository) : super(InitialHomeState()) {
    on<FetchTrendingMoviesHomeEvent>(_handleFetchTrendingMovies);
  }

  final MovieRepository _movieRepository;

  Future<void> _handleFetchTrendingMovies(
      FetchTrendingMoviesHomeEvent event, Emitter<HomeState> emit) async {
    emit(FetchingTrendingMoviesHomeState());
    try {
      final data = await _movieRepository.getTrendingMovieOfThisWeek();
      emit(FetchedTrendingMoviesHomeState(data));
    } on Object catch (_) {
      FetchFailTrendingMoviesHomeState();
    }
  }
}
