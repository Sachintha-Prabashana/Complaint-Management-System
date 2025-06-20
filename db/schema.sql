CREATE database cms;
USE cms;

create table users(
    id       varchar(10)                not null
        primary key,
    fullName varchar(100)               not null,
    username varchar(50)                not null,
    password varchar(255)               not null,
    role     enum ('Admin', 'Employee') not null,
    constraint username
        unique (username)
);

create table complaint(
    id          varchar(10)  not null
        primary key,
    title       varchar(255) not null,
    category    varchar(50)  not null,
    description text         not null,
    status      varchar(50)  not null,
    date        date         not null,
    user_id     varchar(10)  null,
    remarks     text         null,
    constraint complaint_ibfk_1
        foreign key (user_id) references users (id)
            on delete cascade
);

create index user_id
    on complaint (user_id);