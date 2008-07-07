use strict;
use warnings;
use Test::More tests => 9;
use Test::LongString;
use Test::Exception;

use XML::LibXML;

use ok 'HTML::Document';
use ok 'HTML::Document::Header';

my $h = HTML::Document::Header->new(
    css        => [],
    javascript => [],
    title      => 'Hello, world!',
);
isa_ok $h, 'HTML::Document::Header';

my $t = HTML::Document->new( header => $h );
isa_ok $t, 'HTML::Document';

is_string $t->render,  '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head><title>Hello, world!</title></head>
<body></body>
</html>
';

my @frags = map { XML::LibXML->new->parse_balanced_chunk($_) } (
    '<p>This is a test</p>',
    '<p>of the document!</p>',
);

isa_ok $frags[0], 'XML::LibXML::DocumentFragment';
isa_ok $frags[1], 'XML::LibXML::DocumentFragment';

lives_ok {
    $t->add_fragment(@frags, '<p>And another paragraph</p><p class="foo">Or two</p>');
} 'adding fragments lives';

is_string $t->render, <<EOHTML;
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head><title>Hello, world!</title></head>
<body>
<p>This is a test</p>
<p>of the document!</p>
<p>And another paragraph</p>
<p class="foo">Or two</p>
</body>
</html>
EOHTML
