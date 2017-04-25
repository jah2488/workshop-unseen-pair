require 'pry'
require_relative './maybe.rb'
class Array
  instance_methods(false).select { |x| x =~ /first|\[\]/ }.each do |meth|
    og_meth = instance_method(meth)
    define_method meth do |*args, &block|
      result = og_meth.bind(self)[*args, &block]
      if result
        result
      else
        Nothing
      end
    end
  end
end

binding.pry

