require 'spec_helper'
describe 'petclinic' do

  context 'with defaults for all parameters' do
    it { should contain_class('petclinic') }
  end
end
