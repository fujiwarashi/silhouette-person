$(window).on('load scroll', function (){

  const box = $('.fadeIn');
  const animated = 'animated';
  
  box.each(function(){
  
    const boxOffset = $(this).offset().top;
    const scrollPos = $(window).scrollTop();
    const wh = $(window).height();

    //画面内のどの位置で処理を実行するかで「100」の値を変更
    if(scrollPos > boxOffset - wh + 10 ){
      $(this).addClass(animated);
    }
  });

});
