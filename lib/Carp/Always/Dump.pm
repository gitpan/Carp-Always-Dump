package Carp::Always::Dump;

use 5.010001;
use strict;
use warnings;

use Data::Dump::OneLine qw(dump1);
use Monkey::Patch::Action qw(patch_package);
use Scalar::Util qw(blessed);

our $VERSION = '0.01'; # VERSION

our $Color     = $ENV{COLOR} // 1;
our $DumpObj   = 0;
our $MaxArgLen = 0;

require Carp;
require Carp::Always;
our $h = patch_package(
    "Carp", "format_arg", "replace",
    sub {
        my $arg = shift;
        my $res;

        if (blessed($arg) && !$DumpObj) {
            $res = "'$arg'";
        } else {
            $res = dump1($arg);
            $res = substr($res, 0, $MaxArgLen) . "..."
                if $MaxArgLen > 0 && $MaxArgLen < length($res);
        }

        state $colnum = 0;
        if ($Color) {
            my $col;
            if ($colnum++ % 2) {
                $col = 33;
            } else {
                $col = 36;
            }
            $res = "\e[$col;3m$res\e[0m";
        }

        return $res;
    });

1;
# ABSTRACT: Like Carp::Always, but dumps the content of function arguments


__END__
=pod

=head1 NAME

Carp::Always::Dump - Like Carp::Always, but dumps the content of function arguments

=head1 VERSION

version 0.01

=head1 SYNOPSIS

 % perl -MCarp::Always::Dump script.pl

=head1 VARIABLES

=head2 $Color => BOOL (default: from COLOR environment, or 1)

If set to true, will use terminal colors to help visually distinguish parameters
from one another.

=head2 $DumpObj => BOOL (default: 0)

If set to 1, will dump objects (blessed references) instead of showing
them as 'Foo::Bar=HASH(0x19c8ff8)'.

=head2 $MaxArgLen => INT (default: 0)

Like C<$MaxArgLen> in L<Carp>, to limit the number of characters of dump to
show.

=head1 ENVIRONMENT

=head2 COLOR => BOOL

Used to set the default of C<$Color>.

=head1 SEE ALSO

L<Carp::Always> (and its variants such as: L<Carp::Always::Color>,
L<Carp::Always::SHS>)

L<Devel::SimpleTrace>, a simpler stack trace module, without showing function
arguments.

L<Monkey::Patch::Action>

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

