library movie;

//Data
export 'data/datasources/db/database_helper_movie.dart';
export 'data/datasources/movie_local_data_source.dart';
export 'data/datasources/movie_remote_data_source.dart';
export 'data/models/movie_detail_model.dart';
export 'data/models/movie_model.dart';
export 'data/models/movie_response.dart';
export 'data/models/movie_table.dart';
export 'data/repositories/movie_repository_impl.dart';

//Domain
export 'domain/entities/movie.dart';
export 'domain/entities/movie_detail.dart';
export 'domain/repositories/movie_repository.dart';
export 'domain/usecases/get_movie_detail.dart';
export 'domain/usecases/get_movie_recommendations.dart';
export 'domain/usecases/get_now_playing_movie.dart';
export 'domain/usecases/get_popular_movie.dart';
export 'domain/usecases/get_top_rated_movie.dart';
export 'domain/usecases/get_watchlist_movies.dart';
export 'domain/usecases/get_watchlist_status.dart';
export 'domain/usecases/remove_watchlist.dart';
export 'domain/usecases/save_watchlist.dart';

//Presentation
export 'presentation/bloc/movie_bloc.dart';
export 'presentation/page/home_movie_page.dart';
export 'presentation/page/movie_detail_page.dart';
export 'presentation/page/popular_movies_page.dart';
export 'presentation/page/top_rated_movies_page.dart';
export 'presentation/page/watchlist_movies_page.dart';
