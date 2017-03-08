# Don't edit Makefile! Use conf-* for configuration.

SHELL=/bin/sh

# create libs (*.a)
# create object files (*.o)
# link files
# create man pages

default: conf libs it mans

clean: TARGETS
	rm -f *.o *.a *.tmp `cat TARGETS`
	cd lib ; make clean
	cd man ; make clean

conf: configure
	./configure

install: instnew.sh
	./instnew.sh

setup: install

mans:
	cd man/ ; make

libs:
	cd lib ; make

#auto-int8: compile load auto-int8.c substdio.a error.a str.a fs.a
#	./compile auto-int8.c
#	./load auto-int8 substdio.a error.a str.a fs.a

#auto-int8.o: \
#compile auto-int8.c
#	./compile auto-int8.c

auto_break.o: compile auto_break.c
	./compile auto_break.c

#auto_patrn.c: auto-int8 conf-patrn
#	./auto-int8 auto_patrn `head -1 conf-patrn` > auto_patrn.c

auto_patrn.o: compile conf-patrn
# auto_patrn.c auto-int8
	./compile auto-int8.c
	./load auto-int8 substdio.a error.a str.a fs.a
	./auto-int8 auto_patrn `head -1 conf-patrn` > auto_patrn.c
	./compile auto_patrn.c

#auto_patrn.o: \
#compile auto_patrn.c
#	./compile auto_patrn.c

auto_qmail.o: compile auto_qmail.c
	./compile auto_qmail.c

auto_spawn.o: compile auto_spawn.c
	./compile auto_spawn.c

auto_split.o: compile auto_split.c
	./compile auto_split.c

auto_uids.o: compile auto_uids.c
	./compile auto_uids.c

auto_usera.o: compile auto_usera.c
	./compile auto_usera.c

bouncesaying: load bouncesaying.c strerr.a error.a substdio.a str.a wait.a
	./compile bouncesaying.c
	./load bouncesaying strerr.a error.a substdio.a str.a wait.a

#cdb.a: compile makelib cdb.c
#	./compile cdb.c
#	./makelib cdb.a cdb.o

#cdbmake.a: compile makelib cdbmake.c
#	./compile cdbmake.c
#	./makelib cdbmake.a cdbmake.o

#cdbmss.o: compile cdbmss.c
#	./compile cdbmss.c

chkspawn: \
load chkspawn.o substdio.a error.a str.a fs.a auto_spawn.o
	./load chkspawn substdio.a error.a str.a fs.a auto_spawn.o 

chkspawn.o: compile chkspawn.c 
	./compile chkspawn.c

commands.o: compile commands.c
	./compile commands.c

condredirect: \
load condredirect.o qmail.o strerr.a fd.a sig.a wait.a seek.a env.a \
substdio.a error.a str.a fs.a auto_qmail.o
	./load condredirect qmail.o strerr.a fd.a sig.a wait.a \
	seek.a env.a substdio.a error.a str.a fs.a auto_qmail.o 

condredirect.o: compile condredirect.c
	./compile condredirect.c

config: \
warn-auto.sh config.sh conf-qmail conf-break conf-split
	cat warn-auto.sh config.sh \
	| sed s}QMAIL}"`head -1 conf-qmail`"}g \
	| sed s}BREAK}"`head -1 conf-break`"}g \
	| sed s}SPLIT}"`head -1 conf-split`"}g \
	> config
	chmod 755 config

config-bfrmt: warn-auto.sh config-bfrmt.sh conf-qmail
	cat warn-auto.sh config-bfrmt.sh \
	| sed s}QMAIL}"`head -1 conf-qmail`"}g > config-bfrmt
	chmod 755 config-bfrmt

config-spp: warn-auto.sh config-spp.sh conf-qmail
	cat warn-auto.sh config-spp.sh \
	| sed s}QMAIL}"`head -1 conf-qmail`"}g > config-spp
	chmod 755 config-spp

constmap.o: compile constmap.c
	./compile constmap.c

control.o: compile control.c
	./compile control.c

date822fmt.o: compile date822fmt.c
	./compile date822fmt.c

datemail: \
warn-auto.sh datemail.sh conf-qmail conf-break conf-split
	cat warn-auto.sh datemail.sh \
	| sed s}QMAIL}"`head -1 conf-qmail`"}g \
	| sed s}BREAK}"`head -1 conf-break`"}g \
	| sed s}SPLIT}"`head -1 conf-split`"}g \
	> datemail
	chmod 755 datemail

