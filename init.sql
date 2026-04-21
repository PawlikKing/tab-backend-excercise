CREATE TABLE IF NOT EXISTS Flowers (
    id   INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    id                    INT PRIMARY KEY,
    name                  VARCHAR(100) NOT NULL,
    favourite_flowerId   INT REFERENCES flowers(id)
);

CREATE TABLE IF NOT EXISTS Garden (
    userId   INT NOT NULL REFERENCES users(id),
    flowerId INT NOT NULL REFERENCES flowers(id),
    PRIMARY KEY (userId, flowerId)
);

INSERT INTO Flowers (id, name) VALUES
(1, 'Róża'),
(2, 'Tulipan'),
(3, 'Stokrotka'),
(4, 'Lilia'),
(5, 'Słonecznik');

INSERT INTO users (id, name, favourite_flowerId) VALUES
(1, 'Kamil', 1),
(2, 'Anna', 2),
(3, 'Piotr', 3),
(4, 'Maria', 4),
(5, 'Jan', 5);