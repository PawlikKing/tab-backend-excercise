CREATE TABLE IF NOT EXISTS Users (
    "userId"   INT          NOT NULL AUTO_INCREMENT,
    "username" VARCHAR(100) NOT NULL,
    "flowerId" INT          DEFAULT NULL,

    CONSTRAINT pk_users        PRIMARY KEY (userId),
    CONSTRAINT uq_users_name   UNIQUE      (username),
    CONSTRAINT fk_users_flower FOREIGN KEY (flowerId) REFERENCES Flowers (id)
);

CREATE TABLE IF NOT EXISTS Flowers (
    "id"   INT          NOT NULL AUTO_INCREMENT,
    "name" VARCHAR(100) NOT NULL,

    CONSTRAINT pk_flowers PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Garden (
    "userId"   INT NOT NULL,
    "flowerId" INT NOT NULL,

    CONSTRAINT pk_garden        PRIMARY KEY (userId, flowerId),
    CONSTRAINT fk_garden_user   FOREIGN KEY (userId)   REFERENCES Users   (userId),
    CONSTRAINT fk_garden_flower FOREIGN KEY (flowerId) REFERENCES Flowers (id)
);

INSERT INTO Flowers ("id", "name") VALUES
(1, 'Ziemniak'),
(2, 'Barszcz Sosnowskiego'),
(3, 'Mak'),
(4, 'Pomidor'),

INSERT INTO Users ("userId", "username", "flowerId") VALUES
(1, 'Pawelo', 1),
(2, 'Ania', 2),
(3, 'Jakub', 3),