datetime.a: compile makelib datetime.c
	./compile datetime.c
	./makelib datetime.a datetime.o

dns.o: compile dns.c
	./compile dns.c

except: compile load except.c strerr.a error.a substdio.a str.a wait.a
	./compile except.c
	./load except strerr.a error.a substdio.a str.a wait.a

fmtqfn.o: compile fmtqfn.c
	./compile fmtqfn.c

forward: compile load forward.c qmail.o strerr.a alloc.a fd.a \
wait.a sig.a env.a substdio.a error.a str.a fs.a auto_qmail.o
	./compile forward.c
	./load forward qmail.o strerr.a alloc.a fd.a wait.a sig.a \
	env.a substdio.a error.a str.a fs.a auto_qmail.o 

gfrom.o: compile gfrom.c
	./compile gfrom.c

# needed by lock.o
#hasflock.h: tryflock.c compile load
#	( ( ./compile tryflock.c && ./load tryflock ) >/dev/null 2>&1 \
#	&& echo \#define HASFLOCK 1 || exit 0 ) > hasflock.h
#	rm -f tryflock.o tryflock

hassalen.h: \
trysalen.c compile
	( ./compile trysalen.c >/dev/null 2>&1 \
	&& echo \#define HASSALEN 1 || exit 0 ) > hassalen.h
#	rm -f trysalen.o

#hasshsgr.h: \
#chkshsgr warn-shsgr tryshsgr.c compile load
#	./chkshsgr || ( cat warn-shsgr; exit 1 )
#	( ( ./compile tryshsgr.c \
#	&& ./load tryshsgr && ./tryshsgr ) >/dev/null 2>&1 \
#	&& echo \#define HASSHORTSETGROUPS 1 || exit 0 ) > \
#	hasshsgr.h
#	rm -f tryshsgr.o tryshsgr

# needed by wait.o (wait_pid)
#haswaitp.h: trywaitp.c compile load
#	( ( ./compile trywaitp.c && ./load trywaitp ) >/dev/null 2>&1 \
#	&& echo \#define HASWAITPID 1 || exit 0 ) > haswaitp.h
##	rm -f trywaitp.o trywaitp

headerbody.o: compile headerbody.c
	./compile headerbody.c

hfield.o: compile hfield.c
	./compile hfield.c

ip.o: compile ip.c
	./compile ip.c

ipalloc.o: compile ipalloc.c
	./compile ipalloc.c

ipme.o: compile ipme.c hassalen.h
	./compile ipme.c

ipmeprint: compile load ipmeprint.c ipme.o ip.o ipalloc.o \
stralloc.a alloc.a substdio.a error.a str.a fs.a
	./compile ipmeprint.c
	./load ipmeprint ipme.o ip.o ipalloc.o stralloc.a alloc.a \
	substdio.a error.a str.a fs.a

it: \
qmail-local qmail-lspawn qmail-getpw qmail-remote qmail-rspawn \
qmail-clean qmail-send qmail-start splogger qmail-queue qmail-inject \
predate datemail mailsubj qmail-newu \
qmail-pw2u qmail-qread qmail-qstat qmail-tcpto qmail-tcpok \
qmail-qmqpc qmail-qmqpd qmail-qmtpd \
qmail-smtpd sendmail tcp-env qmail-newmrh config \
qreceipt qsmhook qbiff \
forward preline condredirect bouncesaying except maildirmake \
maildir2mbox maildirwatch \
update_tmprsadh config-spp qmail-bfrmt config-bfrmt ipmeprint \
mkrsadhkeys mksrvrcerts qmail-fixq qmail-shcfg

# idedit config-fast hostname qmail-upq qail elq pinq
#home home+df proc proc+df binm1 binm1+df binm2 binm2+df \
#binm3 binm3+df 
#qmail-pop3d qmail-popup 
#install-big install instcheck 

maildir.o: compile maildir.c 
	./compile maildir.c

maildir2mbox: compile load maildir2mbox.c maildir.o prioq.o now.o \
myctime.o gfrom.o lock.a getln.a env.a open.a strerr.a stralloc.a \
alloc.a substdio.a error.a str.a fs.a datetime.a
	./compile maildir2mbox.c
	./load maildir2mbox maildir.o prioq.o now.o myctime.o \
	gfrom.o lock.a getln.a env.a open.a strerr.a stralloc.a \
	alloc.a substdio.a error.a str.a fs.a datetime.a 

maildirmake: compile \
load maildirmake.c strerr.a substdio.a error.a str.a
	./compile maildirmake.c
	./load maildirmake strerr.a substdio.a error.a str.a 

maildirwatch: \
load maildirwatch.o hfield.o headerbody.o maildir.o prioq.o now.o \
getln.a env.a open.a strerr.a stralloc.a alloc.a substdio.a error.a \
str.a
	./load maildirwatch hfield.o headerbody.o maildir.o \
	prioq.o now.o getln.a env.a open.a strerr.a stralloc.a \
	alloc.a substdio.a error.a str.a 

maildirwatch.o: \
compile maildirwatch.c
# getln.h substdio.h subfd.h substdio.h prioq.h \
#datetime.h gen_alloc.h stralloc.h gen_alloc.h
# str.h exit.h hfield.h \
#open.h headerbody.h maildir.h strerr.h
	./compile maildirwatch.c

mailsubj: warn-auto.sh mailsubj.sh conf-qmail conf-break conf-split
	cat warn-auto.sh mailsubj.sh \
	| sed s}QMAIL}"`head -1 conf-qmail`"}g \
	| sed s}BREAK}"`head -1 conf-break`"}g \
	| sed s}SPLIT}"`head -1 conf-split`"}g \
	> mailsubj
	chmod 755 mailsubj

