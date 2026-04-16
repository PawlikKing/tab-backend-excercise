CREATE TABLE IF NOT EXISTS flowers (
    id   INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    id        INT PRIMARY KEY,
    name      VARCHAR(100) NOT NULL,
    flower_id INT,
    FOREIGN KEY (flower_id) REFERENCES flowers(id)
);
