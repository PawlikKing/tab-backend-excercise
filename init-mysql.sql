CREATE TABLE IF NOT EXISTS Flowers (
    id   INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    id                    INT PRIMARY KEY,
    name                  VARCHAR(100) NOT NULL,
    favourite_flowerId   INT,
    FOREIGN KEY (favourite_flowerId) REFERENCES flowers(id)
);

CREATE TABLE IF NOT EXISTS Garden (
    userId   INT NOT NULL,
    flowerId INT NOT NULL,
    PRIMARY KEY (userId, flowerId),
    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (flowerId) REFERENCES flowers(id)
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
