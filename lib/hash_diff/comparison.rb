module HashDiff
  class Comparison < Struct.new(:left, :right)
  
    def diff
      @diff ||= differences(left, right)
    end

    def left_diff
      @concern = :left
      @left_diff ||= differences(left, right)
    end

    def right_diff
      @concern = :right
      @right_diff ||= differences(left, right)
    end

    private

    def concern
      @concern ||= :both
    end

    def clone(left, right)
      self.dup.tap do |inst|
        inst.left  = left
        inst.right = right
      end
    end

    def differences(left, right)
      combined_attribute_keys.reduce({}, &reduction_strategy)
    end

    def reduction_strategy
      lambda do |diff, key|
        diff[key] = report(key) if not equal?(key)
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

    def report(key)
      if comparable?(key)
        clone(left[key], right[key]).diff
      else
        report_concern(key)
      end
    end

    def report_concern(key)
      case concern
      when :left  then right[key]
      when :right then left[key]
      when :both  then [left[key], right[key]]
      end
    end
  end
end
