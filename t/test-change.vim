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

  it 'aborts if you press <esc> when selecting current char'
    put! = '(world)'
    normal fl
    execute "normal cs\<esc>i_\<esc>"
    Expect getline(1) == "(wor_ld)"
  end

  it 'aborts if you press <c-c> when selecting current char'
    put! = '(world)'
    normal fl
    execute "normal cs\<c-c>i_\<esc>"
    Expect getline(1) == "(wor_ld)"
  end

  it 'aborts if you press <esc> when selecting new char'
    put! = '(world)'
    normal fl
    execute "normal cs)\<esc>"
    execute "normal i_\<esc>"
    Expect getline(1) == "(wor_ld)"
  end

  it 'aborts if you press <c-c> when selecting new char'
    put! = '(world)'
    normal fl
    execute "normal cs)\<c-c>"
    execute "normal i_\<esc>"
    Expect getline(1) == "(wor_ld)"
  end

end
