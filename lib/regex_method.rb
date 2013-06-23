require "regex_method/version"

module RegexMethod
  module ClassMethods
		def define_regex_method(method_name, &block)
			raise "No method block given for #{method_name}" unless block_given?
			self.regex_methods[method_name] = block
		end
	end

	def method_missing(method, *args, &block)
		self.class.regex_methods.each do |regex_method_name, proc|
			if matched_data = method.to_s.match(Regexp.new(regex_method_name))
				regex_method_args = matched_data[1..-1].concat(args)
				return proc.call(*regex_method_args)
			end
		end
		super
	end

	def respond_to?(method)
		self.class.regex_methods.each do |regex_method_name, proc|
			return true if method.to_s.match(Regexp.new(regex_method_name))
		end
		super
	end

	def self.included(base)
		base.extend ClassMethods
		base.class_eval do 
			class << self
				attr_accessor :regex_methods
			end
			self.regex_methods = {}
		end
	end
end
