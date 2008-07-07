use inc::Module::Install;

name 'HTML-Document';
all_from 'lib/HTML/Document.pm';

requires 'Moose';
requires 'XML::LibXML';
build_requires 'Test::Exception';
build_requires 'Test::LongString';
build_requires 'Test::More';
build_requires 'ok';

WriteAll();
