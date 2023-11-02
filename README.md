# Data-Bases_45-semester

## База данных «БИБЛИОТЕКА»

Необходимо спроектировать базу данных «БИБЛИОТЕКА», информация которой будет использоваться для получения оперативной информации о наличии книг в библиотеке, наличии книг у читателя, для контроля своевременности возврата книг и др. 

В БД должна храниться информация: 

* об издательствах: код издательства, наименование издательства, город; 
* о книгах: шифр книги, название книги, первый автор, год издания, цена книги (руб.), количество экземпляров (шт.);
* о читателях: код читателя, Ф.И.О. читателя, адрес, телефон;
* о выдачах: код читателя, шифр книги, дата выдачи, дата возврата.

При проектировании БД необходимо учитывать следующее: 

* в библиотеке могут храниться несколько книг одного и того же издательства
* книга издается только одним издательством
* книга может быть затребована несколько раз на выдачу
* каждая выдача относится к одной книге
* читателю разрешена выдача нескольких книг 

Задания:

0. Выбираем предметную область. Пересечения по предметным областям в подгруппе недопустимы. 
1. Создаем ER-диаграмму (предлагаю использовать https://www.dbdesigner.net/, при создании выбрать базу данных PostgreSQL)
2. Экспортировать схему в файл (Create).
3. Изменить скрипт:
   - Удалить двойные кавычки в названиях таблиц, колонок
   - Избавиться от указания схемы данных public в названии таблиц
   - Дать осознанное название внешним ключам (_fk0, _fk1 неприемлемо)
   - Прописать действия во внешних ключах ON UPDATE, ON DELETE (исходя их условий задачи)
   
5. Добавить комментарии для таблиц, колонок
6. Добавить ограничения (NOT NULL, UNIQUE, CHECK) там, где это необходимо
7. В начале скрипта добавить команды по удалению всех таблиц в скрипке с директивой IF EXISTS в требуемом порядке.
8. Добавить команды по добавлению записей в каждую таблицу (по 5-10 записей)
   В начале скрипта добавляем создание своей схемы данных (если она отсутствует). 
   - Командой CREATE SCHEMA создаем новую схему данных (ex.: CREATE SCHEMA IF NOT EXISTS your_schema_name AUTHORIZATION your_login;).
   - Делаем комментарий для своей созданной схемы (ex.: COMMENT ON SCHEMA your_schema_name IS 'your_schema_comment';).
   - Прописываем для себя в своей бд параметр searсh_path (ex.: ALTER ROLE you_login IN DATABASE your_db SET search_path TO you_schema_name, public;).
   - Для того, чтобы search_path применился - необходимо выполнить переподключение к своей БД. Чтобы этого избежать установим этот параметр для текущей сессии командой SET (ex. SET search_path TO you_schema_name, public;)

9. На текущем этапе за один проход имеющегося скрипта:
   - Он должнен выполняться без ошибок
   - По порядку выполнения скрипт должен:
      - Создать схему данных (если она отсутствует) + коммент + search_path
      - Выполнить команду set search_path
      - Выполнить удаление всех таблиц (если они существуют)
      - Выполнить создание таблиц, ограничений
      - Наполнить таблиц данными
[Выполняем свой скрипт в своей БД]
10. 
