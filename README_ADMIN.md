# Admin Dashboard Guide

The admin dashboard is part of the Maa Bhagwati General Store application. It is available at `http://localhost:3000/admin` after the Node.js server has started.

## Configure admin access

The admin login credentials are read from the local `.env` file in the project root:

```env
ADMIN_PASSWORD=your_unique_admin_password
ADMIN_SESSION_SECRET=your_random_secret
```

- Set `ADMIN_PASSWORD` to a unique password of at least 12 characters.
- Set `ADMIN_SESSION_SECRET` to a private random value of at least 32 characters. You can generate one with `node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"`.

For a new installation, first copy `.env.example` to `.env` and configure all database and admin values as described in [README.md](README.md). For an existing local installation, keep your own `.env` file on that computer and update the admin values there if needed. **Do not copy, upload, or commit anyone else's `.env` file.**

## Upgrade an existing installation

1. Stop the running Node.js server with `Ctrl+C`. MySQL can remain running.
2. Back up the project folder and database before replacing project files.
3. Copy the updated application files into the existing project, preserving your local `.env` file and MySQL database.
4. Do not copy a `node_modules` directory between computers. The project includes `package-lock.json`; run `npm install` in the project folder to install the required packages on the current computer.
5. Confirm your `.env` contains `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`, `PORT`, `ADMIN_PASSWORD`, and `ADMIN_SESSION_SECRET`.
6. Run `npm start` and visit `http://localhost:3000/admin`.

Do not drop or recreate an existing database when upgrading, unless you intentionally want to erase its data. Back up the database first.

## Admin functions

- Password-protected admin sign-in using a server-side session and signed HttpOnly cookie.
- Dashboard counts, non-cancelled order totals, and low-stock alerts.
- Add, edit, and delete products and categories.
- Manage prices, descriptions, stock quantities, and HTTPS product image URLs.
- View customer orders and their line items, and update order statuses.

## Important limitations

This is a local-development admin dashboard, not a production-hardened ecommerce admin. It uses one admin password, in-memory sessions (which are cleared when the server restarts), basic per-process login throttling, and an Origin check. For internet deployment, add HTTPS, persistent session storage, a dedicated restricted MySQL user, comprehensive CSRF protection, auditing, robust authentication/rate limiting, and stronger order management. Cancelling an order does not automatically restock products. Product images are HTTPS URLs rather than uploaded files.
