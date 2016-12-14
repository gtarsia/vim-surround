source plugin/surround.vim

function! CursorChar()
    return getline('.')[col('.')-1]
endfunction

describe 'delete surround'

  before
    new
  end

  after
    close!
  end

  it 'deletes surrounding double quotes'
    put! = '\"world\"'
    Expect getline(1) == '"world"'
    normal ds"
    Expect getline(1) == 'world'
  end

  it 'deletes surrounding parenthesis'
    put! = '_( world )_'
    normal f(
    Expect CursorChar() == '('
    normal ds)
    Expect getline(1) == '_ world _'
  end

  it 'deletes surrounding square brackets'
    put! = '_[ world ]_'
    normal f[
    Expect CursorChar() == '['
    normal ds]
    Expect getline(1) == '_ world _'
  end

  it 'deletes surrounding curly brackets'
    put! = '_{ world }_'
    normal f{
    Expect CursorChar() == '{'
    normal ds}
    Expect getline(1) == '_ world _'
  end

  it 'deletes surrounding angle brackets'
    put! = '_< world >_'
    normal f<
    Expect CursorChar() == '<'
    normal ds>
    Expect getline(1) == '_ world _'
  end

end
