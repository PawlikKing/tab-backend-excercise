-- PostgreSQL initialization script
CREATE TABLE IF NOT EXISTS flowers (
    flower_id   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    flower_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    user_id   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    username  VARCHAR(100) NOT NULL UNIQUE,
    flower_id INT DEFAULT NULL REFERENCES flowers (flower_id)
);

CREATE TABLE IF NOT EXISTS garden (
    user_id   INT NOT NULL REFERENCES users (user_id),
    flower_id INT NOT NULL REFERENCES flowers (flower_id),
    CONSTRAINT pk_garden PRIMARY KEY (user_id, flower_id)
);

INSERT INTO flowers (flower_name) VALUES
('Ziemniak'),
('Barszcz Sosnowskiego'),
('Mak'),
('Pomidor'),
('Welwiczja przedziwna');

INSERT INTO users (username, flower_id) VALUES
('Pawelo', 1),
('Ania', 2),
('Jakub', 3);
