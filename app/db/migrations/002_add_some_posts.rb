Sequel.migration do
  up do
    Post.create(
      title: 'Что такое Lorem Ipsum?',
      content: 'Lorem Ipsum - это текст-"рыба"...'
    )
    Post.create(
      title: 'Почему он используется?',
      content: 'Давно выяснено, что при оценке дизайна...'
    )
    Post.create(
      title: 'Откуда он появился?',
      content: 'Многие думают, что Lorem Ipsum - взятый с потолка...'
    )
  end

  down do
  end
end

