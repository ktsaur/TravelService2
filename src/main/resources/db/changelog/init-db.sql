CREATE TABLE users
(
    user_id  SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email    VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE travel
(
    travel_id      SERIAL PRIMARY KEY,
    user_id        INT          NOT NULL,
    name_travel    VARCHAR(200) NOT NULL,
    description    TEXT,
    start_date     DATE,
    end_date       DATE,
    transport      VARCHAR(100),
    list_of_things TEXT,
    notes          TEXT,
    CONSTRAINT fk_user_travel FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

CREATE TABLE article
(
    article_id   SERIAL PRIMARY KEY,
    title        VARCHAR(255) NOT NULL,
    content      TEXT         NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE favourites
(
    user_id    INT NOT NULL,
    article_id INT NOT NULL,
    PRIMARY KEY (user_id, article_id),
    CONSTRAINT fk_user_favourites FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
    CONSTRAINT fk_article_favourites FOREIGN KEY (article_id) REFERENCES article (article_id) ON DELETE CASCADE
);
