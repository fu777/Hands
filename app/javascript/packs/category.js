/*global $*/
$(document).on('turbolinks:load', function() {
    function appendOption(category){
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChildrenBox(insertHTML){
    var childSelectHtml = "";
    childSelectHtml = `<div class="category__child row field mb-3" id="children_wrapper">
                        <div class="offset-lg-3 offset-sm-3"><div>
                        <select id="child__category" name="item[category_id]" class="select_field">
                          <option value="">---</option>
                          //optionタグを埋め込む
                          ${insertHTML}
                        </select>
                      </div>`;
    $('.append__category').append(childSelectHtml);
  }
  $('#item_category_id').on('change',function(){
    var parentId = document.getElementById('item_category_id').value;
    if (parentId != ""){
      $.ajax({
        url: '/items/get_category_children/',
        type: 'GET',
        data: { parent_id: parentId },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
        if (insertHTML == "") {
          $('#children_wrapper').remove();
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
    }
  });
});