#! /usr/bin/sh

stack=$(mktemp) # or a session-set tempfile, whatever

push() {
	echo "$@" >>$stack
}

pop() {
	tmp=$(mktemp)
	bspc node $(tail <$stack -n1) -g hidden=off
	head -n-1 $stack >$tmp
	mv $tmp $stack
}

case $1 in
push)
	if [ -n $2 ]; then
		push $2
	else
		push $(bspc query -N -n)
	fi
	;;
pop) pop ;;
*) exit 1 ;; # unknown arg
esac
