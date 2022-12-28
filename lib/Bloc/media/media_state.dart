// Dada Ki Jay HO

import 'package:equatable/equatable.dart';
import 'package:video_app/Bloc/data/model/api_result_model.dart';

abstract class MediaState extends Equatable {}

class MediaInitialState extends MediaState {
  @override
  List<Object> get props => [];
}

class MediaLoadingState extends MediaState {
  @override
  List<Object> get props => [];
}

class MediaLoadedState extends MediaState {
  List<Media> media;

  MediaLoadedState({required this.media});

  @override
  List<Object> get props => [media];
}

class MediaErrorState extends MediaState {
  String message;

  MediaErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
