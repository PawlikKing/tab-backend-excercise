CREATE TABLE IF NOT EXISTS flowers (
    id   INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    id                    INT PRIMARY KEY,
    name                  VARCHAR(100) NOT NULL,
    favourite_flower_id   INT,
    FOREIGN KEY (favourite_flower_id) REFERENCES flowers(id)
);

CREATE TABLE IF NOT EXISTS user_garden (
    user_id   INT NOT NULL,
    flower_id INT NOT NULL,
    PRIMARY KEY (user_id, flower_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (flower_id) REFERENCES flowers(id)
);

INSERT INTO flowers (id, name) VALUES
(1, 'Róża'),
(2, 'Tulipan'),
(3, 'Stokrotka'),
(4, 'Lilia'),
(5, 'Słonecznik');

INSERT INTO users (id, name, favourite_flower_id) VALUES
(1, 'Kamil', 1),
(2, 'Anna', 2),
(3, 'Piotr', 3),
(4, 'Maria', 4),
(5, 'Jan', 5);
