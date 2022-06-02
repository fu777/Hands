/*global $*/
$(document).on('turbolinks:load', function() {
    //①セレクトボックスに必要なoptionタグを生成
    function appendOption(category){
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  //②子カテゴリー用のセレクトボックスを生成
  function appendChildrenBox(insertHTML){
    var childSelectHtml = "";
    childSelectHtml = `<div class="category__child" id="children_wrapper">
                        <select id="child__category" name="item[category_id]" class="select_field">
                          <option value="">---</option>
                          //optionタグを埋め込む
                          ${insertHTML}
                        </select>
                      </div>`;
    //ブラウザに非同期で子セレクトボックスを表示される
    $('.append__category').append(childSelectHtml);
  }
  //③孫カテゴリー用のセレクトボックスを生成
  // function appendGrandchildrenBox(insertHTML){
  //   var grandchildSelectHtml = "";
  //   grandchildSelectHtml = `<div class="category__child" id="grandchildren_wrapper">
  //                             <select id="grandchild__category" name="item[category_id]" class="select_field">
  //                               <option value="">---</option>
  //                               //optionタグを埋め込む
  //                               ${insertHTML}
  //                               </select>
  //                           </div>`;
  //   //ブラウザに非同期で孫セレクトボックスを表示される
  //   $('.append__category').append(grandchildSelectHtml);
  // }
  //親カテゴリー選択時に子カテゴリーのイベント発火
  $('#item_category_id').on('change',function(){
    //選択したカテゴリーのidを取得
    var parentId = document.getElementById('item_category_id').value;
    if (parentId != ""){
      //取得したidをコントローラへ渡し、子カテゴリーを取得
      $.ajax({
        url: '/items/get_category_children/',
        type: 'GET',
        data: { parent_id: parentId },
        dataType: 'json'
      })
      //親が変更された時に子孫を削除
      .done(function(children){
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        //forEachで子カテゴリーを展開
        children.forEach(function(child){
          //①と紐づいて取得した子のid,nameをoptionタグに埋め込む
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
        if (insertHTML == "") {
          $('#children_wrapper').remove();
        }
      })
      //ajax通信の失敗時にアラートを表示
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
      // $('#grandchildren_wrapper').remove();
    }
  });
  //子カテゴリーの選択時に孫カテゴリーのイベント発火
  // $('.append__category').on('change','#child__category',function(){
  //   var childId = document.getElementById('child__category').value;
  //   if(childId != ""){
  //     $.ajax({
  //       url: '/items/get_category_grandchildren/',
  //       type: 'GET',
  //       data: { child_id: childId },
  //       dataType: 'json'
  //     })
  //     //子が変更された時に孫を削除
  //     .done(function(grandchildren){
  //       $('#grandchildren_wrapper').remove();
  //       var insertHTML = '';
  //       grandchildren.forEach(function(grandchild){
  //         insertHTML += appendOption(grandchild);
  //       });
  //       appendGrandchildrenBox(insertHTML);
  //       if (insertHTML == "") {
  //         $('#grandchildren_wrapper').remove();
  //       }
  //     })
  //     .fail(function(){
  //       alert('カテゴリー取得に失敗しました');
  //     })
    // }else{
      // $('#grandchildren_wrapper').remove();
    // }
  // })
});