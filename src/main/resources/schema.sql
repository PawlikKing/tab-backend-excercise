CREATE TABLE IF NOT EXISTS flowers (
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS user_table (
    user_id    INT PRIMARY KEY AUTO_INCREMENT,
    user_name  VARCHAR(100) NOT NULL UNIQUE,
    flower_id  INT,
    FOREIGN KEY (flower_id) REFERENCES flowers(id)
);

CREATE TABLE IF NOT EXISTS user_garden (
    user_id   INT NOT NULL,
    flower_id INT NOT NULL,
    PRIMARY KEY (user_id, flower_id),
    FOREIGN KEY (user_id) REFERENCES user_table(user_id),
    FOREIGN KEY (flower_id) REFERENCES flowers(id)
);
