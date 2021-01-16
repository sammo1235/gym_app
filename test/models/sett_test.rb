require 'test_helper'

class SettTest < ActiveSupport::TestCase
  setup do
    @workout = create(:workout)
  end

  test '#workload calculates volume of sett' do
    sett = @workout.setts.create(weight: 100, reps: 10, lift: create(:lift))

    assert_equal 1000, sett.workload
  end
end
