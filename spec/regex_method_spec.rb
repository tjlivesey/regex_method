require 'spec_helper'

describe RegexMethod  do
	before :all do
		class Foo
			include RegexMethod
		end
	end

	it "should should define a class attr_accessor for storing method names and procs" do
		Foo.should respond_to :regex_methods
		Foo.should respond_to :regex_methods=
	end

	context "with a defined regex method" do
		before do
			class Addition
				include RegexMethod

				define_regex_method 'add_(\d*)_to_(\d*)' do |first_number, second_number|
					first_number.to_i + second_number.to_i
				end
			end
		end

		it "should register the method names and associated closure when the method is defined" do
			Addition.regex_methods['add_(\d*)_to_(\d*)'].should be_a Proc
		end

		it "should return the value from the defined method" do
			addition = Addition.new
			addition.add_6_to_8.should == 14
			addition.add_10_to_33.should == 43
		end

		it "should call super from method missing if no method is matched" do
			addition = Addition.new
			addition.add_6_to_8_to_10.should raise_error NoMethodError
		end

		it "respond_to? the regex method should return true" do
			addition = Addition.new
			addition.respond_to?(:add_6_to_10).should be_true
		end
	end
	
end