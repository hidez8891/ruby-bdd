require 'spec_helper'

describe BDD do
  let(:bdd) { BDD.new() }

  context ".load" do
    it { expect{ BDD.new().load("x1")    }.to_not raise_error }
    it { expect{ BDD.new().load("x1*x2") }.to_not raise_error }
    it { expect{ BDD.new().load("x1+x2") }.to_not raise_error }
  end

  context ".to_hash" do
    it { bdd.load("x1")    ; bdd.to_hash.should eq make_var('x1') }
    it { bdd.load("x1*x2") ; bdd.to_hash.should eq make_and('x1', 'x2') }
    it { bdd.load("x1+x2") ; bdd.to_hash.should eq make_or('x1', 'x2') }
  end

  context ".to_graph" do
    before do
      bdd.load("x1*x2")
    end

    after (:each) do
      File.delete('bdd.eps') if File.exists? 'bdd.eps'
      File.delete('bdd.png') if File.exists? 'bdd.png'
    end

    it { bdd.to_graph()      ; File.exists?('bdd.eps').should be_true } 
    it { bdd.to_graph('eps') ; File.exists?('bdd.eps').should be_true } 
    it { bdd.to_graph('png') ; File.exists?('bdd.png').should be_true } 
  end
end
