CREATE TABLE IF NOT EXISTS Flowers (
    flowerId   SERIAL PRIMARY KEY,
    flowerName VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Users (
    userId   SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    flowerId INT DEFAULT NULL REFERENCES Flowers (flowerId)
);

CREATE TABLE IF NOT EXISTS Garden (
    userId   INT NOT NULL REFERENCES Users (userId),
    flowerId INT NOT NULL REFERENCES Flowers (flowerId),

    CONSTRAINT pk_garden PRIMARY KEY (userId, flowerId)
);
