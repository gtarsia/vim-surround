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

end
