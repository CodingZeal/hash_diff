require "spec_helper"

describe HashDiff::Comparison do

  let(:app_v1_properties) { { foo: 'bar',  bar: 'foo',  nested: { foo: 'bar',  bar: { one: 'foo1' } }, num: 1 } }
  let(:app_v2_properties) { { foo: 'bar2', bar: 'foo2', nested: { foo: 'bar2', bar: { two: 'foo2' } }, word: 'monkey' } }

  subject(:comparison) { HashDiff::Comparison.new(app_v1_properties, app_v2_properties) }

  describe "#diff" do
    subject { comparison.diff }

    context "when different" do
      let(:diff) {
        {
          foo: ["bar", "bar2"],
          bar: ["foo", "foo2"],
          nested: {
            foo: ["bar", "bar2"],
            bar: {
              one: ["foo1", nil],
              two: [nil, "foo2"]
            }
          },
          num:  [1, nil],
          word: [nil, "monkey"]
        }
      }

      it { expect(subject).to eq diff }
    end

    context "when similar" do
      let(:app_v1_properties) { { foo: 'bar', bar: 'foo' } }

      context "in the same order" do
        let(:app_v2_properties) { app_v1_properties }

        it { expect(subject).to be_empty }
      end

      context "in a different order" do
        let(:app_v2_properties) { { bar: 'foo', foo: 'bar' } }

        it { expect(subject).to be_empty }
      end
    end
  end

  describe "#left_diff" do
    subject { comparison.left_diff }

    let(:diff) {
      {
        foo: "bar2",
        bar: "foo2",
        nested: {
          foo: "bar2",
          bar: {
            one: nil,
            two: "foo2"
          }
        },
        num:  nil,
        word: "monkey"
      }
    }

    it { expect(subject).to eq diff }
  end

  describe "#right_diff" do
    subject { comparison.right_diff }

    let(:diff) {
      {
        foo: "bar",
        bar: "foo",
        nested: {
          foo: "bar",
          bar: {
            one: "foo1",
            two: nil
          }
        },
        num:  1,
        word: nil
      }
    }

    it { expect(subject).to eq diff }
  end
end
