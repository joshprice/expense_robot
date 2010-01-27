require 'spec'
require 'treetop'
require 'expense_robot'


describe "Expense Robot" do

  before do
    @p = Treetop.load('expense_robot').new
  end
  
  it "should match '100 pizza'" do
    tree = @p.parse("100 pizza")
    tree.should_not be_nil
    tree.cost.text_value.should == "100"
    tree.item.name.text_value.should == "pizza"
  end
  
  it "should not match '100 today'" do
    tree = @p.parse("100 today")
    tree.should be_nil
  end
  
  it "should parse '$100 pizza'" do
    tree = @p.parse("$100 pizza")
    tree.should_not be_nil
    tree.cost.text_value.should == "$100"
    tree.item.name.text_value.should == "pizza"
  end
  
  it "should parse items with spaces '$100 roro pizza'" do
    tree = @p.parse("$100 roro pizza")
    tree.should_not be_nil
    tree.cost.text_value.should == "$100"
    tree.item.name.text_value.should == "roro pizza"
  end
  

  
  describe "with date" do
    it "should parse items with today '$100 pizza today'" do
      tree = @p.parse("$100 pizza today")
      tree.should_not be_nil
      tree.cost.text_value.should == "$100"
      tree.item.name.text_value.should == "pizza"
      tree.time.date.text_value.should == "today"
    end

    it "should parse items with spaces '$100 roro pizza today'" do
      tree = @p.parse("$100 roro pizza today")
      tree.should_not be_nil
      tree.cost.text_value.should == "$100"
      tree.item.name.text_value.should == "roro pizza"
      tree.time.date.text_value.should == "today"
    end
  end
  
end