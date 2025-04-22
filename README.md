# RequestFlow API

A Ruby on Rails API with JWT authentication, role-based access control (admin/user), and a complete request approval workflow.

## Features

- Secure authentication with JWT
- User creation (via console or seeds)
- Users can create requests
- Admins can list, approve, or reject requests
- Role-based access: admin and user
- Fully tested (unit + controller)

## Tech Stack

- Ruby on Rails 7 (API mode)
- PostgreSQL
- JWT (json_web_token)
- Bcrypt for password hashing
- Minitest for tests

## Setup

```
bundle install
rails db:create
rails db:migrate
```

## Creating Users (via console)

```
rails console

User.create!(
  email: "admin@fox.com",
  password: "123456",
  password_confirmation: "123456",
  role: "admin"
)
```

## Authentication

```
curl -X POST http://localhost:3000/auth/login   -H "Content-Type: application/json"   -d '{"email": "admin@fox.com", "password": "123456"}'
```

Example response:

```
{
  "token": "your_jwt_token_here",
  "user": {
    "id": 1,
    "email": "admin@fox.com",
    "role": "admin"
  }
}
```

## Requests

### Create a request

```
curl -X POST http://localhost:3000/requests   -H "Authorization: Bearer YOUR_TOKEN"   -H "Content-Type: application/json"   -d '{"request": {"title": "New keyboard", "description": "Old one stopped working"}}'
```

### List all requests (admin only)

```
curl -X GET http://localhost:3000/requests   -H "Authorization: Bearer YOUR_TOKEN"
```

### Approve / Reject (admin only)

```
curl -X PUT http://localhost:3000/requests/1/approve   -H "Authorization: Bearer YOUR_TOKEN"

curl -X PUT http://localhost:3000/requests/1/reject   -H "Authorization: Bearer YOUR_TOKEN"
```

## Running Tests

```
rails test
```

## Author

Built with Rails, logic, and a lot of caffeine by Anderson Araujo