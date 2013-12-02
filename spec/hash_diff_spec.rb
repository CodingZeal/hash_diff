require "spec_helper"

describe HashDiff do
  describe ".diff" do
    let(:comparison) { double("comparison") }
    let(:left) { double("left") }
    let(:right) { double("right") }

    it "delegates to Comparison#diff" do
      HashDiff::Comparison.should_receive(:new).with(left, right).and_return(comparison)
      comparison.should_receive(:diff)
      HashDiff.diff(left, right)
    end
  end

  describe ".left_diff" do
    let(:comparison) { double("comparison") }
    let(:left) { double("left") }
    let(:right) { double("right") }
    
    it "delegates to Comparison#left_diff" do
      HashDiff::Comparison.should_receive(:new).with(left, right).and_return(comparison)
      comparison.should_receive(:left_diff)
      HashDiff.left_diff(left, right)
    end
  end

  describe ".right_diff" do
    let(:comparison) { double("comparison") }
    let(:left) { double("left") }
    let(:right) { double("right") }
    
    it "delegates to Comparison#right_diff" do
      HashDiff::Comparison.should_receive(:new).with(left, right).and_return(comparison)
      comparison.should_receive(:right_diff)
      HashDiff.right_diff(left, right)
    end
  end
end