# frozen_string_literal: true

class Survey < ApplicationRecord

  has_many :survey_questions, class_name: 'SurveyQuestion'

  include AASM
  extend Enumerize

  before_validation :generate_uuid, on: :create

  STATES = [:submitted, :accepted, :rejected]

  enumerize :aasm_state, in: STATES, scope: true

  aasm whiny_transitions: true, requires_lock: true do
    state :submitted, initial: true
    state :accepted
    state :rejected

    event :accept, after_commit: [:send_notification] do
      transitions from: [:submitted, :rejected], to: :accepted, if: :acceptable?
    end

    event :reject, after_commit: [:send_notification] do
      transitions from: :submitted, to: :rejected, if: :rejectable?
    end
  end


  class << self
    def submit!(params)
      ActiveRecord::Base.transaction do
        create!(title: params[:title], desc: params[:desc]).tap do |o|
          params[:questions].each { |questions| translate_constant(questions[:type]).new.generate(o, questions) }
        end
      end
    end

    def translate_constant(type)
      "SurveyQuestions::#{type.to_s.camelize}".constantize rescue 'unsupported type.'
    end
  end

  private

  def generate_uuid
    self.uuid ||= SecureRandom.uuid unless uuid
  end
end
