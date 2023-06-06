# frozen_string_literal: true

module SpaceJam
  class Configuration
    def initialize(configuration = {})
      process!(configuration)
    end

    private

      def process!(configuration)
        configuration.each do |key, value|
          if value.is_a?(Hash)
            instance_variable_set("@#{key}", self.class.new(value))
            value.each do |sub_key, _|
              self.class.define_method(:call, ->(sub_key) { instance_variable_get("@#{sub_key}") })
            end
          else
            instance_variable_set("@#{key}", value)
          end

          self.class.define_method(key) { instance_variable_get("@#{key}") }
        end
      end

      def method_missing(method_name, *args, &block)
        if method_name.to_s.end_with?("=")
          key = method_name[0..-2]

          [args.first].flatten.each do |value|
            if value.is_a?(Hash)
              instance_variable_set("@#{key}".to_sym, self.class.new(value))
              value.each do |sub_key, _|
                self.class.define_method(:call, ->(sub_key) { instance_variable_get("@#{sub_key}") })
              end
            else
              instance_variable_set("@#{key}".to_sym, value)
            end
          end

          define_singleton_method(key) { instance_variable_get("@#{key}") }
        end
      end
  end
end