myctime.o: compile myctime.c
	./compile myctime.c

newfield.o: compile newfield.c
	./compile newfield.c

now.o: compile now.c
	./compile now.c

predate: compile \
load predate.c datetime.a strerr.a sig.a fd.a wait.a substdio.a \
error.a str.a fs.a
	./compile predate.c
	./load predate datetime.a strerr.a sig.a fd.a wait.a \
	substdio.a error.a str.a fs.a 

preline: compile load preline.c strerr.a fd.a wait.a sig.a env.a \
getopt.a substdio.a error.a str.a
	./compile preline.c
	./load preline strerr.a fd.a wait.a sig.a env.a getopt.a \
	substdio.a error.a str.a

prioq.o: compile prioq.c
	./compile prioq.c

prot.o: compile prot.c
	./compile prot.c

qbiff: compile load qbiff.c headerbody.o hfield.o getln.a env.a \
open.a stralloc.a alloc.a substdio.a error.a str.a
	./compile qbiff.c
	./load qbiff headerbody.o hfield.o getln.a env.a open.a \
	stralloc.a alloc.a substdio.a error.a str.a 

qmail-bfrmt: qmail-bfrmt.sh
	cat warn-auto.sh qmail-bfrmt.sh \
	| sed s}QMAIL}"`head -1 conf-qmail`"}g > qmail-bfrmt
	chmod 755 qmail-bfrmt && \
	chgrp qmail qmail-bfrmt

qmail-clean: compile load qmail-clean.c fmtqfn.o now.o getln.a sig.a \
stralloc.a alloc.a substdio.a error.a str.a fs.a auto_qmail.o auto_split.o
	./compile qmail-clean.c
	./load qmail-clean fmtqfn.o now.o getln.a sig.a stralloc.a \
	alloc.a substdio.a error.a str.a fs.a auto_qmail.o auto_split.o

qmail-fixq: qmail-fixq.sh
	sh ./qmail-fixq.sh

qmail-getpw: \
load qmail-getpw.o case.a substdio.a error.a str.a fs.a auto_break.o \
auto_usera.o
	./load qmail-getpw case.a substdio.a error.a str.a fs.a \
	auto_break.o auto_usera.o 

qmail-getpw.o: compile qmail-getpw.c
	./compile qmail-getpw.c

