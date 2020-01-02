if g:dein#_cache_version !=# 150 || g:dein#_init_runtimepath !=# '/Users/ayato/.vim/bundles/repos/github.com/Shougo/dein.vim/,/Users/ayato/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim82,/usr/local/share/vim/vimfiles/after,/Users/ayato/.vim/after' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/ayato/.vimrc', '/Users/ayato/.vim/dein.toml', '/Users/ayato/.vim/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/ayato/.vim/bundles'
let g:dein#_runtime_path = '/Users/ayato/.vim/bundles/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/ayato/.vim/bundles/.cache/.vimrc'
let &runtimepath = '/Users/ayato/.vim/bundles/repos/github.com/Shougo/dein.vim/,/Users/ayato/.vim,/usr/local/share/vim/vimfiles,/Users/ayato/.vim/bundles/repos/github.com/Shougo/dein.vim,/Users/ayato/.vim/bundles/.cache/.vimrc/.dein,/usr/local/share/vim/vim82,/Users/ayato/.vim/bundles/.cache/.vimrc/.dein/after,/usr/local/share/vim/vimfiles/after,/Users/ayato/.vim/after'
    call lexima#add_rule({'char': '<CR>', 'at': '"\%#"', 'input': '<CR><TAB>', 'input_after': '<CR>'})
    call lexima#add_rule({'char': '<CR>', 'at': '''\%#''', 'input': '<CR><TAB>', 'input_after': '<CR>'})
    let g:ale_lint_on_text_changed = 0
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_auto_colors=0
    augroup indent_guides_autocmd
        autocmd!
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=8
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=238
    augroup END
let g:syntastic_check_on_open=0 "ファイルを開いたときはチェックしない
let g:syntastic_check_on_save=1 "保存時にはチェック
let g:syntastic_check_on_wq = 0 " wqではチェックしない
let g:syntastic_auto_loc_list=1 "エラーがあったら自動でロケーションリストを開く
let g:syntastic_loc_list_height=6 "エラー表示ウィンドウの高さ
let g:syntastic_javascript_checkers = ['eslint'] "ESLintを使う
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['javascript'], 'passive_filetypes': [] }
    let g:WebDevIconsUnicodeDecorateFolderNodes = 1
    let g:DevIconsEnableFoldersOpenClose = 1
    let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
    let g:DevIconsDefaultFolderOpenSymbol = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['txt'] = ''
    set hidden  " allow buffer switching without saving
    set showtabline=2  " always show tabline
    let g:lightline = { 'colorscheme': 'wombat', 'mode_map': {'c': 'NORMAL'}, 'active': {   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ] }, 'component_function': {   'modified': 'LightlineModified',   'readonly': 'LightlineReadonly',   'fugitive': 'LightlineFugitive',   'filename': 'LightlineFilename',   'fileformat': 'LightlineFileformat',   'filetype': 'LightlineFiletype',   'fileencoding': 'LightlineFileencoding',   'mode': 'LightlineMode' } }
    function! LightlineModified()
      return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction
    function! LightlineReadonly()
      return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
    endfunction
    function! LightlineFilename()
      return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') . (&ft == 'vimfiler' ? vimfiler#get_status_string() :  &ft == 'unite' ? unite#get_status_string() :  &ft == 'vimshell' ? vimshell#get_status_string() : '' != expand('%:t') ? expand('%:t') : '[No Name]') . ('' != LightlineModified() ? ' ' . LightlineModified() : '')
    endfunction
    function! LightlineFugitive()
      if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        return fugitive#head()
      else
        return ''
      endif
    endfunction
    function! LightlineFileformat()
      return winwidth(0) > 70 ? &fileformat : ''
    endfunction
    function! LightlineFiletype()
      return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
    endfunction
    function! LightlineFileencoding()
      return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
    endfunction
    function! LightlineMode()
      return winwidth(0) > 60 ? lightline#mode() : ''
    endfunction
    let g:NERDTreeLimitedSyntax = 1
    let g:NERDTreeDirArrows = 1
    highlight! link NERDTreeFlags NERDTreeDir
    let s:rspec_red = 'FE405F'
    let s:git_orange = 'F54D27'
    let s:lightPurple = "834F79"
    let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
    let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
    let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
    let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb
    let g:cheatsheet#cheat_file = $HOME . '/.vim/cheatsheet'
    let g:cheatsheet#vsplit = 1
