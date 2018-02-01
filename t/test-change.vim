source plugin/surround.vim
source t/util/util.vim

describe 'cs'

  before
    new
    set clipboard=
    set selection=inclusive
    call setreg('"', '')
  end

  after
    close!
  end

  it 'changes surround'
    put! = '(world)'
    normal cs)]
    Expect getline(1) == "[world]"
  end

  it 'allows a count to reach an outer target (count=1, before char)'
    put! = '(_(_(world)_)_)'
    normal fw
    normal cs1)]
    Expect getline(1) == '(_(_[world]_)_)'
  end

  it 'allows a count to reach an outer target (count=2, before char)'
    put! = '(_(_(world)_)_)'
    normal fw
    normal cs2)]
    Expect getline(1) == '(_[_(world)_]_)'
  end

  it 'allows a count to reach an outer target (count=2, before cs)'
    put! = '(_(_(world)_)_)'
    normal fw
    normal 2cs)]
    Expect getline(1) == '(_[_(world)_]_)'
  end

  it 'allows a count to reach an outer target (combined counts)'
    put! = '(_(_(_(_(_(world)_)_)_)_)_)'
    normal fw
    normal 3cs2)]
    Expect getline(1) == '[_(_(_(_(_(world)_)_)_)_)_]'
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
