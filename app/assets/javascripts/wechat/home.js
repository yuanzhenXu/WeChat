/**
 * Created by xuyuanzhen on 2017/7/13.
 */
$(document).ready(function(){
    if ($('body').attr('id') == 'home_index'){
        addActiveNav($('#nav_item_cart'));
    }

    var home_swiper = new Swiper('#home_banner', {
        centeredSlides: true,
        autoplay: 5000,
        autoplayDisableOnInteraction: false
    });

    $('#new_user_alert').on('click', '.close-btn, .cover', function(){
        $('#new_user_alert').hide();
    });
});
