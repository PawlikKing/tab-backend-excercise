CREATE TABLE IF NOT EXISTS Flowers (
    flowerId   INT          NOT NULL AUTO_INCREMENT,
    flowerName VARCHAR(100) NOT NULL,

    CONSTRAINT pk_flowers PRIMARY KEY (flowerId)
);

CREATE TABLE IF NOT EXISTS Users (
    userId   INT          NOT NULL AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    flowerId INT          DEFAULT NULL,

    CONSTRAINT pk_users        PRIMARY KEY (userId),
    CONSTRAINT uq_users_name   UNIQUE (username),
    CONSTRAINT fk_users_flower FOREIGN KEY (flowerId) REFERENCES Flowers (flowerId)
);

/*CREATE TABLE IF NOT EXISTS Garden (
    userId   INT NOT NULL,
    flowerId INT NOT NULL,

    CONSTRAINT pk_garden        PRIMARY KEY (userId, flowerId),
    CONSTRAINT fk_garden_user   FOREIGN KEY (userId)   REFERENCES Users (userId),
    CONSTRAINT fk_garden_flower FOREIGN KEY (flowerId) REFERENCES Flowers (flowerId)
);*/