qmail-inject: compile load qmail-inject.c headerbody.o hfield.o \
newfield.o quote.o now.o control.o date822fmt.o constmap.o qmail.o \
case.a fd.a wait.a open.a getln.a sig.a getopt.a datetime.a token822.o \
env.a stralloc.a alloc.a substdio.a error.a str.a fs.a auto_qmail.o
	./compile qmail-inject.c
	./load qmail-inject headerbody.o hfield.o newfield.o quote.o now.o \
	control.o date822fmt.o constmap.o qmail.o case.a fd.a wait.a open.a \
	getln.a sig.a getopt.a datetime.a token822.o env.a stralloc.a \
	alloc.a substdio.a error.a str.a fs.a auto_qmail.o 

# getopt.a --> getoptb
qmail-local: compile load qmail-local.c qmail.o quote.o now.o gfrom.o \
myctime.o slurpclose.o  datetime.a auto_qmail.o auto_patrn.o
#case.a getln.a getoptb.a sig.a open.a seek.a \
#lock.a fd.a wait.a env.a stralloc.a alloc.a strerr.a substdio.a \
#error.a str.a fs.a
	./compile qmail-local.c
	./load qmail-local qmail.o quote.o now.o gfrom.o myctime.o \
	slurpclose.o case.a getln.a getoptb.a sig.a open.a seek.a lock.a \
	buffer.a \
	fd.a wait.a env.a stralloc.a alloc.a strerr.a \
	error.a str.a fs.a datetime.a auto_qmail.o auto_patrn.o \
	substdio.a

qmail-lspawn: compile load qmail-lspawn.c spawn.o prot.o slurpclose.o \
sig.a wait.a case.a cdb.a fd.a open.a stralloc.a alloc.a \
substdio.a error.a str.a fs.a auto_qmail.o auto_uids.o auto_spawn.o
	./compile qmail-lspawn.c
	./load qmail-lspawn spawn.o prot.o slurpclose.o sig.a wait.a \
	case.a cdb.a fd.a open.a stralloc.a alloc.a substdio.a error.a \
	str.a fs.a auto_qmail.o auto_uids.o auto_spawn.o

qmail-newmrh: compile \
load qmail-newmrh.c cdb.a getln.a open.a seek.a case.a buffer.a \
stralloc.a alloc.a strerr.a substdio.a error.a str.a auto_qmail.o
	./compile qmail-newmrh.c
	./load qmail-newmrh cdb.a getln.a open.a buffer.a \
	seek.a case.a stralloc.a alloc.a strerr.a substdio.a \
	error.a str.a auto_qmail.o

qmail-newu: compile load qmail-newu.c cdb.a getln.a open.a seek.a \
case.a stralloc.a alloc.a substdio.a error.a str.a auto_qmail.o
	./compile qmail-newu.c
	./load qmail-newu cdb.a getln.a open.a seek.a buffer.a \
	case.a stralloc.a alloc.a substdio.a error.a str.a auto_qmail.o

qmail-pw2u: \
load qmail-pw2u.o constmap.o control.o open.a getln.a case.a getopt.a \
stralloc.a alloc.a substdio.a error.a str.a fs.a auto_usera.o \
auto_break.o auto_qmail.o
	./load qmail-pw2u constmap.o control.o open.a getln.a \
	case.a getopt.a stralloc.a alloc.a substdio.a error.a str.a \
	fs.a auto_usera.o auto_break.o auto_qmail.o 

qmail-pw2u.o: compile qmail-pw2u.c 
	./compile qmail-pw2u.c

qmail-qmqpc: \
load qmail-qmqpc.o slurpclose.o timeoutread.o timeoutwrite.o \
timeoutconn.o ip.o control.o auto_qmail.o sig.a ndelay.a open.a \
getln.a substdio.a stralloc.a alloc.a error.a str.a fs.a
	./load qmail-qmqpc slurpclose.o timeoutread.o \
	timeoutwrite.o timeoutconn.o ip.o control.o auto_qmail.o \
	sig.a ndelay.a open.a getln.a substdio.a stralloc.a alloc.a \
	error.a str.a fs.a

qmail-qmqpc.o: \
compile qmail-qmqpc.c
	./compile qmail-qmqpc.c

qmail-qmqpd: \
load qmail-qmqpd.o received.o now.o date822fmt.o qmail.o auto_qmail.o \
env.a substdio.a sig.a error.a wait.a fd.a str.a datetime.a fs.a
	./load qmail-qmqpd received.o now.o date822fmt.o qmail.o \
	auto_qmail.o env.a substdio.a sig.a error.a wait.a fd.a \
	str.a datetime.a fs.a 

