source plugin/surround.vim
source t/util/util.vim

describe 'ds'

  before
    new
  end

  after
    close!
    call setreg('"', '')
  end

  it 'deletes surrounding single quotes'
    put! = \"\'world\'\"
    Expect getline(1) == "\'world\'"
    normal ds'
    Expect getline(1) == 'world'
  end

  it 'deletes surrounding double quotes'
    put! = '\"world\"'
    Expect getline(1) == '"world"'
    normal ds"
    Expect getline(1) == 'world'
  end

  it 'deletes surrounding backticks'
    put! = '`world`'
    Expect getline(1) == '`world`'
    normal ds`
    Expect getline(1) == 'world'
  end

  it 'deletes surrounding parenthesis'
    put! = '_( world )_'
    normal f(
    Expect CursorChar() == '('
    normal ds)
    Expect getline(1) == '_ world _'
  end

  it 'deletes surrounding parenthesis, trimming whitespaces'
    put! = '_( world )_'
    normal f(
    Expect CursorChar() == '('
    normal ds(
    Expect getline(1) == '_world_'
  end

  it 'deletes surrounding parenthesis (aliased)'
    put! = '_( world )_'
    normal f(
    Expect CursorChar() == '('
    normal dsb
    Expect getline(1) == '_ world _'
  end

  it 'deletes surrounding square brackets'
    put! = '_[ world ]_'
    normal f[
    Expect CursorChar() == '['
    normal ds]
    Expect getline(1) == '_ world _'
  end

  it 'deletes surrounding square brackets, trimming whitespaces'
    put! = '_[ world ]_'
    normal f[
    Expect CursorChar() == '['
    normal ds[
    Expect getline(1) == '_world_'
  end

  it 'deletes surrounding square brackets (aliased)'
    put! = '_[ world ]_'
    normal f[
    Expect CursorChar() == '['
    normal dsr
    Expect getline(1) == '_ world _'
  end

  it 'deletes surrounding curly brackets'
    put! = '_{ world }_'
    normal f{
    Expect CursorChar() == '{'
    normal ds}
    Expect getline(1) == '_ world _'
  end

  it 'deletes surrounding curly brackets, trimming whitespaces'
    put! = '_{ world }_'
    normal f{
    Expect CursorChar() == '{'
    normal ds{
    Expect getline(1) == '_world_'
  end

  it 'deletes surrounding curly brackets (aliased)'
    put! = '_{ world }_'
    normal f{
    Expect CursorChar() == '{'
    normal dsB
    Expect getline(1) == '_ world _'
  end

  it 'deletes surrounding angle brackets'
    put! = '_< world >_'
    normal f<
    Expect CursorChar() == '<'
    normal ds>
    Expect getline(1) == '_ world _'
  end

  it 'deletes surrounding angle brackets, trimming whitespaces'
    put! = '_< world >_'
    normal f<
    Expect CursorChar() == '<'
    normal ds<
    Expect getline(1) == '_world_'
  end

  it 'deletes surrounding angle brackets (aliased)'
    put! = '_< world >_'
    normal f<
    Expect CursorChar() == '<'
    normal dsa
    Expect getline(1) == '_ world _'
  end

  it 'deletes surrounding C comment'
    put! = '/* world */'
    normal fw
    normal ds/
    Expect getline(1) == 'world'
  end

  it 'deletes surrounding C comment (mutliline)'
    put = '/*'
    put = 'hello'
    put = 'world'
    put = '*/'
    Expect getline(2) == '/*'
    Expect getline(3) == 'hello'
    Expect getline(4) == 'world'
    Expect getline(5) == '*/'
    normal 3G
    normal ds/
    Expect getline(2) == ''
    Expect getline(3) == 'hello'
    Expect getline(4) == 'world'
    Expect getline(5) == ''
  end

  it 'deletes surrounding spaces, when cursor at the beginning of word'
    put! = 'hello world hello'
    normal fw
    Expect CursorChar() == 'w'
    execute "normal ds\<space>\<space>"
    Expect getline(1) == 'helloworldhello'
  end

  it 'deletes surrounding spaces, when cursor in the middle of word'
    put! = 'hello world hello'
    normal fr
    Expect CursorChar() == 'r'
    execute "normal ds\<space>\<space>"
    Expect getline(1) == 'helloworldhello'
  end

  it 'deletes surrounding spaces, when cursor in the very first space'
    put! = 'hello world good morning'
    " usually if cursor is on space, it's interpreted as a closing space
    " but if it's the very first space, it's interpreted as an opening space
    execute "normal f\<space>"
    Expect CursorChar() == ' '
    execute "normal ds\<space>\<space>"
    Expect getline(1) == 'helloworldgood morning'
  end

  it 'ignores non-surrounding input character (clean reg)'
    call setreg('"', "")
    put! = '(world)'
    normal ds]
    Expect getline(1) == '(world)'
  end

  it 'ignores non-surrounding input character (dirty reg)'
    call setreg('"', "something")
    put! = '(world)'
    normal ds]
    Expect getline(1) == '(world)'
  end

  it 'preserves unnamed register on success'
    call setreg('"', "something", "b")
    put! = '(world)'
    normal ds)
    Expect getline(1) == 'world'
    Expect getreg('"') == 'something'
    Expect getregtype('"') == "\x169"
  end

  it 'preserves unnamed register on failure'
    call setreg('"', "something", "b")
    put! = '(world)'
    normal ds]
    Expect getline(1) == '(world)'
    Expect getreg('"') == 'something'
    Expect getregtype('"') == "\x169"
  end

end
