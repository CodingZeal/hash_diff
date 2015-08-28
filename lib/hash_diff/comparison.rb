module HashDiff
  class Comparison < Struct.new(:left, :right)
  
    def diff(&reporter)
      @diff ||= combined_attribute_keys.reduce(
        { },
        &reduction_strategy(reporter || ->(l, r) { [l, r] })
      )
    end

    def left_diff
      @left_diff ||= diff { |_, r| r }
    end

    def right_diff
      @right_diff ||= diff { |l, _| l }
    end

    private

    def clone(left, right)
      self.dup.tap do |inst|
        inst.left  = left
        inst.right = right
      end
    end

    def reduction_strategy(reporter)
      lambda do |diff, key|
        diff[key] = report(key, reporter) if not equal?(key)
        diff
      end
    end

    def combined_attribute_keys
      (left.keys + right.keys).uniq
    end

    def equal?(key)
      left[key] == right[key]
    end

    def hash?(value)
      value.is_a? Hash
    end

    def comparable?(key)
      hash?(left[key]) and hash?(right[key])
    end

    def report(key, reporter)
      if comparable?(key)
        clone(left[key], right[key]).diff(&reporter)
      else
        reporter.call(left[key], right[key])
      end
    end
  end
end
