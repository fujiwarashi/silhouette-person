class Answer < ActiveHash::Base
  self.data = [
    { id: 1, name: '不正解' },
    { id: 2, name: '正解' },
  ]
end
