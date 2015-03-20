"Vim ems to pixels

" A global variable that allows a user to change their default base font-size.
if !exists('g:px_to_em_base')
  let g:px_to_em_base = 16
endif

" Converts Selected pixels to ems vice versa.
" - convert_to: 'px' or 'em'
" - skipconfirmation: If skipconfirmation is set to 1, then the user will not
"   be promted at each change.
" - start_line: The first line to search.
" - end_line: The last line to search
function! VimPxEmConvert(convert_to, skip_confirmation, start_line, end_line)

  " If the skip confirmation value is set to 1, then don't prompt the user at
  " each change.
  if a:skip_confirmation
    let modifiers= "g"
  else
    let modifiers= "gc"
  endif

  " Self explanitory
  if a:convert_to == "px"
    let search_for = '\v(\d+.\d+)em'
    let replace_with = printf("%.0fpx", round(g:px_to_em_base*str2float(submatch(1))))
  elseif a:convert_to == "em"
    let search_for = '\v(\d+)px'
    let replace_with = printf("%0.3fem", 1.0/g:px_to_em_base*submatch(1))
  endif
  
  " Execute the command
  execute a:start_line . "," . a:end_line ."s/". search_for . "/" . replace_with . "/" . modifiers
endfunction

"Available commands
command! -range -bang Em call VimPxEmConvert("em",<bang>0,<line1>,<line2>)
command! -range -bang Px call VimPxEmConvert("px", <bang>0,<line1>,<line2>)
command! -range=% -bang EmAll call VimPxEmConvert("em",<bang>0,<line1>,<line2>)
command! -range=% -bang PxAll call VimPxEmConvert("px", <bang>0,<line1>,<line2>)
