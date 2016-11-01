#!/bin/bash

sudo bash -c 'cat > /usr/local/bin/check <<\EOF
#!/bin/bash
cmd=$1
eval cmd_res=\`${cmd}\`
regex=$2
match=$3
regex_ok=false
if [[ $cmd_res =~ $regex ]] ; then
regex_ok=true
fi
if  $regex_ok && ! $match ; then
  printf "Wrong command output\nCommand: \"$cmd\"\nOutput must NOT match: \"$regex\"\nActual output: \"$cmd_res\"\n"
fi
if  ! $regex_ok && $match ; then
  printf "Wrong command output\nCommand: \"$cmd\"\nOutput must match: \"$regex\"\nActual output: \"$cmd_res\"\n"
fi
EOF'
sudo chmod +x /usr/local/bin/check
