CREATE TABLE department (
    dept_name VARCHAR2(20) NOT NULL,
    building VARCHAR2(15),
    budget NUMBER(12,2),
    PRIMARY KEY (dept_name)
);

CREATE TABLE instructor (
    ID VARCHAR2(5) NOT NULL,
    name VARCHAR2(20) NOT NULL,
    dept_name VARCHAR2(20),
    salary NUMBER(8,2),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name)
        REFERENCES department(dept_name)
        ON DELETE SET NULL
);

CREATE TABLE course (
    course_id VARCHAR2(8) NOT NULL,
    title VARCHAR2(50),
    dept_name VARCHAR2(20),
    credits NUMBER(2,0),
    PRIMARY KEY (course_id),
    FOREIGN KEY (dept_name)
        REFERENCES department(dept_name)
        ON DELETE SET NULL
);

CREATE TABLE classroom (
    building VARCHAR2(15) NOT NULL,
    room_number VARCHAR2(7) NOT NULL,
    capacity NUMBER(4,0),
    PRIMARY KEY (building, room_number)
);

CREATE TABLE student (
    ID VARCHAR2(5) NOT NULL,
    name VARCHAR2(20) NOT NULL,
    dept_name VARCHAR2(20),
    tot_cred NUMBER(3,0),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name)
        REFERENCES department(dept_name)
        ON DELETE SET NULL
);

CREATE TABLE time_slot (
    time_slot_id VARCHAR2(4) NOT NULL,
    day VARCHAR2(1) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    PRIMARY KEY (time_slot_id, day, start_time)
);

CREATE TABLE section (
    course_id VARCHAR2(8) NOT NULL,
    sec_id VARCHAR2(8) NOT NULL,
    semester VARCHAR2(6) NOT NULL,
    year NUMBER(4,0) NOT NULL,
    building VARCHAR2(15),
    room_number VARCHAR2(7),
    time_slot_id VARCHAR2(4),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id)
        REFERENCES course(course_id)
        ON DELETE CASCADE,
    FOREIGN KEY (building, room_number)
        REFERENCES classroom(building, room_number)
        ON DELETE SET NULL
);

CREATE TABLE takes (
    ID VARCHAR2(5) NOT NULL,
    course_id VARCHAR2(8) NOT NULL,
    sec_id VARCHAR2(8) NOT NULL,
    semester VARCHAR2(6) NOT NULL,
    year NUMBER(4,0) NOT NULL,
    grade VARCHAR2(2),

    PRIMARY KEY (ID, course_id, sec_id, semester, year),

    FOREIGN KEY (course_id, sec_id, semester, year)
        REFERENCES section(course_id, sec_id, semester, year)
        ON DELETE CASCADE,

    FOREIGN KEY (ID)
        REFERENCES student(ID)
        ON DELETE CASCADE
);

CREATE TABLE teaches (
    ID VARCHAR2(5) NOT NULL,
    course_id VARCHAR2(8) NOT NULL,
    sec_id VARCHAR2(8) NOT NULL,
    semester VARCHAR2(6) NOT NULL,
    year NUMBER(4,0) NOT NULL,
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (course_id, sec_id, semester, year)
        REFERENCES section(course_id, sec_id, semester, year)
        ON DELETE CASCADE,
    FOREIGN KEY (ID)
        REFERENCES instructor(ID)
        ON DELETE CASCADE
);

CREATE TABLE prereq (
    course_id VARCHAR2(8) NOT NULL,
    prereq_id VARCHAR2(8) NOT NULL,
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id)
        REFERENCES course(course_id)
        ON DELETE CASCADE,
    FOREIGN KEY (prereq_id)
        REFERENCES course(course_id)
);

CREATE TABLE advisor (
    s_ID VARCHAR2(5) NOT NULL,
    i_ID VARCHAR2(5),
    PRIMARY KEY (s_ID),
    FOREIGN KEY (i_ID)
        REFERENCES instructor(ID)
        ON DELETE SET NULL,
    FOREIGN KEY (s_ID)
        REFERENCES student(ID)
        ON DELETE CASCADE
);

SELECT table_name
FROM user_tables
WHERE table_name IN (
    'DEPARTMENT',
    'INSTRUCTOR',
    'COURSE',
    'CLASSROOM',
    'STUDENT',
    'TIME_SLOT',
    'SECTION',
    'TAKES',
    'TEACHES',
    'PREREQ',
    'ADVISOR'
)
ORDER BY table_name;
