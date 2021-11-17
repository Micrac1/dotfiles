encode(){
	declare -A morse
	morse[A]=".-";
	morse[B]="-...";
	morse[C]="-.-.";
	morse[D]="-..";
	morse[E]=".";
	morse[F]="..-.";
	morse[G]="--.";
	morse[H]="....";
	morse[I]="..";
	morse[J]=".---";
	morse[K]="-.-";
	morse[L]=".-..";
	morse[M]="--";
	morse[N]="-.";
	morse[O]="---";
	morse[P]=".--.";
	morse[Q]="--.-";
	morse[R]=".-.";
	morse[S]="...";
	morse[T]="-";
	morse[U]="..-";
	morse[V]="...-";
	morse[W]=".--";
	morse[X]="-..-";
	morse[Y]="-.--";
	morse[Z]="--..";
	morse[1]=".----";
	morse[2]="..---";
	morse[3]="...--";
	morse[4]="....-";
	morse[5]=".....";
	morse[6]="-....";
	morse[7]="--...";
	morse[8]="---..";
	morse[9]="----.";
	morse[0]="-----";

	for (( k = 0; k < ${#morse}; k++ )); do
		echo "${morse}"
	done
}

decode(){
	declare -A letter
	letter[.-]="A";
	letter[-...]="B";
	letter[-.-.]="C";
	letter[-..]="D";
	letter[.]="E";
	letter[..-.]="F";
	letter[--.]="G";
	letter[....]="H";
	letter[..]="I";
	letter[.---]="J";
	letter[-.-]="K";
	letter[.-..]="L";
	letter[--]="M";
	letter[-.]="N";
	letter[---]="O";
	letter[.--.]="P";
	letter[--.-]="Q";
	letter[.-.]="R";
	letter[...]="S";
	letter[-]="T";
	letter[..-]="U";
	letter[...-]="V";
	letter[.--]="W";
	letter[-..-]="X";
	letter[-.--]="Y";
	letter[--..]="Z";
	letter[-----]="0";
	letter[.----]="1";
	letter[..---]="2";
	letter[...--]="3";
	letter[....-]="4";
	letter[.....]="5";
	letter[-....]="6";
	letter[--...]="7";
	letter[---..]="8";
	letter[----.]="9";

	for (( i = 0; i < ${#morse}; i=i + 1 )); do
		echo "${letter:i}"
	done
}


