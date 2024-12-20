# Skill Pinpoint App

- [Skill Pinpoint App](#skill-pinpoint-app)
  - [Tasks](#tasks)
    - [Completion tracking](#completion-tracking)
    - [Stack](#stack)
    - [Getting Started](#getting-started)
      - [Running app](#running-app)
      - [Loading csv data](#loading-csv-data)
      - [About tests and coverage](#about-tests-and-coverage)

---

## Tasks

### Completion tracking

- [X] [Task 1: Create a Basic Database](#task-1-create-a-basic-database)
- [ ] [Task 2: Create a Basic Dashboard](#task-2-create-a-basic-dashboard)
- [x] [Task 3: Create a Test Suite](#task-3-create-a-test-suite)
- [X] [Task 4: Create a Docker Compose Setup](#task-4-create-a-docker-compose-setup)
- [ ] [Task 5: Exploratory Data Analysis](#task-5-exploratory-data-analysis)
- [ ] [Task 6: Data Visualization - Company Level](#task-6-data-visualization---company-level)
- [ ] [Task 7: Data Visualization - Area Level](#task-7-data-visualization---area-level)
- [ ] [Task 8: Data Visualization - Employee Level](#task-8-data-visualization---employee-level)
- [ ] [Task 9: Build a Simple API](#task-9-build-a-simple-api)
- [ ] [Task 10: Sentiment Analysis](#task-10-sentiment-analysis)
- [ ] [Task 11: Report Generation](#task-11-report-generation)
- [x] [Task 12: Creative Exploration](#task-12-creative-exploration)

---

### Tasks Overview

#### Task 1: Create a Basic Database

**Objective**: Design and implement a database to structure the data from the CSV file.

**Requirements**:

- Choose an appropriate database system (relational or non-relational) such as MySQL, PostgreSQL, MongoDB, etc.
- Design a schema or data model that accurately represents the data, considering the Portuguese field names.
- Write scripts or use tools to import the CSV data into the database.
- Ensure data integrity and appropriate data types for each field.
- Provide database creation scripts or configurations and instructions on how to set it up.

**Bonus**:

- Implement indexing or other optimizations for faster query performance.
- Organize the data efficiently to reduce redundancy and improve access speed.

---

#### Task 2: Create a Basic Dashboard

**Objective**: Develop a simple dashboard to display important data insights.

**Requirements**:

- Use any frontend technology (e.g., HTML/CSS, JavaScript, React, Angular, Vue.js).
- Connect the dashboard to your database or use the CSV file directly.
- Display key metrics such as:

  - Number of employees per department (**area**).
  - Average feedback scores.
  - eNPS distribution.

- Include interactive elements like filtering by department (**area**) or position (**cargo**).
- Ensure the dashboard is user-friendly and visually appealing.

**Bonus**:

- Implement responsive design for mobile compatibility.
- Add advanced visualizations using charting libraries (e.g., D3.js, Chart.js).

---

#### Task 3: Create a Test Suite

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

#### Task 4: Create a Docker Compose Setup

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

#### Task 5: Exploratory Data Analysis

**Objective**: Analyze the dataset to extract meaningful insights.

**Requirements**:

- Compute summary statistics (mean, median, mode, etc.) for numerical fields.
- Identify trends or patterns (e.g., average feedback scores by department (**area**)).
- Visualize key findings using charts or graphs.
- Provide a brief report summarizing your insights.

---

#### Task 6: Data Visualization - Company Level

**Objective**: Create visualizations that provide insights at the company-wide level.

**Requirements**:

- Develop at least two visualizations that represent data across the entire company.
- Examples include:

  - Overall employee satisfaction scores.
  - Company-wide eNPS scores.
  - Distribution of company tenure among all employees.

- Ensure visualizations are clear, labeled, and easy to understand.
- Explain what each visualization reveals about the company.

**Bonus**:

- Use interactive dashboards or advanced visualization techniques.
- Incorporate time-series analysis if temporal data is available.

---

#### Task 7: Data Visualization - Area Level

**Objective**: Create visualizations focusing on specific areas or departments within the company.

**Requirements**:

- Develop at least two visualizations that provide insights at the area or department level.
- Examples include:

  - Average feedback scores by department (**area**).
  - eNPS scores segmented by department.
  - Comparison of career expectations across different areas.

- Include interactive elements such as filtering or hovering to display more information.
- Ensure visualizations are clear, labeled, and easy to understand.
- Explain what each visualization reveals about the different areas.

**Bonus**:

- Highlight significant differences or trends between departments.
- Suggest possible reasons for observed patterns based on the data.

---

#### Task 8: Data Visualization - Employee Level

**Objective**: Create visualizations that focus on individual employee data.

**Requirements**:

- Develop visualizations that provide insights at the employee level.
- Examples include:

  - An individual employee's feedback scores across different categories.
  - A profile visualization summarizing an employee's tenure, position, and feedback.
  - Comparison of an employee's scores to department or company averages.

- Ensure privacy considerations are met (e.g., anonymize data if necessary).
- Explain how these visualizations can be used for employee development or management.

**Bonus**:

- Create a template that can generate individual reports for any employee.
- Include recommendations or action items based on the data.

---

#### Task 9: Build a Simple API

**Objective**: Develop an API to serve data from the dataset.

**Requirements**:

- Implement at least one endpoint that returns data in JSON format.
- Use any framework or language you're comfortable with.
- Include instructions on how to run and test the API.

**Bonus**:

- Implement multiple endpoints for different data queries.
- Include pagination or filtering options.

---

#### Task 10: Sentiment Analysis

**Objective**: Perform sentiment analysis on the comment fields.

**Requirements**:

- Preprocess the text data (e.g., tokenization, stop-word removal).
- Use any method or library to analyze sentiment in Portuguese (e.g., NLTK with Portuguese support, spaCy with
  Portuguese models).
- Summarize the overall sentiment and provide examples.
- Document your approach and findings.

**Note**: Since the comments are in Portuguese, ensure that your tools and methods support processing text in
Portuguese.

---

#### Task 11: Report Generation

**Objective**: Generate a report highlighting key aspects of the data.

**Requirements**:

- Include tables, charts, or graphs to support your findings.
- Summarize important metrics like eNPS scores or feedback trends.
- The report can be in any format (PDF, Markdown, HTML).

---

#### Task 12: Creative Exploration

**Objective**: Explore the dataset in a way that interests you.

**Requirements**:

- Pose a question or hypothesis related to the data.
- Use the data to answer the question or test the hypothesis.
- Document your process, findings, and any conclusions drawn.

---

## Solution: Comments and observations

### Stack

- Ruby 3.3.0
- Rails 7.1.4
- Postgresql 16
- Rspec + FactoryBot + Faker + Capybara + Selenium
- Devise
- Bootstrap
- Docker
- GitHub actions for Linter and CI
- Rubocop and Brakeman
- SimpleCov

### Getting Started

#### Running app

To start the application run:

```rb
docker-compose -f docker-compose.dev.yml up --build
```

> The application on development will run on `http://localhost:3000`

#### Loading csv data

I have created a Lib `SurveyCSVProcessor::Mapper` to map and inject the data from the csv file, maybe I could have
done it all as seed, or using tasks, but creating a lib made my life just easier, it's a very simple lib .

In Flexcode, when I did data migration I used lots of CSVs to map, validate, and extract data,
but I used rake tasks, and it gave hard times, specially to keep code clear, clean and modular, so I choose to go in
another direction this time.

I kept the `data.csv` file within the libs folder, but in real world I would keep it on `tmp` to avoid versioning it.

**Lib usage:**

With seeds:

```sh
bin/rails db:prepare
```

On rails console:

```rb
SurveyCSVProcessor.new('data').inject! 
```

#### About tests and coverage

I have implemented the gem SimpleCov to generate a bit of coverage, to check it just need to run tests

```sh
bundle exec rspec .
```

> But I got a bit frustrated trying to configure it because it keeps counting tests for files that I didn't touch,
> or that doesn't even have content
