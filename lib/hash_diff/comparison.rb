require 'ostruct'

module HashDiff
  class Comparison < Struct.new(:left, :right)
  
    def diff
      @side ||= :both
      @diff ||= differences(left, right)
    end

    def left_diff
      @side = :left
      @left_diff ||= differences(left, right)
    end

    def right_diff
      @side = :right
      @right_diff ||= differences(left, right)
    end

    private

    def clone(left, right)
      self.dup.tap do |inst|
        inst.left  = left
        inst.right = right
      end
    end

    def differences(left, right)
      combined_attribute_keys(left, right).reduce({}, &reduction_strategy)
    end

    def reduction_strategy(opts={})
      lambda do |diff, key|
        diff[key] = report(key) if not equal?(key)
        diff
      end
    end

    def combined_attribute_keys(left, right)
      (left.keys + right.keys).uniq
    end

    def equal?(key)
      left.key?(key) && right.key?(key) && left[key] == right[key]
    end

    def hash?(value)
      value.is_a? Hash
    end

    def comparable_key?(key)
      hash?(left[key]) and hash?(right[key])
    end

    def report(key)
      if comparable_key?(key)
        clone(left[key], right[key]).diff
      else
        report_by_side(key)
      end
    end

    def report_by_side(key)
      case @side
      when :left  then right[key]
      when :right then left[key]
      when :both  then [left[key], right[key]]
      end
    end
  end
end