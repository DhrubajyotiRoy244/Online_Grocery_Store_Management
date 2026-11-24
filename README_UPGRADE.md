# Customer Accounts, Order Tracking, and Categories

This document describes the customer account and order-tracking update for an existing Maa Bhagwati General Store installation.

## Upgrade an existing installation without deleting MySQL data

1. Back up the database before making changes. For example:
   ```bash
   mysqldump -u root -p maa_bhagwati_store > maa_bhagwati_backup.sql
   ```
2. Stop the Node.js server with `Ctrl+C`. MySQL should remain running.
3. Back up the project folder, then copy the updated `public/`, `admin/`, and `server/index.js` files into the corresponding locations in your project. Keep your local `.env` file and existing MySQL database; do not replace them with files from another computer.
4. Check that your own `.env` contains `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`, `PORT`, `ADMIN_PASSWORD`, and `ADMIN_SESSION_SECRET`. If you are setting up a fresh copy instead, create `.env` from `.env.example` and follow [README.md](README.md).
5. Install dependencies on the computer where the application will run:
   ```bash
   npm install
   ```
   The `node_modules` directory is generated locally from `package-lock.json` and should not be copied into the project ZIP or committed to Git.
6. Run the application:
   ```bash
   npm start
   ```
7. The server adds the `customers` and `categories` tables and a nullable `orders.customer_id` column when needed. Existing products and orders are preserved. Do not drop or recreate the database during an upgrade.

## Features included

- Customer registration, sign-in, and profile editing (name, email, phone, and default address).
- Order history, line items, and order-status progress (New → Processing → Shipped → On the way → Delivered).
- Customer order status refreshes every 15 seconds while the My Orders panel is open.
- Admin order-status controls and category management.
- Existing guest orders can be linked from My Orders using the order number and checkout phone number. This is a development convenience, not strong identity verification.
- Product images from HTTPS URLs display in the storefront, with an emoji fallback when no image is set.

## URLs

- Customer storefront: `http://localhost:3000`
- Customer account and order history: use **My Account** and **My Orders** in the storefront.
- Admin dashboard: `http://localhost:3000/admin`

## Notes and limitations

- Previously placed guest orders are not automatically shown in new accounts. The **Link order** form in My Orders uses the order ID and checkout phone number. For a public production site, replace this with phone OTP or another strong ownership-verification method.
- Orders placed after a customer signs in are linked to that account. Checkout requires sign-in.
- The admin updates order status manually. Customer status refresh is not GPS tracking or courier integration.
- Login sessions are stored in server memory and are cleared when the backend restarts, so users must sign in again.
- For production use, add persistent session storage, HTTPS, CSRF protections, email/phone verification, stronger rate limiting, and a dedicated restricted MySQL user.
- Product and category changes are saved in the same MySQL database. Existing orders are not deleted.
