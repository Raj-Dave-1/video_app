// Dada Ki Jay HO

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_app/Bloc/data/model/api_result_model.dart';
import 'package:video_app/Bloc/data/repository/media_repository.dart';

import 'package:video_app/Bloc/media/media_events.dart';
import 'package:video_app/Bloc/media/media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaRepository repository;

  MediaBloc({required this.repository}) : super(MediaInitialState()) {
    on<FetchMediasEvent>((event, emit) async {
      try {
        emit(MediaLoadingState());
        final mList = await repository.getMedias();
        emit(MediaLoadedState(media: mList));
      } on NetworkError {
        emit(MediaErrorState(
            message: "Failed to fetch data. is your device online?"));
      }
    });
  }
}
