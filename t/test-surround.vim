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

  it 'surrounds with character and extra spaces'
    put! = 'world'
    Expect getline(1) == 'world'
    execute "normal ysiw\<space>_"
    Expect getline(1) == '_ world _'
  end

end
