source plugin/surround.vim
source t/util/util.vim

describe 'ys'

  before
    new
  end

  after
    close!
  end

  it 'surrounds with single quotes'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiw'
    Expect getline(1) == "'world'"
  end

  it 'surrounds with double quotes'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiw"
    Expect getline(1) == '"world"'
  end

  it 'surronds with backticks'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiw`
    Expect getline(1) == '`world`'
  end

  it 'surrounds with parenthesis'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiw)
    Expect getline(1) == '(world)'
  end

  it 'surrounds with parenthesis and extra spaces'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiw(
    Expect getline(1) == '( world )'
  end

  it 'surrounds with parenthesis (aliased)'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiwb
    Expect getline(1) == '(world)'
  end

  it 'surrounds with square brackets'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiw]
    Expect getline(1) == '[world]'
  end

  it 'surrounds with square brackets and extra spaces'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiw[
    Expect getline(1) == '[ world ]'
  end

  it 'surrounds with square brackets (aliased)'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiwr
    Expect getline(1) == '[world]'
  end

  it 'surrounds with curly brackets'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiw}
    Expect getline(1) == '{world}'
  end

  it 'surrounds with curly brackets and extra spaces'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiw{
    Expect getline(1) == '{ world }'
  end

  it 'surrounds with curly brackets (aliased)'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiwB
    Expect getline(1) == '{world}'
  end

  it 'surrounds with angle brackets'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiw>
    Expect getline(1) == '<world>'
  end

  it 'surrounds with angle brackets and extra spaces'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiw<
    Expect getline(1) == '< world >'
  end

  it 'surrounds with angle brackets (aliased)'
    put! = 'world'
    Expect getline(1) == 'world'
    normal ysiwa
    Expect getline(1) == '<world>'
  end

  it 'surrounds with spaces'
    put! = 'world'
    Expect getline(1) == 'world'
    execute "normal ysiw\<space>\<space>"
    Expect getline(1) == ' world '
  end

  it 'surrounds with character and extra spaces'
    put! = 'world'
    Expect getline(1) == 'world'
    execute "normal ysiw\<space>_"
    Expect getline(1) == '_ world _'
  end

  it 'surrounds as paragraph'
    put! = 'world'
    Expect getline(1) == 'world'
    execute "normal ysiwp"
    Expect getline(1) == ''
    Expect getline(2) == 'world'
    Expect getline(3) == ''
    Expect getline(4) == ''
    normal G
    Expect line(".") == 5
  end

  it 'surrounds with function call'
    put! = '2, 3, 5'
    Expect getline(1) == '2, 3, 5'
    execute "normal ys$faverage\<cr>"
    Expect getline(1) == 'average(2, 3, 5)'
  end

  it 'surrounds with function call and extra spaces'
    put! = '2, 3, 5'
    Expect getline(1) == '2, 3, 5'
    execute "normal ys$Faverage\<cr>"
    Expect getline(1) == 'average( 2, 3, 5 )'
  end

  it 'surrounds with function call, removing trailing parenthesis'
    put! = '2, 3, 5'
    Expect getline(1) == '2, 3, 5'
    execute "normal ys$faverage(\<cr>"
    Expect getline(1) == 'average(2, 3, 5)'
  end

  it 'does not surround with empty function call'
    put! = '2, 3, 5'
    Expect getline(1) == '2, 3, 5'
    execute "normal ys$F\<cr>"
    Expect getline(1) == '2, 3, 5'
  end

  it "surrounds latex ('l' mapping)"
    put! = 'world'
    Expect getline(1) == 'world'
    execute "normal ysiwlcenter\<cr>"
    Expect getline(1) == '\begin{center}world\end{center}'
  end

  it 'surrounds latex (\ mapping)'
    put! = 'world'
    Expect getline(1) == 'world'
    execute 'normal ysiw\' . "center\<cr>"
    Expect getline(1) == '\begin{center}world\end{center}'
  end

  it 'does not surround empty latex'
    put! = 'world'
    Expect getline(1) == 'world'
    execute "normal ysiwl\<cr>"
    Expect getline(1) == 'world'
  end

  it 'adds leading space'
    put! = 'world'
    Expect getline(1) == 'world'
    execute "normal ysiws"
    Expect getline(1) == ' world'
  end

  it 'adds leading colon'
    put! = 'world'
    Expect getline(1) == 'world'
    execute "normal ysiw:"
    Expect getline(1) == ':world'
  end

  it "ignores alphabetic chars that don't have special semantics"
    put! = 'world'
    Expect getline(1) == 'world'
    execute "normal ysiwk"
    Expect getline(1) == 'world'
  end

  it 'surrounds cursor with curly braces in insert mode'
    put! = 'world'
    Expect getline(1) == 'world'
    normal fl
    Expect CursorChar() == 'l'
    execute "normal i\<C-G>s\<C-]>hello\<esc>"
    Expect getline(1) == "wor{"
    Expect getline(2) == "\thello"
    Expect getline(3) == "}ld"
  end

  it 'surrounds with buffer custom template'
    put! = 'world'
    Expect getline(1) == 'world'
    " buffer custom template for '-' (ASCII 45)
    let b:surround_45 = "<?php \r ?>"
    execute 'normal ysiw-'
    Expect getline(1) == '<?php world ?>'
  end

  it 'surrounds with global custom template'
    put! = 'world'
    Expect getline(1) == 'world'
    " global custom template for '-' (ASCII 45)
    let g:surround_45 = "<?php \r ?>"
    execute 'normal ysiw-'
    Expect getline(1) == '<?php world ?>'
  end

  it 'overrides global template with buffer template'
    put! = 'world'
    Expect getline(1) == 'world'
    " global custom template for '-' (ASCII 45)
    let g:surround_45 = "<?php \r ?>"
    " buffer custom template for '-' (ASCII 45)
    let b:surround_45 = "<?perl \r ?>"
    execute 'normal ysiw-'
    Expect getline(1) == '<?perl world ?>'
  end

  it 'overrides default surround with buffer custom template'
    put! = 'world'
    Expect getline(1) == 'world'
    " buffer custom template for ')' (ASCII 41)
    let b:surround_41 = "<?php \r ?>"
    execute 'normal ysiw)'
    Expect getline(1) == '<?php world ?>'
  end

  it 'surrounds with lisp function call'
    put! = '2 3 5'
    Expect getline(1) == '2 3 5'
    execute "normal ys$\<C-F>average\<cr>"
    Expect getline(1) == '(average 2 3 5)'
  end

end
