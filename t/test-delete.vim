source plugin/surround.vim

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

end
