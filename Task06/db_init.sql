pragma foreign_keys = on;

DROP TABLE IF EXISTS services_by_car_class;
DROP TABLE IF EXISTS completed_services;
DROP TABLE IF EXISTS person_schedules;
DROP TABLE IF EXISTS service_reservation;
DROP TABLE IF EXISTS masters;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS car_class;
DROP TABLE IF EXISTS boxes;


create table  services
(
    id integer primary key,
    name varchar(32)
);

create table  car_class
(
    id integer primary key,
    name varchar(32)
);

create table  services_by_car_class
(
    service_id integer,
    car_class_id integer,
    duration integer,
    price real,
    foreign key (service_id) references services(id),
    foreign key (car_class_id) references car_class(id),
    check (duration > 0 and price > 0)
);

create table  masters
(
    id integer primary key,
    first_name varchar(32),
    patronymic varchar(32),
    last_name varchar(32),
    gender varchar(8),
    salary_coefficient real default 1.0,
    birthdate date,
    hiring_date date,
    dismissal_date date,
    check (gender = 'муж' or gender = 'жен'),
    check (salary_coefficient > 0.0 and salary_coefficient <= 1.0),
    check (birthdate < date()),
    check (dismissal_date > hiring_date)
);

create table  boxes
(
    id integer primary key,
    number integer
);

create table  service_reservation
(
    service_id integer,
    car_class_id integer,
    master_id integer,
    box_id integer,
    date date,
    time time,
    foreign key (service_id) references services(id),
    foreign key (car_class_id) references car_class(id),
    foreign key (master_id) references masters(id),
    foreign key (box_id) references boxes(id),
    check (date > date())
);

create table  completed_services
(
    service_id integer,
    car_class_id integer,
    master_id integer,
    date date,
    foreign key (service_id) references services(id),
    foreign key (car_class_id) references car_class(id),
    foreign key (master_id) references masters(id),
    check (date <= date())
);

create table  person_schedules (
    master_id integer,
    mon_start time NULL default '9:00',
    mon_end time NULL default '17:00',
    tue_start time NULL default '9:00',
    tue_end time NULL default '17:00',
    wed_start time NULL default '9:00',
    wed_end time NULL default '17:00',
    thu_start time NULL default '9:00',
    thu_end time NULL default '17:00',
    fri_start time NULL default '9:00',
    fri_end time NULL default '17:00',
    sat_start time NULL default '9:00',
    sat_end time NULL default '17:00',
    sun_start time NULL default '9:00',
    sun_end time NULL default '17:00',
    foreign key (master_id) references masters(id)
);




insert into services (name)
values
('Ручная мойка кузова'),
('Бесконтактная мойка кузова'),
('Чистка салона пылесосом и влажная уборка пластмассовых деталей'),
('Чистка багажника'),
('Комплексная мойка'),
('Мойка двигателя и моторного отсека'),
('Покрытие кузова воском на основе тефлоновой полировки'),
('Кондиционер кожанных сидений'),
('Химчистка салона'),
('Восстановительная полировка кузова');

insert into car_class (name)
values
('A-класс'),
('B-класс'),
('C-класс'),
('D-класс'),
('E-класс'),
('F-класс');

insert into services_by_car_class (service_id, car_class_id, duration, price)
values
(1, 1, 20, 100.00),
(2, 1, 25, 120.00),
(3, 1, 10, 110.00),
(4, 1, 20, 150.00),
(5, 1, 30, 180.00),
(6, 1, 60, 140.00),
(7, 1, 40, 250.00),
(8, 1, 30, 200.00),
(9, 1, 25, 190.00),
(10, 1, 20, 120.00),
(1, 2, 20, 110.00),
(2, 2, 25, 130.00),
(3, 2,  10, 120.00),
(4, 2, 20, 160.00),
(5, 2, 30, 190.00),
(6, 2, 60, 150.00),
(7, 2, 40, 260.00),
(8, 2, 30, 210.00),
(9, 2, 25, 200.00),
(10, 2, 20, 130.00),
(1, 2, 20, 100.00),
(2, 3, 20, 120.00),
(3, 3, 10, 110.00),
(4, 3, 20, 150.00),
(5, 3, 30, 180.00),
(6, 3, 60, 140.00),
(7, 3, 40, 250.00),
(8, 3, 30, 200.00),
(9, 3, 25, 190.00),
(10, 3, 20, 120.00),
(1, 4, 40, 140.00),
(2, 4, 45, 160.00),
(3, 4, 30, 170.00),
(4, 4, 40, 210.00),
(5, 4, 50, 240.00),
(6, 4, 80, 200.00),
(7, 4, 60, 310.00),
(8, 4, 50, 240.00),
(9, 4, 45, 230.00),
(10, 4, 40, 160.00),
(1, 5, 40, 140.00),
(2, 5, 45, 160.00),
(3, 5, 30, 170.00),
(4, 5, 40, 210.00),
(5, 5, 50, 240.00),
(6, 5, 80, 200.00),
(7, 5, 60, 310.00),
(8, 5, 50, 240.00),
(9, 5, 45, 230.00),
(10, 5, 40, 160.00),
(1, 6, 40, 240.00),
(2, 6, 45, 260.00),
(3, 6, 30, 270.00),
(4, 6, 40, 310.00),
(5, 6, 50, 340.00),
(6, 6, 80, 300.00),
(7, 6, 60, 410.00),
(8, 6, 50, 340.00),
(9, 6, 45, 330.00),
(10, 6, 40, 260.00);

