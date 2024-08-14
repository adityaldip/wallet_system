# Wallet Transaction API

This is a Ruby on Rails API application for managing wallet transactions between various entities such as users, teams, and stocks. It provides endpoints for creating and viewing transactions and handles wallet balances with validations to ensure proper money manipulation.

## Requirements

- Ruby 3.0.0
- Rails 6.1.7.8
- PostgreSQL or MySQL for the database
- Redis (for caching or background jobs, if applicable)
- RabbitMQ (if using message queuing)

## Getting Started

### Prerequisites

Ensure you have the following installed:

- [Ruby 3.0.0](https://www.ruby-lang.org/en/documentation/installation/)
- [Bundler](https://bundler.io/) (to manage gem dependencies)
- [PostgreSQL](https://www.postgresql.org/download/) or [MySQL](https://dev.mysql.com/downloads/installer/) (as your database)
- [Redis](https://redis.io/download) (optional, based on your usage)
- [RabbitMQ](https://www.rabbitmq.com/download.html) (optional, based on your usage)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/adityaldip/wallet_system.git
   cd wallet_system

2. Install the dependencies:

    bundle install

3. Set up the database:

    rails db:create
    rails db:migrate
    ails db:seed

4. Set up environment variables:

    DATABASE_USERNAME=your_db_username
    DATABASE_PASSWORD=your_db_password
    SECRET_KEY_BASE=your_secret_key_base
    RAPIDAPI_KEY=your_rapidapi_key_here

