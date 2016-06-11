__prompt_print_path () {
	local path="$@"
	local home="$HOME"
	path=$(echo ${path} | sed "s|^${home}|~|")
	echo -n "${path}"
}

__prompt_left() {
	local pos=$("${__prompt_path}/get-cursor-col")
	echo $(( __prompt_width - pos ))
}
