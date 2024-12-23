# Skill Pinpoint App

- [Skill Pinpoint App](#skill-pinpoint-app)
  - [Tasks](#tasks)
    - [Completed tasks](#completed-tasks)
  - [Stack and Gems](#stack-and-gems)
  - [Solution: Comments and observations](#solution-comments-and-observations)
    - [Running app](#running-app)
    - [Injecting CSV data](#injecting-csv-data)
    - [About tests and coverage](#about-tests-and-coverage)
    - [Testing API](#testing-api)

---

## Tasks

### Completed tasks

- [Task 1: Create a Basic Database](#task-1-create-a-basic-database)
- [Task 3: Create a Test Suite](#task-3-create-a-test-suite)
- [Task 4: Create a Docker Compose Setup](#task-4-create-a-docker-compose-setup)
- [Task 9: Build a Simple API](#task-9-build-a-simple-api)
- [Task 12: Creative Exploration](#task-12-creative-exploration)

---

## Stack and Gems

- Ruby 3.3.0
- Rails 7.1.4
- Postgresql 16
- Dotenv
- Rspec + FactoryBot + Faker + Capybara + Selenium
- Devise + Devise JWT
- Bootstrap
- Docker
- GitHub actions for Linter and CI
- Rubocop and Brakeman
- active_model_serializers
- mini_racer
- SimpleCov

## Solution: Comments and observations

### Running app

To start the application run:

```rb
docker-compose -f docker-compose.dev.yml up --build
```

> The application on development will run on `http://localhost:3000`

### Injecting CSV data

I have created a Lib `SurveyCSVProcessor::Mapper` to map and inject the data from the csv file, maybe I could have done
it all as seed, or using tasks, but creating a lib made my life just easier, it's a very simple lib .

In Flexcode, when I did data migration I used lots of CSVs to map, validate, and extract data, but I used rake tasks,
and it gave hard times, specially to keep code clear, clean and modular, so I choose to go in another direction this
time.

I kept the `data.csv` file within the libs folder, but in real world I would keep it on `tmp` to avoid versioning it.

**Injecting data with seeds:**

```sh
docker exec -it skill-pinpoint-app_c bin/rails db:prepare

# OR Locally

bin/rails db:prepare
```

**Injecting directly on console:**

```rb
SurveyCSVProcessor.new('data').inject! 
```

### About tests and coverage

I have implemented the gem SimpleCov to generate a bit of coverage, to check it just need to run tests

```sh
bundle exec rspec .
```

> But I got a bit frustrated trying to configure it because it keeps counting tests for files that I didn't touch,
> or that doesn't even have content

### Testing API

To test my API I used POSTMAN, on the Docs folder I let the collection export json
`docs/skill-pinpoint-app.postman_collection.json`.

There you will also find endpoint explanations: [`API documentation`](/docs/docs.md#api)

---

## Tasks Overview

### Task 1: Create a Basic Database

**Objective**: Design and implement a database to structure the data from the CSV file.

**Requirements**:

- Choose an appropriate database system (relational or non-relational) such as MySQL, PostgresSQL, MongoDB, etc.
- Design a schema or data model that accurately represents the data, considering the Portuguese field names.
- Write scripts or use tools to import the CSV data into the database.
- Ensure data integrity and appropriate data types for each field.
- Provide database creation scripts or configurations and instructions on how to set it up.

**Bonus**:

- Implement indexing or other optimizations for faster query performance.
- Organize the data efficiently to reduce redundancy and improve access speed.

---

### Task 3: Create a Test Suite

**Objective**: Write tests to ensure the reliability and correctness of your codebase.

**Requirements**:

- Use a testing framework relevant to your chosen language (e.g., pytest for Python, JUnit for Java, Jest for
  JavaScript).
- Write unit tests for key functions or components.
- Include tests for edge cases and error handling.
- Provide instructions on how to run the tests.

**Bonus**:

- Achieve high code coverage.
- Implement integration tests to test interactions between components.

---

### Task 4: Create a Docker Compose Setup

**Objective**: Containerize your application and its services using Docker Compose.

**Requirements**:

- Write a `Dockerfile` for your application.
- Create a `docker-compose.yml` file to define services (e.g., application server, database).
- Ensure that running `docker-compose up` sets up the entire environment.
- Provide instructions on how to build and run the containers.

**Bonus**:

- Use environment variables for configuration.
- Implement multi-stage builds to optimize image size.

---

### Task 9: Build a Simple API

**Objective**: Develop an API to serve data from the dataset.

**Requirements**:

- Implement at least one endpoint that returns data in JSON format.
- Use any framework or language you're comfortable with.
- Include instructions on how to run and test the API.

**Bonus**:

- Implement multiple endpoints for different data queries.
- Include pagination or filtering options.

---

### Task 12: Creative Exploration

**Objective**: Explore the dataset in a way that interests you.

**Requirements**:

- Pose a question or hypothesis related to the data.
- Use the data to answer the question or test the hypothesis.
- Document your process, findings, and any conclusions drawn.

---
