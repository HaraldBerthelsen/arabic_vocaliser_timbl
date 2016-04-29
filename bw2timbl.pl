
# Input:
# bisomi All~ahi Alr~aHomani

# Output
# 3 kons vänsterkontext i ordet, fokus, tre kons högerkontext, vänster ord utan diak, fokus-ord utan diak, höger ord utan diak, klass

# -3 -2 -1 F 1 2 3 -1 0 1 C
# bisomi:

# - - - b s m - - bsm Allh i
# - - b s m - - - bsm Allh o
# - b s m - - - - bsm Allh i
# All~ahi:
# - - - A l l h bsm Allh AlrHmn -
# - - A l l h - bsm Allh AlrHmn -
# - A l l h - - bsm Allh AlrHmn ~a
# A l l h - - - bsm Allh AlrHmn i
# Alr~aHomani:
# - - - A l r H Allh AlrHmn - -
# - - A l r H m Allh AlrHmn - -
# - A l r H m n Allh AlrHmn - ~a
# A l r H m n - Allh AlrHmn - o
# l r H m n - - Allh AlrHmn - a
# r H m n - - - Allh AlrHmn - i
    
#$line = "bisomi All~ahi Alr~aHomani";
#$line = "bisomi All~ahi Alr~aHomani Alr~aHiymi AloHamodu lil~ahi Al~a*iy \$ay~ada biminohaAji diynihi >arokaAna Al$~ariyEapi Alogar~aA'i wasad~ada bi>aHokaAmihi furuwEa AloHaniyfiy~api Als~amoHaA'i mano Eamila bihi faqado At~abaEa sabiyla Alomu&ominiyna ، wamano xaraja Eanohu xaraja Eano masaAliki AlomuEotabiriyna ، >aHomaduhu suboHaAnahu Ealay maA Eal~ama ، wa>a$okuruhu Ealay maA haday waqaw~ama ، wa>a$ohadu >ano laA <laha <l~aA All~ahu waHodahu laA $ariyka lahu ، AlomaAliku Alomaliku AloHaq~u Alomubiynu ، wa>a$ohadu >an~a say~idanaA muHam~adFA Eaboduhu warasuwluhu AlomaboEuwvu raHomapF liloEaAlamiyna ، wanuwrFA lisaA}iri AloxalaA}iqi <lay yawomi Ald~iyni ، >arosalahu Hiyna darasato >aEolaAmu Alohuday waZaharato >aEolaAmu Alr~aday ، waAnoTamasa manohaju AloHaq~i waEafaA ، wa>a$orafa miSobaAHu AlS~idoqi Ealay Al>nTfA ، fa>aEolay mino Ald~iyni maEaAlimahu ، wasan~a Hukoma Al$~aroEi dalaA}ilahu ، faAno$araHa bihi Suduwru >aholi Alo<iymaAni ، waAnozaAHato bihi $ubuhaAtu >aholi AlT~ugoyaAni .";

while (<>) {
    chomp;
    $line = $_;

    @words = split(" ", $line);


    $prevword = "-";
    for ($i=0; $i<@words; $i++) {

	$word = $words[$i];

	if ($i+1 < @words) {
	    $nextword = $words[$i+1];
	} else {
	    $nextword = "-";
	}

	@chars = split("",$word);
	@wordletters = ();
	foreach $char (@chars) {
	    #print "$char\n";
	    unless ( $char =~ /[aiuoFNK~]/ ) {
		push(@wordletters, "$char X");
	    } else {
		$wordletters[-1] = "${wordletters[-1]}$char";
	    }			
	}
	foreach $wordletter (@wordletters) {
	    $wordletter =~ s/X(.+)/\1/;
	    #print "$wordletter\n";
	}
	$L3 = "-";
	$L2 = "-";
	$L1 = "-";
	for ($j=0; $j<@wordletters; $j++) {
	    $wordletter = @wordletters[$j];
	    ($focus, $class) = split(" ",$wordletter);

	    if ($j+1 < @wordletters) {
		@wl_R1 = split(" ",$wordletters[$j+1]);
		$R1 = $wl_R1[0];
	    } else {
		$R1 = "-";
	    }
	    if ($j+2 < @wordletters) {
		@wl_R2 = split(" ",$wordletters[$j+2]);
		$R2 = $wl_R2[0];
	    } else {
		$R2 = "-";
	    }
	    if ($j+3 < @wordletters) {
		@wl_R3 = split(" ",$wordletters[$j+3]);
		$R3 = $wl_R3[0];
	    } else {
		$R3 = "-";
	    }
	    
	    $word =~ s/[aiuo~]//g;
	    $nextword =~ s/[aiuoFNK~]//g;

	    print "$L3 $L2 $L1 $focus $R1 $R2 $R3 $prevword $word $nextword $class\n";
	    $L3 = $L2;
	    $L2 = $L1;
	    $L1 = $focus;
	}
	
	$prevword = $word;
    }
}


