# frozen_string_literal: true

RSpec.describe RangeList do
  it "has a version number" do
    expect(RangeList::VERSION).not_to be nil
  end

  def range_list_initialize
    @klass = RangeList.new
  end

  before(:context) do
    range_list_initialize
  end

  context "should raise exception when range" do
    it "type not Array" do
      expect { @klass.add("aaa") }.to raise_error(RangeList::ParametersError)
    end

    it "elements size not equal to 2" do
      expect { @klass.add([1, 2, 3]) }.to raise_error(RangeList::ParametersError)
    end

    it "elements not Integer" do
      expect { @klass.add(["", 2]) }.to raise_error(RangeList::ParametersError)
    end
  end

  context "has method" do
    it "add" do
      expect(@klass.methods.include?(:add)).to be true
    end

    it "remove" do
      expect(@klass.methods.include?(:remove)).to be true
    end

    it "print" do
      expect(@klass.methods.include?(:print)).to be true
    end
  end

  context "a new object should" do
    it "print: [1, 5) after add([1, 5])" do
      @klass.add([1, 5])
      expect { @klass.print }.to output("[1, 5)\n").to_stdout
    end

    it "print: [1, 5) [10, 20) after add([10, 20])" do
      @klass.add([10, 20])
      expect { @klass.print }.to output("[1, 5) [10, 20)\n").to_stdout
    end

    it "print: [1, 5) [10, 20) after add([20, 20])" do
      @klass.add([20, 20])
      expect { @klass.print }.to output("[1, 5) [10, 20)\n").to_stdout
    end

    it "print: [1, 5) [10, 21) after add([20, 21])" do
      @klass.add([20, 21])
      expect { @klass.print }.to output("[1, 5) [10, 21)\n").to_stdout
    end

    it "print: [1, 5) [10, 21) after add([2, 4])" do
      @klass.add([2, 4])
      expect { @klass.print }.to output("[1, 5) [10, 21)\n").to_stdout
    end

    it "print: [1, 8) [10, 21) after add([3, 8])" do
      @klass.add([3, 8])
      expect { @klass.print }.to output("[1, 8) [10, 21)\n").to_stdout
    end

    it "print: [1, 8) [10, 21) after remove([10, 10])" do
      @klass.remove([10, 10])
      expect { @klass.print }.to output("[1, 8) [10, 21)\n").to_stdout
    end

    it "print: [1, 8) [11, 21) after remove([10, 11])" do
      @klass.remove([10, 11])
      expect { @klass.print }.to output("[1, 8) [11, 21)\n").to_stdout
    end

    it "print: [1, 8) [11, 15) [17, 21) after remove([15, 17])" do
      @klass.remove([15, 17])
      expect { @klass.print }.to output("[1, 8) [11, 15) [17, 21)\n").to_stdout
    end

    it "print: [1, 3) [19, 21) after remove([3, 19])" do
      @klass.remove([3, 19])
      expect { @klass.print }.to output("[1, 3) [19, 21)\n").to_stdout
    end
  end
end