insert into masters (first_name, patronymic, last_name, gender, birthdate, salary_coefficient, hiring_date, dismissal_date)
values
('Петр', 'Петрович', 'Петров', 'муж', '2000-01-02', 0.7, '2020-02-01', NULL),
('Иван', 'Иванович', 'Иванов', 'муж', '2000-03-04', 0.5, '2020-01-02', NULL),
('Сидор', 'Сидорович', 'Сидоров', 'муж', '2000-05-06', 1.0, '2020-04-03', NULL),
('Николай', 'Николаевич', 'Николаев', 'муж', '2000-07-08', 0.6, '2020-03-04', NULL),
('Александр', 'Александрович', 'Александров', 'муж', '2000-09-10', 0.8, '2020-05-05', NULL),
('Костин','Даниил','Германович','муж', '2000-02-10', 0.7, '2020-05-05', NULL),
('Волков','Максим','Львович','муж', '2000-09-01', 0.9, '2020-05-05', NULL),
('Морозов', 'Роман', 'Даниилович','муж', '2001-09-10', 1.0, '2020-05-05', NULL),
('Белова', 'Анастасия', 'Демидовна','жен', '2000-09-14', 0.6, '2020-05-05', NULL);

insert into boxes(number)
values
(1),
(2),
(3),
(4),
(5);

insert into service_reservation (service_id, car_class_id, master_id, box_id, date, time)
values
(1, 1, 1, 1, '2021-06-01', '10:00'),
(2, 1, 2, 2, '2021-06-01', '10:00'),
(1, 3, 3, 3, '2021-06-01', '10:00'),
(4, 1, 4, 4, '2021-06-01', '10:00'),
(2, 3, 5, 5, '2021-06-01', '10:00'),
(1, 1, 1, 1, '2021-06-02', '10:00'),
(2, 1, 2, 2, '2021-06-02', '10:00'),
(1, 3, 3, 3, '2021-06-03', '10:00'),
(4, 1, 4, 4, '2021-06-04', '10:00'),
(2, 3, 5, 5, '2021-06-03', '10:00');

insert into completed_services (service_id, car_class_id, master_id, date)
values
(1, 1, 1, '2021-02-06'),
(1, 2, 1, '2021-02-06'),
(1, 3, 2, '2021-02-06'),
(1, 4, 2, '2021-02-06'),
(1, 5, 3, '2021-02-06'),
(1, 2, 3, '2021-02-06'),
(1, 1, 4, '2021-02-06'),
(1, 4, 4, '2021-02-06'),
(1, 2, 5, '2021-02-06'),
(2, 5, 5, '2021-02-06'),
(3, 2, 6, '2021-02-06'),
(4, 4, 1, '2021-03-06'),
(5, 1, 9, '2021-02-06'),
(6, 5, 2, '2021-02-06'),
(2, 2, 3, '2021-02-06'),
(8, 1, 3, '2021-02-06'),
(1, 3, 4, '2021-02-06'),
(3, 2, 4, '2021-02-06'),
(1, 4, 5, '2021-02-06'),
(6, 2, 5, '2021-02-06');

insert into person_schedules (master_id, mon_start,mon_end,tue_start,tue_end,wed_start,wed_end,thu_start,thu_end,fri_start,fri_end,sat_start,sat_end,sun_start,sun_end)
values
(1,'NULL','NULL','9:00','16:00','14:00','16:00','9:00','16:00','9:00','16:00','14:00','16:00','14:00','16:00'),
(2,'15:00','22:00','15:00','22:00','15:00','22:00','15:00','22:00','15:00','22:00','NULL','NULL','NULL','NULL'),
(3,'16:00','22:00','9:00','16:00','16:00','22:00','9:00','16:00','16:00','22:00','NULL','NULL','NULL','NULL'),
(4,'12:00','21:00','NULL','NULL','12:00','21:00','NULL','NULL','12:00','21:00','NULL','NULL','NULL','NULL'),
(5,'NULL','NULL','13:00','21:00','NULL','NULL','NULL','NULL','13:00','21:00','NULL','NULL','13:00','21:00'),
(6,'8:00','12:00','8:00','12:00','8:00','12:00','8:00','12:00','8:00','12:00','NULL','NULL','NULL','NULL'),
(7,'8:00','17:00','8:00','17:00','8:00','17:00','8:00','17:00','8:00','17:00','NULL','NULL','NULL','NULL'),
(8,'16:00','22:00','16:00','22:00','16:00','22:00','16:00','22:00','16:00','22:00','NULL','NULL','NULL','NULL'),
(9,'NULL','NULL','13:00','21:00','NULL','NULL','NULL','NULL','13:00','21:00','NULL','NULL','13:00','21:00');
