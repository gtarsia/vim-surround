source plugin/surround.vim
source t/util/util.vim

describe 'cs'

  before
    new
  end

  after
    close!
  end

  it 'changes surround'
    put! = '(world)'
    normal cs)]
    Expect getline(1) == "[world]"
  end
end