qmail-qmqpd.o: compile qmail-qmqpd.c
	./compile qmail-qmqpd.c

qmail-qmtpd: \
load qmail-qmtpd.o rcpthosts.o control.o constmap.o received.o \
date822fmt.o now.o qmail.o cdb.a fd.a wait.a datetime.a open.a \
getln.a sig.a case.a env.a stralloc.a alloc.a substdio.a error.a \
str.a fs.a auto_qmail.o
	./load qmail-qmtpd rcpthosts.o control.o constmap.o \
	received.o date822fmt.o now.o qmail.o cdb.a fd.a wait.a \
	datetime.a open.a getln.a sig.a case.a env.a stralloc.a \
	alloc.a substdio.a error.a str.a fs.a auto_qmail.o 

qmail-qmtpd.o: compile qmail-qmtpd.c
	./compile qmail-qmtpd.c

qmail-qread: compile load qmail-qread.c fmtqfn.o readsubdir.o date822fmt.o \
datetime.a open.a getln.a stralloc.a alloc.a substdio.a error.a str.a fs.a \
auto_qmail.o auto_split.o
	./compile qmail-qread.c
	./load qmail-qread fmtqfn.o readsubdir.o date822fmt.o \
	datetime.a open.a getln.a stralloc.a alloc.a substdio.a \
	error.a str.a fs.a auto_qmail.o auto_split.o

qmail-qstat: warn-auto.sh qmail-qstat.sh conf-qmail conf-break conf-split
	cat warn-auto.sh qmail-qstat.sh \
	| sed s}QMAIL}"`head -1 conf-qmail`"}g \
	| sed s}BREAK}"`head -1 conf-break`"}g \
	| sed s}SPLIT}"`head -1 conf-split`"}g > qmail-qstat
	chmod 755 qmail-qstat

qmail-queue: compile load qmail-queue.c triggerpull.o fmtqfn.o now.o \
date822fmt.o datetime.a seek.a ndelay.a open.a sig.a alloc.a substdio.a \
error.a str.a fs.a auto_qmail.o auto_split.o auto_uids.o
	./compile qmail-queue.c
	./load qmail-queue triggerpull.o fmtqfn.o now.o date822fmt.o \
	datetime.a seek.a ndelay.a open.a sig.a alloc.a substdio.a \
	error.a str.a fs.a auto_qmail.o auto_split.o auto_uids.o 

qmail-remote: compile load qmail-remote.c control.o constmap.o timeoutread.o \
timeoutwrite.o timeoutconn.o tcpto.o now.o dns.o ip.o ipalloc.o ipme.o quote.o \
ndelay.a case.a sig.a open.a lock.a seek.a getln.a stralloc.a alloc.a substdio.a \
error.a str.a fs.a auto_qmail.o base64.o dns.lib tls.o ssl_timeoutio.o
	./compile qmail-remote.c
	./load qmail-remote control.o constmap.o timeoutread.o \
	timeoutwrite.o timeoutconn.o tcpto.o now.o dns.o ip.o \
	tls.o ssl_timeoutio.o -L/usr/local/ssl/lib -lssl -lcrypto \
	ipalloc.o ipme.o quote.o ndelay.a case.a sig.a open.a \
	lock.a seek.a getln.a stralloc.a alloc.a substdio.a error.a \
	str.a fs.a auto_qmail.o  base64.o `cat dns.lib`

qmail-rspawn: compile load qmail-rspawn.c spawn.o tcpto_clean.o now.o \
sig.a open.a seek.a lock.a wait.a fd.a stralloc.a alloc.a substdio.a error.a \
str.a auto_qmail.o auto_uids.o auto_spawn.o
	./compile qmail-rspawn.c
	./load qmail-rspawn spawn.o tcpto_clean.o now.o \
	sig.a open.a seek.a lock.a wait.a fd.a stralloc.a alloc.a \
	substdio.a error.a str.a auto_qmail.o auto_uids.o auto_spawn.o

