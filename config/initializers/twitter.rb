
Rails.application.config.middleware.use OmniAuth::Builder do
# Nick added his consumer and consumer secret key, Judd please add this next time
  provider :twitter, "Zmhux2jJz4Bdx93wm3CIFA", "4OSq1UHq4tsZdb5r7575qbhKi4EL75R3vJbXpCdTxK0"
end
