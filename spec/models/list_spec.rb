require 'rails_helper'

describe List do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :tasks }
end
