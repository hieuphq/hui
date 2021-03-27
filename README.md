# Hui

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).
### Features

- [x] Auth: `api/auth`
  - [x] Sign up by phone, email `/sign-up`
  - [x] Log in `/login`
- [x] me `/me`
- [x] update profile `/me`
- [ ] Hui
  - [ ] Init Hui
  - [ ] Hui list with status `joined`, `awaiting`, `left`
  - [ ] Invite member
  - [ ] Confirm join
  - [ ] Leave Hui
  - [ ] Transfer Admin
- [ ] Bill
  - [ ] Make a bill and split for members(all, selected members, a member)
- [ ] Balance
  - [ ] Check balance
  - [ ] Deposit
  - [ ] Withdraw
  - [ ] Transfer
- [ ] Transaction

### db diagram
![db diagram](./docs/img/db.png)