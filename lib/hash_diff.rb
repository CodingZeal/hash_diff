require "hash_diff/version"
require "hash_diff/comparison"

module HashDiff
  class << self
    def diff(*args)
      Comparison.new(*args).diff
    end

    def left_diff(*args)
      Comparison.new(*args).left_diff
    end

    def right_diff(*args)
      Comparison.new(*args).right_diff
    end

    def patch!
      Hash.class_eval do
        def diff(right)
          HashDiff.left_diff(self, right)
        end
      end unless self.class.respond_to?(:diff)
    end
  end
end
