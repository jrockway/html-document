package HTML::Document;
use Moose;
use XML::LibXML;
use HTML::Document::Header;

has header => (
    is       => 'ro',
    isa      => 'HTML::Document::Header',
    required => 1,
);

has document => (
    init_arg => undef,
    is       => 'ro',
    isa      => 'XML::LibXML::Document',
    lazy     => 1,
    builder  => '_initial_doc',
);

sub _initial_doc {
    my $self = shift;
    my $head_str = $self->header->toString;
    return XML::LibXML->new->parse_html_string(
        qq{<html><head>$head_str</head><body /></html>}
    );
}

sub add_fragment {
    my ($self, @fragments) = @_;
    my $doc = $self->document;
    my ($body) = $doc->getElementsByTagName('body');

    for my $frag (@fragments){
        if(!eval{ $frag->isa('XML::LibXML::Node') }){
            $body->appendChild($_) for (
                [ XML::LibXML->new->parse_html_string($frag)->
                    getElementsByTagName('body')
                ]->[0]->childNodes
            );
        }
        else {
            $body->appendChild($frag);
        }
    }
    return;
}

sub render {
    my $self = shift;
    return $self->document->toStringHTML;
}

1;
