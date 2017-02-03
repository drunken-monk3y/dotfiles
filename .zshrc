# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'




#ALIASES

##overload SUDO
alias sudo='sudo -E'

####overload su
alias su='su -p'

#edit zshrc
editmyzsh() {
    vim ~/.zshrc
}

#edit the local ZSH file
#calls editmyzsh
alias zshedit=editmyzsh

myClearYouDidItWrong() {
    clear
    echo i see what you did there... you did it wrong but ok
    }

alias cleaer=myClearYouDidItWrong

#listing aliases
alias ls='ls --color=always -lgGh'
alias ll='find . -mindepth 2 -maxdepth 2 -exec ls -lh "{}" \;'
alias la='ls --color=always -lagGh'


#to mount nas to /home/pi/NAS
#alias pasNas1='sudo mount -t cifs -o username=is //192.168.1.2/Volume_1 /home/pi/NAS/N1V1'
#alias pasNas2='sudo mount -t cifs -o username=is //192.168.1.2/Volume_2 /home/pi/NAS/N1V2'

#new aliases for script! onlz works with ssh -X
#alias pasnas1='pasNas1.bash'
#alias pasnas2='pasNas2.bash'

alias pasnas1="sudo mount -t cifs -o username=55555,password=55555 //192.168.1.2/Volume_1 ~/NAS/vol1"
alias pasnas2="sudo mount -t cifs -o username=55555,password=55555 //192.168.1.2/Volume_2 ~/NAS/vol2"


# if nothing then turn off all displays and set eDP1 to 1360x...
# if present then set eDP1 to auto and VGA to --left off
# if home    then set eDPI main ++HDMI1 ++DP1
setMyDisplay() {
    case $1 in
    "present"*)
        echo "do present"
        xrandr --output eDP1 --mode 1360x768 --primary && xrandr --output DP1 --auto --right-of eDP1 && xrandr --output HDMI1 --off
        ;;
    "home"*)
        echo "go home"
        xrandr --output eDP1 --mode 1360x768 --primary && xrandr --output HDMI1 --auto --right-of eDP1 && xrandr --output DP1 --auto --right-of HDMI1
        ;;
    "help"*)
        echo "usage: no flag for laptop only, present for VGA-right-of, home for Laptop>HDMI>VGA"
        ;;
    *)
        echo "standart"
        xrandr --output eDP1 --mode 1360x768 --primary && xrandr --output HDMI1 --off && xrandr --output DP1 --off
        ;;
    esac
nitrogen --restore
}

alias laptopDisplaySetUp=setMyDisplay



#automaticly connect ssh with X session option
alias video-ssh='ssh -X'

#compile aliases
alias compile-latex='pdflatex'

#VPN options
#alias fast-uni-vpn='sudo openvpn --config ~/openvpn/uni/imp-pub.ovpn --ca ~/openvpn/uni/cachain.crt --tls-auth ~/openvpn/uni/ta.key --auth-user-pass ~/openvpn/uni/login.conf'

startmyvpn() {
    case $1 in
    "uni"*)
        case $2 in
           "pub"*)
            echo "uni public"
            sudo openvpn --cd /home/chris/openvpn/uni --config /home/chris/openvpn/uni/imp-pub.ovpn
            ;;
            "ext"*)
            echo "uni extern"
            sudo openvpn --cd /home/chris/openvpn/uni --config /home/chris/openvpn/uni/imp-ext.ovpn
            ;;
            *) echo "either pub or ext"
            ;;
        esac
        ;;
    "rauz"*)
        echo "rauz"
        sudo openvpn --cd /home/chris/openvpn/rauz --config /home/chris/openvpn/rauz/client.conf
        ;;
    "csec"*)
        echo "csec"
        sudo openvpn --cd /home/chris/openvpn/csec --config /home/chris/openvpn/csec/imp-CloudSecVPN.ovpn
        ;;
    *)
        echo "1 uni then 2 ext/pub, 1 rauz, 1 csec"
        ;;
    esac
}

alias myvpn=startmyvpn

#####################
# puts the laptop into hibernate mode
sleepAndLock() {
    systemctl suspend
    i3lock -c 000000
}

alias gotosleep=sleepAndLock

###################
#netflix shutdown
alias netflix='sudo shutdown -h 90'

####################
#mensaplan
alias mensa='perl /usr/local/bin/mensa_plan_perl'

####################
#update short
alias dateMeUp='sudo apt-get update'

########################
#upgrade short
alias gradeMeUp='sudo apt-get upgrade'

#####################
#changes the keyboardlayout to 
#us international with en and to
#german with de
cycleLanguage() {
##case something us en de ger
    case $1 in
    "en"*)
    echo "blafu"
    ;;
    "us"*)
    echo "blafu"
    ;;
    "de"*)
    echo "blafu"
    ;;
    "ger"*)
    echo "blafu"
    ;;
    *)
    echo "404 option not found! try ger/de or en/us!"
    ;;
    esac
}


alias change-language='mykeyboard.bash'
#alias change-language=cycleLanguage

#####
#overwrite mplayer to mplayer with ao alsa
alias mplayer='mplayer -ao alsa -msgcolor -msgmodule -nomouseinput -nolirc'

####
# moving files from this folder to dlc folder in either:
# Videos, Dokumente, Bilder or Musik
moveMyShit() {
    case $1 in
    "vid"*)
        echo "moving Videos with known extensions to ~/Videos/dlc"
	find . -name '*.mkv' -exec mv -t ~/Videos/dlc/ {} +
	find . -name '*.avi' -exec mv -t ~/Videos/dlc/ {} +
	find . -name '*.mp4' -exec mv -t ~/Videos/dlc/ {} +
    ;;
    "pic"*)
        echo "moving Pictures with known extensions to ~/Bilder/dlc"
	find . -name '*.jpg' -exec mv -t ~/Videos/dlc/ {} +
	find . -name '*.jpeg' -exec mv -t ~/Videos/dlc/ {} +
	find . -name '*.png' -exec mv -t ~/Videos/dlc/ {} +
	find . -name '*.gif' -exec mv -t ~/Videos/dlc/ {} +
    ;;
    "mp3"*)
        echo "moving Audio with known extensions to ~/Musik/dlc"
	find . -name '*.mp3' -exec mv -t ~/Videos/dlc/ {} +
	find . -name '*.wav' -exec mv -t ~/Videos/dlc/ {} +
    ;;
    "doc"*)
        echo "movin Documents with known extensions to ~/Dokumente/dlc"
	find . -name '*.pdf' -exec mv -t ~/Videos/dlc/ {} +
	find . -name '*.doc' -exec mv -t ~/Videos/dlc/ {} +
	find . -name '*.docx' -exec mv -t ~/Videos/dlc/ {} +
	find . -name '*.txt' -exec mv -t ~/Videos/dlc/ {} +
    ;;
    *)
        echo "usage vid, pic, mp3, doc"
    ;;
    esac
}

alias dlc=moveMyShit

#######
# alias to filter unseen movies
alias unseen='ls [_][a-zA-Z]*'

#######
# make a file that is unseen to seen // remove the underscore um front
#############################

#alias to shut down now
alias fuckoff='sudo shutdown -h now'

#alias for rsync copy
alias copysync='rsync -a --info=progress2 $1 $2'



##### attack VM with SYN CSEC
alias attackCsec='sudo hping3 -c 200 --faster -S -p 80 192.168.12.24'
