#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use lib '../lib';    # For development testing
use AI::ParticleSwarmOptimization::Pmap;

=head1 NAME

AI::ParticleSwarmOptimization::Pmap test suite

=head1 DESCRIPTION

Test AI::ParticleSwarmOptimization::Pmap

=cut

plan (tests => 1);

# Calculation tests.
my $pso = AI::ParticleSwarmOptimization::Pmap->new (
    -fitFunc        => \&calcFit,
    -dimensions     => 10,
    -iterations     => 10,
    -numParticles   => 1000,

    # only for many-core version # the best if == $#cores of your system
    # selecting best value if undefined
    -workers        => 4,
);

$pso->init();

my $fitValue         = $pso->optimize ();
my ( $best )         = $pso->getBestParticles (1);
my ( $fit, @values ) = $pso->getParticleBestPos ($best);
my $iters            = $pso->getIterationCount();


ok ( $fit > 0, 'Computations');


sub calcFit {
    my @values = @_;
    my $offset = int (-@values / 2);
    my $sum;

    $sum += ($_ - $offset++)**2 for @values;
    return $sum;
}