qmail-send: compile load qmail-send.c qsutil.o control.o constmap.o newfield.o \
prioq.o trigger.o fmtqfn.o quote.o now.o readsubdir.o qmail.o date822fmt.o \
datetime.a case.a ndelay.a getln.a wait.a seek.a fd.a sig.a open.a lock.a \
stralloc.a alloc.a substdio.a error.a str.a fs.a auto_qmail.o auto_split.o env.a
	./compile qmail-send.c
	./load qmail-send qsutil.o control.o constmap.o newfield.o \
	prioq.o trigger.o fmtqfn.o quote.o now.o readsubdir.o \
	qmail.o date822fmt.o datetime.a case.a ndelay.a getln.a \
	wait.a seek.a fd.a sig.a open.a lock.a stralloc.a alloc.a \
	substdio.a error.a str.a fs.a auto_qmail.o auto_split.o env.a

qmail-shcfg: conf.tmp qmail-shcfg.sh warn-auto.sh
	@echo build $@
	@cat warn-auto.sh conf.tmp qmail-shcfg.sh > qmail-shcfg
	@chmod 0755 qmail-shcfg

qmail-spp.o: compile qmail-spp.c
	./compile qmail-spp.c

qmail-smtpd: compile load qmail-smtpd.c rcpthosts.o commands.o \
timeoutread.o timeoutwrite.o ip.o ipme.o ipalloc.o control.o constmap.o \
received.o date822fmt.o now.o qmail.o cdb.a fd.a wait.a datetime.a \
getln.a open.a sig.a case.a env.a stralloc.a alloc.a substdio.a \
error.a str.a fs.a auto_qmail.o base64.o qmail-spp.o \
tls.o ssl_timeoutio.o ndelay.a
	./compile qmail-smtpd.c
	./load qmail-smtpd rcpthosts.o commands.o timeoutread.o \
	timeoutwrite.o ip.o ipme.o ipalloc.o control.o constmap.o \
	tls.o ssl_timeoutio.o ndelay.a -L/usr/local/ssl/lib -lssl -lcrypto \
	received.o date822fmt.o now.o qmail.o cdb.a fd.a wait.a \
	datetime.a getln.a open.a sig.a case.a qmail-spp.o env.a stralloc.a \
	alloc.a substdio.a error.a str.a fs.a auto_qmail.o base64.o

qmail-start: compile load qmail-start.c prot.o fd.a auto_uids.o
	./compile qmail-start.c
	./load qmail-start prot.o fd.a auto_uids.o

qmail-tcpok: compile load qmail-tcpok.c open.a lock.a strerr.a \
substdio.a error.a str.a auto_qmail.o
	./compile qmail-tcpok.c
	./load qmail-tcpok open.a lock.a strerr.a substdio.a \
	error.a str.a auto_qmail.o 

qmail-tcpto: compile load qmail-tcpto.c ip.o now.o open.a lock.a \
substdio.a error.a str.a fs.a auto_qmail.o
	./compile qmail-tcpto.c
	./load qmail-tcpto ip.o now.o open.a lock.a substdio.a \
	error.a str.a fs.a auto_qmail.o 

#qmail-upq: \
#warn-auto.sh qmail-upq.sh conf-qmail conf-break conf-split
#	cat warn-auto.sh qmail-upq.sh \
#	| sed s}QMAIL}"`head -1 conf-qmail`"}g \
#	| sed s}BREAK}"`head -1 conf-break`"}g \
#	| sed s}SPLIT}"`head -1 conf-split`"}g \
#	> qmail-upq
#	chmod 755 qmail-upq

qmail.o: compile qmail.c
	./compile qmail.c

qreceipt: compile load qreceipt.c headerbody.o hfield.o quote.o \
token822.o qmail.o getln.a fd.a wait.a sig.a env.a stralloc.a \
alloc.a substdio.a error.a str.a auto_qmail.o
	./compile qreceipt.c
	./load qreceipt headerbody.o hfield.o quote.o token822.o \
	qmail.o getln.a fd.a wait.a sig.a env.a stralloc.a alloc.a \
	substdio.a error.a str.a auto_qmail.o 

qsmhook: compile load qsmhook.c sig.a case.a fd.a wait.a getopt.a \
env.a stralloc.a alloc.a substdio.a error.a str.a
	./compile qsmhook.c
	./load qsmhook sig.a case.a fd.a wait.a getopt.a env.a \
	stralloc.a alloc.a substdio.a error.a str.a 

qsutil.o: compile qsutil.c
	./compile qsutil.c

quote.o: compile quote.c
	./compile quote.c

