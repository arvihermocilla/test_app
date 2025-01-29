# README

## Prerequisites

Make sure you have the following installed:

* Ruby (check the required version in .ruby-version)

* Bundler (gem install bundler if not installed)

* PostgreSQL

## Setup Instructions

### 1. Clone the Repository via SSH
```sh
 git clone git@github.com:arvihermocilla/test_app.git
 cd test_app
```

### 2. Install Dependencies
```sh
 bundle install
```

### 3. Setup Environment Variables
Modify the `.env.example` file in the root of the project and change the values of the variables once done save the file and rename it to `.env` :
```sh
 PG_HOST=postgres_host
 PG_PORT=postgres_port
 PG_USERNAME=postgres_username
 PG_PASSWORD=postgres_password
```

### 4. Setup the Database
```sh
 rails db:create
 rails db:migrate
```

### 5. Run the Application
Start the Rails server:
```sh
 rails server
```
Visit `http://localhost:3000` to see the app running.

## Running Tests
To run the test suite:
```sh
 bundle exec rspec
```

## Test Payload

To test the payload for the reservations endpoint, use the following cURL command:

```sh
curl -X POST http://localhost:3000/api/reservations \
     -H "Content-Type: application/json" \
     -d '{
          "start_date": "2021-03-12",
          "end_date": "2021-03-16",
          "nights": 4,
          "guests": 4,
          "adults": 2,
          "children": 2,
          "infants": 0,
          "status": "accepted",
          "guest": {
            "id": 1,
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": "639123456789",
            "email": "wayne_woodbridge@bnb.com"
          },
          "currency": "AUD",
          "payout_price": "3800.00",
          "security_price": "500",
          "total_price": "4500.00"
        }'
```

OR

```sh
curl -X POST http://localhost:3000/api/reservations \
     -H "Content-Type: application/json" \
     -d '{
          "reservation": {
          "start_date": "2021-03-12",
          "end_date": "2021-03-16",
          "expected_payout_amount": "3800.00",
          "guest_details": {
            "localized_description": "4 guests",
            "number_of_adults": 2,
            "number_of_children": 2,
            "number_of_infants": 0
          },
          "guest_email": "wayne_woodbridge@bnb.com",
          "guest_first_name": "Wayne",
          "guest_id": 1,
          "guest_last_name": "Woodbridge",
          "guest_phone_numbers": [
            "639123456789",
            "639123456789"
            ],
          "listing_security_price_accurate": "500.00",
          "host_currency": "AUD",
          "nights": 4,
          "number_of_guests": 4,
          "status_type": "accepted",
          "total_paid_amount_accurate": "4500.00"
          }
        }'
```

This will send a JSON payload to `api/reservations` endpoint.
