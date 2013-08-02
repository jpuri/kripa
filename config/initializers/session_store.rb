# Be sure to restart your server when you modify this file.

Kripa::Application.config.session_store :active_record_store, {
  :key =>           '_kripa_session',
  :expire_after =>  60 * 5
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Kripa::Application.config.session_store :active_record_store

