require "spec_helper"

describe HashDiff do
  describe ".diff" do
    subject { described_class.diff left, right }

    let(:left) {
      { foo: "bar" }
    }
    let(:right) {
      { foo: "bar2" }
    }

    it { expect(subject).to eq({ foo: ['bar', 'bar2']}) }
  end

  describe ".left_diff" do
    subject { described_class.left_diff left, right }

    let(:left) {
      { foo: "bar" }
    }
    let(:right) {
      { foo: "bar2" }
    }

    it { expect(subject).to eq({ foo: 'bar2' }) }
  end

  describe ".right_diff" do
    subject { described_class.right_diff left, right }

    let(:left) {
      { foo: "bar" }
    }
    let(:right) {
      { foo: "bar2" }
    }

    it { expect(subject).to eq({ foo: 'bar' }) }
  end
end
