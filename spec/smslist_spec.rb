require 'spec_helper'

describe Smslist do

  describe '.new' do
    it 'is a Smslist::Client' do
      expect(Smslist.new).to be_a Smslist::Client
    end
  end

  describe '.respond_to?' do
    it 'is true if method exists' do
      expect(Smslist.respond_to?(:new, true)).to eq(true)
    end
  end

end