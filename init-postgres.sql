-- PostgreSQL initialization script
CREATE TABLE IF NOT EXISTS Flowers (
    flowerId   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    flowerName VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Users (
    userId   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    username VARCHAR(100) NOT NULL UNIQUE,
    flowerId INT DEFAULT NULL REFERENCES Flowers (flowerId)
);

CREATE TABLE IF NOT EXISTS Garden (
    userId   INT NOT NULL REFERENCES Users (userId),
    flowerId INT NOT NULL REFERENCES Flowers (flowerId),
    CONSTRAINT pk_garden PRIMARY KEY (userId, flowerId)
);

INSERT INTO Flowers (flowerName) VALUES
('Ziemniak'),
('Barszcz Sosnowskiego'),
('Mak'),
('Pomidor'),
('Welwiczja przedziwna');

INSERT INTO Users (username, flowerId) VALUES
('Pawelo', 1),
('Ania', 2),
('Jakub', 3);
