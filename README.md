<<<<<<< HEAD
# Online_Grocery_Store_Management
=======
# Maa Bhagwati General Store — MySQL Edition

Full-stack general-store demo using **HTML, CSS, JavaScript, Node.js, Express, and MySQL**. No SQLite is used.

Includes a product catalogue with search and categories, cart and checkout, customer accounts with order tracking, and a password-protected admin dashboard for products, stock, categories and orders.

## Setup (Mac / Windows / Linux)

1. Install Node.js 20+ and MySQL Server 8+. Start the MySQL service.
2. Open a terminal in the project folder and create the database/tables:
   ```bash
   mysql -u root -p < database/schema.sql
   ```
   Alternatively open `database/schema.sql` in MySQL Workbench and execute it.
3. Create your local environment file:
   ```bash
   cp .env.example .env
   ```
   Edit `.env` and set:
   - `DB_PASSWORD` to your MySQL password (change `DB_USER` if needed)
   - `ADMIN_PASSWORD` to a unique password of at least 12 characters
   - `ADMIN_SESSION_SECRET` to a random string of at least 32 characters (`openssl rand -hex 32`)

   The server will not start until both admin values are set.
4. Install packages and start:
   ```bash
   npm install
   npm start
   ```
5. Open **http://localhost:3000** for the store and **http://localhost:3000/admin** for the admin dashboard.

On first launch, the server inserts 28 demo products if the `products` table is empty, and creates the `customers` and `categories` tables if they are missing. Orders, order items and stock changes are saved in MySQL.

More details: [README_ADMIN.md](README_ADMIN.md) (admin dashboard) and [README_UPGRADE.md](README_UPGRADE.md) (customer accounts and order tracking).

## API

Public:

- `GET /api/products?q=&category=All`
- `GET /api/categories`
- `POST /api/orders` with `{ "customer":"...", "phone":"...", "address":"...", "items":[{"id":1,"quantity":2}] }`

Customer account (signed session cookie):

- `POST /api/account/register`, `POST /api/account/login`, `POST /api/account/logout`
- `GET /api/account/me`, `PUT /api/account/me`
- `GET /api/account/orders`, `POST /api/account/claim-order`

Admin (requires admin sign-in): everything under `/api/admin/*`.

## Inspect data in MySQL

```sql
USE maa_bhagwati_store;
SELECT * FROM products;
SELECT * FROM orders ORDER BY id DESC;
SELECT * FROM order_items ORDER BY id DESC;
```

## Notes

Prices are sample data. Products show an emoji unless an HTTPS image URL is set for them in the admin dashboard. Checkout records orders; it does not collect payments or arrange delivery. This is a learning/demo application, not a production-ready commerce system. Before real use add HTTPS, persistent session storage, CSRF protection, stronger rate limiting, and a dedicated restricted MySQL user.
>>>>>>> 16b1b79 (initial commit)
