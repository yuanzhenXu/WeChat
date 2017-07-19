// For shared directory js like this, should be used on eveywhere, like: pc, wechat, mobile, admin...
function updateHospital(){
  // console.log('change');
  var $province = $('.city-group .city-select:first');
  var $city = $('.city-group .city-select:last');
  var $hospital = $('.hospital-select');

  if($hospital.length){
    var _hash = {};
    if($province.val() != '-1'){
      _hash.province_code = $province.val();
    }
    if($city.val() != '-1'){
      _hash.city_code = $city.val();
    }

    // console.log(_hash);

    $hospital.html('<option value="-1">所在医院</option>');

    if( $province.val() == '-1' && $city.val() == '-1') {
      console.log('请选择省市');
    } else {
      $.get( '/hospitals.json', _hash, function(data){
        $.each(data, function(index, value){
          $hospital.append($('<option/>').val(value['id']).text(value['name']));
        });
        $hospital.append($('<option/>').val('-2').text('其他'));
      });
    }
  }
}

$(function(){
  // 根据省市，调整医院
  // 注意：
  // 1. option 如为空白，请加上 value='-1'
  // 2. 医院需放在 .city-group 下，与 .city-select 同济
  $('body').on('change', '.city-select', function(){
    updateHospital();
    $('.hospital-select').change();
  });

  $('body').on('change', '.hospital-select', function(){
    var $input = $('.other-hospital-name-input')
    var hospital_id = parseInt($(this).val());
    if( $input.length ){
      if( hospital_id == -2 ){
        $input.removeClass('mui-hidden hidden');
      } else {
        $input.addClass('mui-hidden hidden');
      }
    }
  });

});