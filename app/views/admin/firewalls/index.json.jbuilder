json.array!(@firewalls) do |firewall|
  json.extract! firewall, :id, :remote_ip, :ip_access
  json.url firewall_url(firewall, format: :json)
end
