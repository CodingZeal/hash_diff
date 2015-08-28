module HashDiff
  class Comparison
    def initialize(left, right)
      @left  = left
      @right = right
    end

    attr_reader :left, :right

    def diff
      @diff ||= find_differences { |l, r| [l, r] }
    end

    def left_diff
      @left_diff ||= find_differences { |_, r| r }
    end

    def right_diff
      @right_diff ||= find_differences { |l, _| l }
    end

    protected

    def find_differences(&reporter)
      combined_keys.each_with_object({ }, &comparison_strategy(reporter))
    end

    private

    def comparison_strategy(reporter)
      lambda do |key, diff|
        diff[key] = report_difference(key, reporter) unless equal?(key)
      end
    end

    def combined_keys
      (left.keys + right.keys).uniq
    end

    def equal?(key)
      left[key] == right[key]
    end

    def hash?(value)
      value.is_a?(Hash)
    end

    def comparable?(key)
      hash?(left[key]) && hash?(right[key])
    end

    def report_difference(key, reporter)
      if comparable?(key)
        self.class.new(left[key], right[key]).find_differences(&reporter)
      else
        reporter.call(left[key], right[key])
      end
    end
  end
end
