/*Добавьте в этот файл все запросы, для создания схемы данных автосалона и
 таблиц в ней в нужном порядке*/

CREATE SCHEMA car_shop;


1. Таблица автомобилей (cars)

CREATE TABLE car_shop.cars (
    car_id SERIAL PRIMARY KEY, /* id — уникальный идентификатор автомобиля, выбираем SERIAL для автоматической генерации значений */
    brand VARCHAR(10) NOT NULL, /* brand — название бренда, может содержать буквы и цифры, поэтому выбираем VARCHAR */
    model VARCHAR(10) NOT NULL, /* model — название модели автомобиля, может содержать символы и пробелы, поэтому выбираем VARCHAR */
    gasoline_consumption DECIMAL(5, 2) DEFAULT NULL, /* gasoline_consumption — потребление бензина в литрах на 100 км, можем попасть в диапазон от 0 до 9.99, поэтому выбираем DECIMAL для точности */
    brand_origin VARCHAR(50) NOT NULL  /* brand_origin — страна происхождения бренда, выбираем VARCHAR, чтобы хранить название страны */
);


2. Таблица цветов (colors)

CREATE TABLE car_shop.colors (
    id SERIAL PRIMARY KEY, /* id — уникальный идентификатор цвета, выбираем SERIAL для автоматической генерации значений */
    color_name VARCHAR(30) NOT NULL UNIQUE /* color_name — название цвета, может содержать буквы и пробелы, выбираем VARCHAR и добавляем уникальность для предотвращения дублирования */
);


3. Промежуточная таблица для связи автомобилей и цветов (car_colors)

CREATE TABLE car_shop.car_colors (
    car_id INT REFERENCES car_shop.cars ON DELETE CASCADE, /* внешний ключ на car_id, если автомобиль удаляется, соответствующие записи удаляются */
	   color_id INT REFERENCES car_shop.colors ON DELETE CASCADE, /* внешний ключ на color_id, если цвет удаляется, соответствующие записи удаляются */ 
    PRIMARY KEY (car_id, color_id) /* составной первичный ключ, который обеспечивает уникальность связки автомобиля и цвета */
);


4. Таблица покупателей (customers)

CREATE TABLE car_shop.customers (
    id SERIAL PRIMARY KEY, /* id — уникальный идентификатор покупателя, выбираем SERIAL для автоматической генерации значений */
    full_name VARCHAR(50) NOT NULL,  /* full_name — полное имя покупателя, выбираем VARCHAR, так как может содержать буквы и пробелы */
    phone VARCHAR(50) NOT NULL /* phone — телефон покупателя, выбираем VARCHAR, так как номер может содержать знаки (+, -, и т.д.) */
);


5. Таблица покупок (purchases)

CREATE TABLE car_shop_purchases (
    id SERIAL PRIMARY KEY,  /* id — уникальный идентификатор покупки, выбираем SERIAL для автоматической генерации значений */
    car_id INT REFERENCES car_shop.cars ON DELETE CASCADE,  /* внешний ключ на car_id, если автомобиль удаляется, соответствующие покупки удаляются */
    customer_id INT REFERENCES car_shop.customers ON DELETE CASCADE,  /* внешний ключ на customer_id, если покупатель удаляется, соответствующие покупки удаляются */
    price DECIMAL(10, 3) NOT NULL,  /* price — цена покупки в долларах, выбираем DECIMAL(10, 3) с тремя знаками после запятой для точного представления денег */
    purchase_date DATE NOT NULL,  /* purchase_date — дата совершения покупки, выбираем DATE, так как требуется хранить только дату без времени */
    discount INT DEFAULT NULL  /* discount — размер скидки, выбираем INT, так как в таблице с сырыми даннами нет скидки в дробном значении */ 
