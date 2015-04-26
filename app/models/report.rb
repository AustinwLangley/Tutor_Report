class Report < ActiveRecord::Base
  belongs_to :user #sets up model relationship where a report belongs to an user.
end
