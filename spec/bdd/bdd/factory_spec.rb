require 'spec_helper'

describe BDD::Factory do
  let(:factory) { BDD::Factory }

  context ".variable" do
    it { factory.variable('x1').should eq make_var('x1') }
    it { factory.variable('xx').should eq make_var('xx') }
  end

  context ".composition" do
    let(:x1) { factory.variable('x1') }
    let(:x2) { factory.variable('x2') }
    let(:x3) { factory.variable('x3') }

    describe "simplify (variable)" do
      it { factory.composition('+', x1, x1).should eq x1 }
      it { factory.composition('*', x2, x2).should eq x2 }
    end

    describe " or/and compute (variable)" do
      it { factory.composition('+', x1, x2).should eq make_or('x1', 'x2') }
      it { factory.composition('*', x1, x2).should eq make_and('x1', 'x2') }
    end

    let(:x1_or_x2)  { factory.composition('+', x1, x2) }
    let(:x1_and_x2) { factory.composition('*', x1, x2) }
    let(:x1_or_x3)  { factory.composition('+', x1, x3) }
    let(:x1_and_x3) { factory.composition('*', x1, x3) }

    describe "simplify (node)" do
      it { factory.composition('+', x1_or_x2, x1_or_x2).should eq x1_or_x2 }
      it { factory.composition('*', x1_or_x2, x1_or_x2).should eq x1_or_x2 }
    end

    describe " or/and compute (node)" do
      it { factory.composition('+', x1_or_x2, x1_and_x2).should  eq x1_or_x2 }
      it { factory.composition('*', x1_or_x2, x1_and_x2).should  eq x1_and_x2 }

      it { factory.composition('+', x1_or_x2,  x1_or_x3 )
           .should eq make_or('x1', make_or('x2', 'x3')) }
      it { factory.composition('*', x1_and_x2, x1_and_x3)
           .should eq make_and('x1', make_and('x2', 'x3')) }

      it { factory.composition('*', x1_or_x2, x1_or_x3)
           .should eq make_node('x1', 1, make_node('x2', make_var('x3'), 0)) }

      it { factory.composition('+', x1_and_x2, x1_and_x3)
           .should eq make_node('x1', make_node('x2', 1, make_var('x3')), 0) }
    end
  end
end
