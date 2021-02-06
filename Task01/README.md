## Описание структуры файлов данных

#### genres.txt
    Поля: 
    	genres: object;
    Структура: линейная
    
### occupation.txt
    Поля:
        occupation: object;
    Структура: линейная
    
### users.txt
    Поля:
        id: int64;
        name: int64;
        email: object;
        gender: object;
        date: object;
        profession: object;
    Структура: табличная
    Разделитель: '|'
    
### ratings_count.txt
    Поля:
        id: int64;
        counts: int64;
    Структура: линейная
    Разделитель: ','
    
### movies.csv
    Поля:
        movieId: int64;
        title: object;
        genres: object;
    Структура: табличная
    Разделитель: ','

### ratings.csv
     Поля:
        userId: int64;
        movieId: int64;
        rating: float64;
        timestamp: int64;  
    Структура: табличная
    Разделитель: ','

### tags.csv
     Поля:
        userId: int64;
        movieId: int64;
        tag: object;
        timestamp: int64;  
    Структура: табличная
    Разделитель: ','
