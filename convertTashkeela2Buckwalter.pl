@taskeela_files = glob("~/arabic_stuff/avcorpus_taskeela/texts.txt/*.htm.txt");
$outdir = "bw-taskeela";

foreach $taskeela_file (@taskeela_files) {
    #convert filename

    $taskeela_file =~ /([^\/]+).htm.txt/;
    $name = $1;

    $cmd = sprintf "echo %s > /tmp/name_ar; python buckwalter.py -hamza -madda -harakat -tatweel -t -corpus /tmp/name_ar", $name; 
    print "$cmd\n";
    $name_bw = `$cmd`;
    chomp($name_bw);
    print "NAME_BW: $name_bw\n";


    #convert file
    $bw_filename = sprintf "%s/%s.txt", $outdir, $name_bw;
    $tmp_bw = "/tmp/bw_file";
    $cmd = sprintf "python buckwalter.py -hamza -madda -harakat -tatweel -t -corpus '%s' > %s", $taskeela_file, $tmp_bw;
    print "$cmd\n";
    `$cmd`;

    #skip header and anything in [] and ()
    open(TMP,$tmp_bw);
    open(OUT,">$bw_filename");

    #skip first four lines
    <TMP>;
    <TMP>;
    <TMP>;
    <TMP>;
    while (<TMP>) {
	s/\[[^\]]+\]//g;
	s/\([^\]]+\)//g;
	print OUT;
    }
    close(OUT);
    close(TMP);


}
