" skip if filetype is sage.python
if match(&ft, '\v<sage>') != -1
    finish
endif

" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

if exists("g:cmdline_app")
    for key in keys(g:cmdline_app)
        if key == "python"
	    if match(g:cmdline_app["python"], "ipython") != -1
	        let b:cmdline_ipython = 1
	    elseif match(g:cmdline_app["python"], "jupyter") != -1
	        let b:cmdline_jupyter = 1
	    endif
        endif
    endfor
endif

function! PythonSourceLines(lines)
    if exists("b:cmdline_ipython")
        call VimCmdLineSendCmd("%cpaste -q")
        sleep 100m " Wait for IPython to read stdin
        call VimCmdLineSendCmd(join(add(a:lines, '--'), b:cmdline_nl))
    elseif exists("b:cmdline_jupyter")
	" Use bracketed paste
	let a:block = join(a:lines, b:cmdline_nl)
pythonx << endpython
# Allow inner blocks to be run without problem (cpaste-like)
import textwrap, json
block = vim.eval('a:block')
vim.command('let a:block = %s' % json.dumps(textwrap.dedent(block)))
endpython
	call VimCmdLineSendCmd("\e[200~")
        call VimCmdLineSendCmd(a:block)
        call VimCmdLineSendCmd("\e[201~")
	call VimCmdLineSendCmd(b:cmdline_nl)
    else
        let lns = ''
        let isdefclass = 0
        for aline in a:lines
            if isdefclass && aline =~ '^\S'
                let lns = lns . b:cmdline_nl
                let isdefclass = 0
            endif
            if aline !~ '^\s*$'
                if aline =~ '^def ' || aline =~ '^class '
                    let isdefclass = 1
                endif
                let lns = lns . b:cmdline_nl . aline
            endif
        endfor
        call VimCmdLineSendCmd(lns . b:cmdline_nl)
    endif
endfunction

function! PythonSendLine()
    let line = getline(".")
    let haselse = line =~ '^if ' || line =~ '^while '
    if line =~ '^class ' || line =~ '^def ' || line =~ '^while ' || line =~ '^if '
        let lines = []
        let idx = line('.')
        while idx <= line('$')
            if line !~ '^\s*$'
                let lines += [line]
            endif
            let idx += 1
            let line = getline(idx)
            if line =~ '^\S' && !(haselse && line =~ '^else:\s*$')
                break
            endif
        endwhile
        let lines += ['']
        call PythonSourceLines(lines)
        exe idx
        return
    endif
    if strlen(line) > 0 || b:cmdline_send_empty
        call VimCmdLineSendCmd(line)
    endif
    call VimCmdLineDown()
endfunction

if has("win32")
    let b:cmdline_nl = "\r\n"
else
    let b:cmdline_nl = "\n"
endif
if executable("python3")
    let b:cmdline_app = "python3"
else
    let b:cmdline_app = "python"
endif
let b:cmdline_quit_cmd = "quit()"
let b:cmdline_send = function('PythonSendLine')
let b:cmdline_source_fun = function("PythonSourceLines")
let b:cmdline_send_empty = 1
let b:cmdline_filetype = "python"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

call VimCmdLineSetApp("python")
