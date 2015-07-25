require 'rails_helper'

describe Task do
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to belong_to :list }
end
