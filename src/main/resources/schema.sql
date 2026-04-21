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
