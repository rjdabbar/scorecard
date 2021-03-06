class Scorecard < ActiveRecord::Base
  belongs_to :user
  belongs_to :contestant
  belongs_to :event

  validates_uniqueness_of :name, scope: [:event_id, :contestant_id, :user_id]
  validates_presence_of :lyrics, :stage_presence, :creativity, :delivery_and_flow, :crowd_response, :event_id, :contestant_id

  def self.create_from(hash, user)
    Scorecard.create! do |sc|
      sc.lyrics = hash[:lyrics].to_i
      sc.stage_presence = hash[:stage_presence].to_i
      sc.creativity = hash[:creativity].to_i
      sc.delivery_and_flow = hash[:delivery_and_flow].to_i
      sc.crowd_response = hash[:crowd_response].to_i
      sc.event_id = hash[:event_id]
      sc.contestant_id  = hash[:contestant_id]
      sc.total = (sc.lyrics + sc.stage_presence + sc.creativity + sc.crowd_response + sc.delivery_and_flow)
      sc.name = hash[:name]
      sc.user_id = user.id
    end
  end

  def update_from(hash, scorecard)
    scorecard.lyrics = hash[:lyrics].to_i
    scorecard.stage_presence = hash[:stage_presence].to_i
    scorecard.creativity = hash[:creativity].to_i
    scorecard.delivery_and_flow = hash[:delivery_and_flow].to_i
    scorecard.crowd_response = hash[:crowd_response].to_i
    scorecard.total = (scorecard.lyrics + scorecard.stage_presence + scorecard.creativity + scorecard.crowd_response + scorecard.delivery_and_flow)
    scorecard.save!
  end


  def self.set_user(user, scorecard)
    scorecard.user_id = user.id
  end





  
end




