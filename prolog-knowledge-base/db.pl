# URL
is_url(prolog, 'https://www.youtube.com/watch?v=SykxWpFwMGs').
is_url(prolog, 'http://www.let.rug.nl/bos/lpn//lpnpage.php?pagetype=html&pageid=lpn-htmlse1').

# VIDEO
is_video('https://www.youtube.com/watch?v=SykxWpFwMGs').

# DOCUMENTATION
is_documentation('http://www.let.rug.nl/bos/lpn//lpnpage.php?pagetype=html&pageid=lpn-htmlse1').

# CODE EXAMPLES

documentation(About) :-
	is_url(About, X),
	is_documentation(X),
	format('Documentation about ~s: ~s', [About, X]).
