class AnalysisResult < ApplicationRecord
  has_many :Responses, dependent: :destroy
end
