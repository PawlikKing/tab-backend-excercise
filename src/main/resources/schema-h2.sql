CREATE TABLE IF NOT EXISTS flowers (
    flower_id   INT          NOT NULL AUTO_INCREMENT,
    flower_name VARCHAR(100) NOT NULL,

    CONSTRAINT pk_flowers PRIMARY KEY (flower_id)
);

CREATE TABLE IF NOT EXISTS users (
    user_id     INT          NOT NULL AUTO_INCREMENT,
    username    VARCHAR(100) NOT NULL,
    flower_id   INT          DEFAULT NULL,

    CONSTRAINT pk_users        PRIMARY KEY (user_id),
    CONSTRAINT uq_users_name   UNIQUE (username),
    CONSTRAINT fk_users_flower FOREIGN KEY (flower_id) REFERENCES flowers (flower_id)
);

CREATE TABLE IF NOT EXISTS garden (
    user_id   INT NOT NULL,
    flower_id INT NOT NULL,

    CONSTRAINT pk_garden        PRIMARY KEY (user_id, flower_id),
    CONSTRAINT fk_garden_user   FOREIGN KEY (user_id)   REFERENCES users (user_id),
    CONSTRAINT fk_garden_flower FOREIGN KEY (flower_id) REFERENCES flowers (flower_id)
);
