cd QMAIL
DIRS=`ls queue/mess/ | wc -l | xargs`

showHelp() {
#  echo
  echo "Usage: qmail-qstat [option [value]]"
  echo
  echo -e "  -h\t\tShow this help"
  echo -e "  -D <id>\tDelete message with id 'id' from queue"
  echo -e "  -i\t\tList ID's of all messages in queue"
  echo -e "  -l\t\tList all messages in queue"
  echo -e "  -L\t\tCount messages with local receipient"
  echo -e "  -m <id>\tShow message with id 'id'"
  echo -e "  -R\t\tCount messages with remote receipient"
#  echo -e "\t\t  l: clean up local queue"
#  echo -e "\t\t  r: clean up remote queue"
#  echo -e "\t\t  b: delete all messages from queue"
  echo
  exit 0
}

countBounces() {
  bouncefiles=`ls queue/bounce | wc -w | xargs`
  echo "           messages with bounces: "$bouncefiles
}
countLocal() {
  localfiles=`find queue/local/* -print | wc -w`
  echo " messages with local receipients: "`expr $localfiles - $DIRS`
}
countRemote() {
  remotefiles=`find queue/remote/* -print | wc -w`
  echo "messages with remote receipients: "`expr $remotefiles - $DIRS`
}
countTodo() {
  todofiles=`find queue/todo/* -print | wc -w`
  echo "  messages not pre-processed yet: "`expr $todofiles - $DIRS`
}
default() {
  echo -e "\nSummary:"
  messfiles=`find queue/mess/* -print | wc -w`
  echo "         total messages in queue: "`expr $messfiles - $DIRS`
  countLocal
  countRemote
  countTodo
  countBounces
  echo -e "\nDirectory split of the queue is $DIRS.\n"
}
listMessages() {
  [ "$QSUBDIR" ] || QSUBDIR="mess"
  [ "$N" ] && FARGS="-name $N"
  for M in $(find queue/$QSUBDIR/*/* $FARGS -print 2>/dev/null)
  do echo -e "\nMessage-Id: `basename $M`" ; cat $M ; done
}
listMsgIDs() {
  echo "ID's of messages in queue:"
  [ "$QSUBDIR" ] || QSUBDIR="mess"
  for ID in $(find queue/$QSUBDIR/*/* -print 2>/dev/null)
  do echo `basename "$ID"` ; done
}
deleteMessage() {
  [ "$QSUBDIR" ] || QSUBDIR="mess"
  [ "$N" ] && FARGS="-name $N"
  echo -n "deleting message "`basename "$N"`" ... "
  for M in $(find queue/*/*/* $FARGS -print 2>/dev/null)
  do
    Q=`echo $M | cut -d/ -f2`
#    echo "deleting "`basename $M`" from queue/$Q: "
    rm -f "$M"
  done
  if [ "$M" ] ; then
    echo "done" ; else echo "failed: no such message" ; fi
}

if [ ! $1 ] ; then default ; exit 0 ; fi
while getopts ":hliLRm:D:" o; do
    case "${o}" in
#        u) STARTUID=${OPTARG};;
#        g) STARTGID=${OPTARG};;
        L) QSUBDIR="local" ; listMessages ; echo ; countLocal ; echo ; exit;;
        R) QSUBDIR="remote" ; listMessages ; echo ; countRemote ; echo ; exit;;
        h) showHelp;;
        i) listMsgIDs;;
        l) listMessages ; default;;
        m) N=${OPTARG} ; listMessages ; echo;;
        D) N=${OPTARG} ; deleteMessage ;;
        *) echo "Invalid option!" ; showHelp;;
    esac
done ; shift $((OPTIND-1))

exit 0
