##
# name:      YamlTime::Git
# abstract:  Git Support for YamlTime
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011
# see:
# - YamlTime

use 5.008003;
use YamlTime 0.10 ();

package YamlTime::Git;

our $VERSION = '0.02';

# XXX Put this here on 28/07/2011. Leave in for a while...
{
    no warnings;
    eval "require YamlTime::Extension::Git";
    die <<"..." unless $@;

It looks like you have YamlTime::Extension::Git installed.
You need to remove it from your system. It has been replaced
by YamlTime::Git.

Please remove $INC{'YamlTime/Extension/Git.pm'}

...
}

package YamlTime::Command::commit;
use Mouse;
YamlTime->import( -command );
extends qw[YamlTime::Command];
use constant abstract => "'git commit' your YamlTime changes";

sub execute {
    my ($self, $opt, $args) = @_;
    my @args = @$args || ('-m', 'YamlTime!');
    $self->run('git add .') and
    $self->run("git commit @args");
}

package YamlTime::Command::push;
use Mouse;
YamlTime->import( -command );
extends qw[YamlTime::Command];
use constant abstract => "'git push' your YamlTime repository";

sub execute {
    my ($self, $opt, $args) = @_;
    my @args = @$args || qw(origin master);
    $self->run("git push @args");
}

1;

=head1 SYNOPSIS

    > yt commit     # Add and commit all changes to the YamlTime data store
    > yt push       # Push changes to the upstream repo
