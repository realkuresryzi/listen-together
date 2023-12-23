class Current < ActiveSupport::CurrentAttributes
  attribute :session, :user, :token, :user_agent, :ip_address

  delegate :user, to: :session, allow_nil: true
end
