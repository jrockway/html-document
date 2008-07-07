use inc::Module::Install;

name 'HTML-Document';
all_from 'lib/HTML/Document.pm';

build_requires 'Test::More';
build_requires 'ok';

WriteAll();
