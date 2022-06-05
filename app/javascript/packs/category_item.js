/*global $*/
$(document).on('turbolinks:load', function () {
  // 子カテゴリーを表示した時のhtml
  function childBuild(children) {
    let child_category = `
                        <li class="category_child">
                          <a href="/items/${children.id}/item_search"><input class="child_btn" type="button" value="${children.name}" name= "${children.id}">
                          </a>
                        </li>
                        `;
    return child_category;
  }
  //孫カテゴリーを表示した時のhtml
  // function gcBuild(children) {
  //   let gc_category = `
  //                       <li class="category_grandchild">
  //                         #items/id/item_searchに
  //                         <a href="/items/${children.id}/item_search"><input class="gc_btn" type="button" value="${children.name}" name= "${children.id}">
  //                         </a>
  //                       </li>
  //                       `;
  //   return gc_category;
  // }

  // マウスホバー時に親カテゴリーを表示
  $('#categoBtn').hover(
    function (e) {
      e.preventDefault();                            //イベントに対するデフォルトの動作をキャンセル
      e.stopPropagation();                           //親要素に返るイベントの伝播をストップ
      timeOut = setTimeout(function () {
        $('#tree_menu').show();                      //500ms指定のidを表示
        $('.categoryTree').show();　　                  //500ms指定のclassを表示
      }, 500);
    },
    function () {
      clearTimeout(timeOut);
    }
  );

  // マウスホバー時に子カテゴリーを表示
  $('.parent_btn').hover(
    function () {
      $('.parent_btn').css('color', '');            //cssの適用を変更
      $('.parent_btn').css('background-color', '');
      let categoryParent = $(this).attr('name');    //要素（parent_btn）に紐づく属性(name)の値を取得
      timeParent = setTimeout(function () {
        $.ajax({
          url: '/items/menu_search',
          type: 'GET',
          data: {
            parent_id: categoryParent,
          },
          dataType: 'json',
        })
          .done(function (data) {
            // $('.categoryTree-grandchild').hide();  　//孫カテゴリーの表示を隠す
            $('.category_child').remove();        　　　//上で記述した子のhtmlを削除
            // $('.category_grandchild').remove();    //上で記述した孫のhtmlを削除
            $('.categoryTree-child').show();　　　　　　　　　　　　　　//子カテゴリーを表示
            data.forEach(function (child) {
              let child_html = childBuild(child);
              $('.categoryTree-child').append(child_html);  // html要素（子）を動的に追加
            });
            $('#tree_menu').css('max-height', '490px');
          })
          .fail(function () {
            alert('カテゴリーを選択してください');
          });
      }, 400);
    },
    function () {
      clearTimeout(timeParent);
    }
  );

  // 孫カテゴリーを表示
  // $(document).on(
    // {
      // mouseenter: function () {                      //マウスが対象の要素の上に重なった時にイベント発火
        // $('.child_btn').css('color', ''); 
        // $('.child_btn').css('background-color', '');
        // let categoryChild = $(this).attr('name');   //要素（child_btn）に紐づく属性(name)の値を取得
        // timeChild = setTimeout(function () {
        //   $.ajax({
        //     url: '/items/menu_search',
        //     type: 'GET',
        //     data: {
        //       children_id: categoryChild,
        //     },
        //     dataType: 'json',
        //   })
        //     .done(function (gc_data) {
        //       $('.category_grandchild').remove();   //上記に記述した孫のhtmlを削除
        //       $('.categoryTree-grandchild').show(); //孫カテゴリーを表示
        //       gc_data.forEach(function (gc) {
        //         let gc_html = gcBuild(gc);
        //         $('.categoryTree-grandchild').append(gc_html);  // html要素（孫）を動的に追加
        //         let parcol = $('.categoryTree').find(`input[name="${gc.root}"]`);  //classに含まれるinputに紐づいた孫のルートidを取得
        //         $(parcol).css('color', 'white');
        //         $(parcol).css('background-color', '#b1e9eb');
        //       });
        //       $('#tree_menu').css('max-height', '490px');
        //     })
        //     .fail(function () {
        //       alert('カテゴリーを選択してください');
        //     });
        // }, 400);
      // },
  //     mouseleave: function () {  //マウスが対象の要素の上から外れた時にイベント発火
  //       clearTimeout(timeChild);
  //     },
  //   },
  //   '.child_btn'
  // );

  // 孫カテゴリーを選択時
  // $(document).on(
  //   {
  //     mouseenter: function () {                  //マウスが対象の要素の上に重なった時にイベント発火
  //       let categoryGc = $(this).attr('name');   //要素（document）に紐づく属性(name)の値を取得
  //       timeGc = setTimeout(function () {
  //         $.ajax({
  //           url: '/items/menu_search',
  //           type: 'GET',
  //           data: {
  //             gcchildren_id: categoryGc,
  //           },
  //           dataType: 'json',
  //         })
  //           .done(function (gc_result) {
  //             let childcol = $('.categoryTree-child').find(`input[name="${gc_result[0].parent}"]`);
  //             $(childcol).css('color', 'white');
  //             $(childcol).css('background-color', '#b1e9eb');
  //             $('#tree_menu').css('max-height', '490px');
  //           })
  //           .fail(function () {
  //             alert('カテゴリーを選択してください');
  //           });
  //       }, 400);
  //     },
  //     mouseleave: function () {    //マウスが対象の要素の上から外れた時にイベント発火
  //       clearTimeout(timeGc);
  //     },
  //   },
  //   '.gc_btn'
  // );

  // カテゴリー一覧ページのボタン
  $('#all_btn').hover(
    function (e) {
      e.preventDefault();                       //イベントに対するデフォルトの動作をキャンセル
      e.stopPropagation();                      //親要素に返るイベントの伝播をストップ
      // $('.categoryTree-grandchild').hide();
      $('.categoryTree-child').hide();
      // $('.category_grandchild').remove();
      $('.category_child').remove();
    },
    function () {
      // 何も記述しない
    }
  );

  // カテゴリーを非表示
  $(document).on(
    {
      mouseleave: function (e) {
        e.stopPropagation();                           //親要素に返るイベントの伝播をストップ
        e.preventDefault();                            //イベントに対するデフォルトの動作をキャンセル
        timeChosed = setTimeout(function () {
          // $('.categoryTree-grandchild').hide();
          $('.categoryTree-child').hide();
          $('.categoryTree').hide();
          $(this).hide();
          $('.parent_btn').css('color', '');
          $('.parent_btn').css('background-color', '');
          $('.category_child').remove();
          // $('.category_grandchild').remove();
        }, 800);
      },
      mouseenter: function () {          //マウスが対象の要素の上に重なった時の処理
        clearTimeout(timeChosed);
      },
    },
    '#tree_menu'
  );

  // カテゴリーボタンの処理
  $(document).on(
    {
      mouseenter: function (e) {               //マウスが対象の要素の上に重なった時の
        e.stopPropagation();                   //親要素に返るイベントの伝播をストップ
        e.preventDefault();                    //イベントに対するデフォルトの動作をキャンセル
        timeOpened = setTimeout(function () {
          $('#tree_menu').show();
          $('.categoryTree').show();
        }, 500);
      },
      mouseleave: function (e) {               //マウスが対象の要素の上から外れた時にイベント発火
        e.stopPropagation();
        e.preventDefault();
        clearTimeout(timeOpened);
        // $('.categoryTree-grandchild').hide();
        $('.categoryTree-child').hide();
        $('.categoryTree').hide();
        $('#tree_menu').hide();
        $('.category_child').remove();
        // $('.category_grandchild').remove();
      },
    },
    '.header__headerInner__nav__listsLeft__item'
  );
});
