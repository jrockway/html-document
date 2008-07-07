package HTML::Document::Header;
use Moose;

has 'css' => (
    is      => 'ro',
    isa     => 'ArrayRef[Str]',
    default => sub { [] },
);

has 'javascript' => (
    is      => 'ro',
    isa     => 'ArrayRef[Str]',
    default => sub { [] },
);

has 'title' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

sub toString {
    my ($self) = @_;
    my $title = $self->title;
    # XXX: hack
    return "<title>$title</title>";
}

1;
