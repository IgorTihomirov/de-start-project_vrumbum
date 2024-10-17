/*сохраните в этом файле запросы для первоначальной загрузки данных - создание схемы raw_data и таблицы sales и наполнение их данными из csv файла*/


CREATE SCHEMA raw_data;

CREATE TABLE raw_data.sales (
    id SERIAL PRIMARY KEY,
    auto VARCHAR(255),
    gasoline_consumption DECIMAL(10, 2) NULL,
    price DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    person_name VARCHAR(255),
    phone VARCHAR(30),
    discount DECIMAL(5, 2),
    brand_origin VARCHAR(255)
);

\copy raw_data.sales (id, auto, gasoline_consumption, price, date, person_name, phone, discount, brand_origin) FROM '/Users/cars.csv' WITH (FORMAT csv, DELIMITER ',', NULL 'null', HEADER true);
