library tveries;

//Data
export 'data/datasources/db/database_helper_tv.dart';
export 'data/datasources/tv_local_data.dart';
export 'data/datasources/tv_remote_data_source.dart';

export 'data/models/detail_tv_model.dart';
export 'data/models/tv_model.dart';
export 'data/models/response_tv.dart';
export 'data/models/tv_table.dart';

export 'data/repositories/tv_repository_impl.dart';

//Domain
export 'domain/entities/tv.dart';
export 'domain/entities/detail_tv.dart';

export 'domain/repositories/tv_repository.dart';

export 'domain/usecases/get_now_playing_tv.dart';
export 'domain/usecases/get_popular_tv.dart';
export 'domain/usecases/get_top_rated_tv.dart';
export 'domain/usecases/get_tv_detail.dart';
export 'domain/usecases/get_tv_recommendation.dart';
export 'domain/usecases/get_watchlist_tv.dart';
export 'domain/usecases/get_watchlist_tv_status.dart';
export 'domain/usecases/remove_watchlist_tv.dart';
export 'domain/usecases/save_watchlist_tv.dart';

//Presentation
export 'presentation/bloc/tv_bloc.dart';

export 'presentation/pages/home_page_tv.dart';
export 'presentation/pages/popular_tv_page.dart';
export 'presentation/pages/top_rated_tv_page.dart';
export 'presentation/pages/tv_detail_page.dart';
export 'presentation/pages/watchlist_tv_page.dart';
