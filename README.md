# Maa Bhagwati General Store — MySQL Edition

A full-stack general-store management project built with **HTML, CSS, JavaScript, Node.js, Express, and MySQL**.

The application includes a product catalogue with search and categories, a shopping cart and checkout, customer accounts with order tracking, and a password-protected admin dashboard for managing products, stock, categories, and orders.

## Requirements

- Node.js 20 or newer (includes npm)
- MySQL Server 8 or newer
- MySQL Workbench or the MySQL command-line client

## Installation and setup

Follow these steps on the computer where you want to run the project.

### 1. Get the project and install MySQL

Extract the project ZIP (or clone the repository), open a terminal in the project folder, and make sure the MySQL server is running.

### 2. Create the database and base tables

Run this command from the project folder:

```bash
mysql -u root -p < database/schema.sql
```

Enter your MySQL password when prompted. Alternatively, open `database/schema.sql` in MySQL Workbench and execute the script. It creates the `maa_bhagwati_store` database and the base tables.

### 3. Create your own `.env` file

The project does **not** include a personal `.env` file because database credentials and admin secrets are different on every computer. Create your own from the example template in the project root.

**Windows PowerShell:**

```powershell
Copy-Item .env.example .env
```

**macOS / Linux:**

```bash
cp .env.example .env
```

Open the newly created `.env` file and enter your own settings:

| Variable | What to enter |
|---|---|
| `DB_HOST` | MySQL server address, normally `localhost` |
| `DB_PORT` | MySQL port, normally `3306` |
| `DB_USER` | Your MySQL username, for example `root` |
| `DB_PASSWORD` | The password for that MySQL user |
| `DB_NAME` | Database name; normally `maa_bhagwati_store` |
| `PORT` | Port for the Node.js server; normally `3000` |
| `ADMIN_PASSWORD` | Your own admin login password; at least 12 characters |
| `ADMIN_SESSION_SECRET` | A private random secret; at least 32 characters |

Generate a strong session secret with Node.js:

```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

Copy the generated value into `ADMIN_SESSION_SECRET`. Replace the example admin password with a unique password of your own. The server will not start until both admin values meet the minimum lengths.

**Keep `.env` private.** Do not upload it, commit it to Git, or send it to other people. Every person running the project should create and configure their own `.env` file on their own computer. The `.env.example` file is only a template and contains no personal credentials.

### 4. Install Node.js packages

Run this from the project folder:

```bash
npm install
```

The project intentionally does not include the `node_modules` directory. `npm install` reads `package.json` and uses `package-lock.json` to install the required packages on the current computer. You only need to run it again when setting up the project on another computer or reinstalling its dependencies.

### 5. Start the application

```bash
npm start
```

Open these addresses in your browser:

- Storefront: <http://localhost:3000>
- Admin dashboard: <http://localhost:3000/admin/index.html>

If you changed `PORT` in `.env`, replace `3000` in the addresses with your configured port.

## First launch and database behaviour

On startup, the server creates the `customers` and `categories` tables and adds the customer link column to the `orders` table when needed. If the `products` table is empty, it inserts 28 sample products. Existing products and orders are not intentionally deleted by this setup process.

## API overview

Public endpoints:

- `GET /api/products?q=&category=All`
- `GET /api/categories`
- `POST /api/orders`

Customer account endpoints:

- `POST /api/account/register`
- `POST /api/account/login`
- `POST /api/account/logout`
- `GET /api/account/me`
- `PUT /api/account/me`
- `GET /api/account/orders`
- `POST /api/account/claim-order`

Admin endpoints are under `/api/admin/*` and require admin sign-in.

## Inspect data in MySQL

```sql
USE maa_bhagwati_store;
SELECT * FROM products;
SELECT * FROM orders ORDER BY id DESC;
SELECT * FROM order_items ORDER BY id DESC;
```

## Additional documentation

- [Admin dashboard guide](README_ADMIN.md)
- [Customer accounts and order tracking upgrade notes](README_UPGRADE.md)

## Project notes and limitations

Prices are sample data. Products display an emoji unless an HTTPS image URL is set for them in the admin dashboard. Checkout records orders; it does not collect payments or arrange delivery. This is an academic/demo project, not a production-ready commerce system. Before real deployment, add HTTPS, persistent session storage, CSRF protection, stronger rate limiting, and a dedicated restricted MySQL user.
