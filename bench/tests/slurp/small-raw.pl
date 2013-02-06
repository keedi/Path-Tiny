my ($size, $how) = split qr/-/, $test->basename;
my $file = $corpus->child("ascii-$size");
die "Couldn't find $file"
    unless $file->exists;

my $result = timethese (
    $count,
    {
        'Path::Tiny'  => sub { my $s = path($file)->slurp_raw },
        'Path::Class' => sub { my $s = file($file)->slurp( iomode => "<:raw" ) },
        'IO::All'     => sub { my $s = io($file)->binary->slurp; },
        'File::Fu'    => sub { my $s = File::Fu->file($file)->read( {binmode => ":raw"}) },
    },
    "none"
);

