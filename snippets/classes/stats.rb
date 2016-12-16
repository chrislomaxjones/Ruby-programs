module Statistics

  def self.factorial(x)
    return nil if x < 0
    return 1 if x == 0 || x == 1
    return x * factorial(x-1)
  end

	class Dataset
		include Enumerable
		include Comparable

		attr_accessor :title, :x

		def <=>(o)
			mean <=> o.mean
		end

		def each
			@data.each do |xi|
				yield xi
			end
		end

		def initialize(x_title="X", *data)
			@title, @data = x_title, data
		end
                                  
		def mean
			@data.inject {|sum,xi| sum+=xi}/@data.length.to_f
		end

		def median
			if @data.length % 2 == 0 # Even dataset
				@data.sort[(@data.length/2.0).round - 1, 2].inject{|sum,x| sum+=x}/2.0
			else # Odd dataset
				@data.sort[(@data.length/2.0).round - 1]
			end
		end

		def mode
			largest_data, largest_freq = 0,0
			group_data_by_frequency.each do |data,freq|
				if freq > largest_freq
					largest_freq = freq 
					largest_data = data
				end
			end
			largest_data
		end

    def range
      @data.sort[0]..@data.sort[-1]
    end

		def standard_deviation
			Math::sqrt(variance)
		end

		def variance
			(@data.inject {|sum, xi| sum+=(xi**2)}/@data.length.to_f - mean**2).abs
		end

    def search_data
      if block_given?
        d = []
        @data.each do |xi| 
          y = yield xi
          d << xi if y
        end
        d
      else
        puts "Fail"
      end
    end

    def trim_data!(&b)
      @data = search_data(&b)
    end

		def group_data_by_frequency
			freq_hash = {}
			@data.each do |xi|
				if freq_hash[xi].nil?
					freq_hash[xi] = 1
				else
					freq_hash[xi]+=1
				end
			end
			freq_hash
		end

		def [](i,l=nil)
			if l.nil? then @data[i] else @data[i,l] end
		end
	
		def []=(i,l=nil,v)
			if l.nil? then @data[i] = v else @data[i,l] = v end
		end

		def +(o)
			if o.is_a? Dataset
				if self.title == o.title
					Dataset.new(self.title, *(@data + o.x))
				else
					Dataset.new(self.title + " and " + o.title, *(@data + o.x))
				end
			elsif o.is_a? Numeric
				Dataset.new(self.title, *@data.map{|xi|xi+o})
			else
				raise TypeError
			end
		end

		def -(o)
			if o.is_a? Dataset
				if self.title == o.title
					Dataset.new(self.title, *(@data - o.x))
				else
					Dataset.new(self.title + " minus " + o.title, *(@data - o.x))
				end
			elsif o.is_a? Numeric
				Dataset.new(self.title, *@data.map{|xi|xi-o})
			else
				raise TypeError
			end
		end

		def *(scalar)
			Dataset.new(self.title, *@data.map{|xi|xi*scalar})
		end

		def /(denom)
			self.*(1/denom.to_f)
		end

		def to_s
			"#{@title}: #{@data.to_s}"
		end

    def self.to_s
      "Single variable dataset"
    end
	end

  class Bivariate
    attr_accessor :x_data, :y_data    
    
    def initialize(x_data, y_data)
      @x_data, @y_data = x_data, y_data
    end

    def to_s
      "X - " + @x_data.to_s + "/ Y - " + @y_data.to_s
    end
  end
end

d = Statistics::Dataset.new("Shoe size", 20, 30, 40, 50, 60, 20, 70, 79, 91)
d2 = Statistics::Dataset.new("Shoe size", 10, 5, 9, 84, 48, 29, 32, 93)

v = Statistics::Bivariate.new(d,d2)
puts v
puts v.x_data.mean

