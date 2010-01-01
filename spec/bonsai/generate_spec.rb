require "#{File.dirname(__FILE__)}/../spec_helper"
describe Bonsai::Generate do
  describe "generator" do
    before :all do
      @path = File.expand_path("spec/tmp-generator")
      FileUtils.rm_rf @path
      Bonsai::Generate.new(@path)
    end
    
    it "should create base directories" do
      %w(content content/index templates public public/docs public/docs/css public/docs/js).each do |dir|
        File.directory?("#{@path}/#{dir}").should be_true
      end
    end
    
    it "should copy the htaccess file to public/.htaccess" do
      File.exists?("#{@path}/public/.htaccess").should be_true
    end
    
    it "should copy the base.less file" do
      File.exists?("#{@path}/public/docs/css/base.less").should be_true
    end
    
    it "should copy an index page" do
      File.exists?("#{@path}/content/index/default.yml").should be_true
    end
    
    it "should copy a default template" do
      File.exists?("#{@path}/templates/default.mustache").should be_true
    end
    
    it "should generate 4 files" do
      Dir.glob("#{@path}/**/*", File::FNM_DOTMATCH).select{|f| File.file?(f) }.size.should == 4
    end
    
    it "should generate 7 directories" do
      Dir.glob("#{@path}/**/*").select{|f| File.directory?(f) }.size.should == 7
    end
  end
end