rcpthosts.o: compile rcpthosts.c 
	./compile rcpthosts.c

readsubdir.o: compile readsubdir.c
	./compile readsubdir.c

received.o: compile received.c
	./compile received.c

remoteinfo.o: compile remoteinfo.c
	./compile remoteinfo.c

sendmail: compile load sendmail.c env.a getopt.a alloc.a \
substdio.a error.a str.a auto_qmail.o
	./compile sendmail.c
	./load sendmail env.a getopt.a alloc.a substdio.a \
	error.a str.a auto_qmail.o 

spawn.o: compile chkspawn spawn.c
	./chkspawn
	./compile spawn.c

splogger: compile load splogger.c substdio.a error.a str.a fs.a
	./compile splogger.c
	./load splogger substdio.a error.a str.a fs.a

#syslog.lib: \
#trysyslog.c compile load
#	( ( ./compile trysyslog.c && \
#	./load trysyslog -lgen ) >/dev/null 2>&1 \
#	&& echo -lgen || exit 0 ) > syslog.lib
#	rm -f trysyslog.o trysyslog

tcp-env: compile load tcp-env.c dns.o remoteinfo.o timeoutread.o \
timeoutwrite.o timeoutconn.o ip.o ipalloc.o case.a ndelay.a sig.a \
env.a getopt.a stralloc.a alloc.a substdio.a error.a str.a fs.a dns.lib
	./compile tcp-env.c
	./load tcp-env dns.o remoteinfo.o timeoutread.o \
	timeoutwrite.o timeoutconn.o ip.o ipalloc.o case.a ndelay.a \
	sig.a env.a getopt.a stralloc.a alloc.a substdio.a error.a \
	str.a fs.a `cat dns.lib`

tcpto.o: compile tcpto.c
	./compile tcpto.c

tcpto_clean.o: compile tcpto_clean.c
	./compile tcpto_clean.c

timeoutconn.o: compile timeoutconn.c
	./compile timeoutconn.c

timeoutread.o: compile timeoutread.c
	./compile timeoutread.c

timeoutwrite.o: compile timeoutwrite.c
	./compile timeoutwrite.c

tls.o: compile tls.c
	./compile tls.c

ssl_timeoutio.o: compile ssl_timeoutio.c
	./compile ssl_timeoutio.c

token822.o: compile token822.c
	./compile token822.c

trigger.o: compile trigger.c
	./compile trigger.c

triggerpull.o: compile triggerpull.c
	./compile triggerpull.c

#cert cert-req: Makefile-cert
#	@$(MAKE) -sf $< $@

#Makefile-cert: \
#conf-qmail conf-users conf-groups Makefile-cert.mk
#	@cat Makefile-cert.mk \
#	| sed s}QMAIL}"`head -1 conf-qmail`"}g \
#	> $@

#update_tmprsadh: \
#conf-qmail conf-users conf-groups update_tmprsadh.sh
#	@cat update_tmprsadh.sh\
#	| sed s}UGQMAILD}"`head -2 conf-users|tail -1`:`head -1 conf-groups`"}g \
#	| sed s}QMAIL}"`head -1 conf-qmail`"}g \
#	> $@
#	chmod 755 update_tmprsadh 

#tmprsadh: update_tmprsadh
#	echo "Creating new temporary RSA and DH parameters"
#	./update_tmprsadh

mkrsadhkeys: \
conf-qmail conf-users conf-groups mkrsadhkeys.sh warn-auto.sh
	@cat warn-auto.sh mkrsadhkeys.sh\
	| sed s}QMAIL}"`head -1 conf-qmail`"}g \
	| sed s}UID}"`head -2 conf-users | tail -1`"}g \
	| sed s}GID}"`head -1 conf-groups`"}g \
	> $@
	@echo creating $@
	@chmod 755 $@

mksrvrcerts: mksrvrcerts.sh conf-users conf-groups warn-auto.sh
	@cat warn-auto.sh mksrvrcerts.sh \
	| sed s}OPENSSLBIN}"`head -1 ssl.bin`"}g \
	| sed s}QMAIL}"`head -1 conf-qmail`"}g \
	| sed s}UID}"`head -2 conf-users | tail -1`"}g \
	| sed s}GID}"`head -1 conf-groups`"}g \
	> $@
	@echo creating $@
	@chmod 755 $@
