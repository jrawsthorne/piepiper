class Campaign < ActiveRecord::Base
	belongs_to :campaign_type
end	

class CampaignType < ActiveRecord::Base
end

