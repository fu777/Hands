/*global $*/
$(document).on('turbolinks:load', function () {
  function childBuild(children) {
    let child_category = `
                        <li class="category_child">
                          <a href="/items/${children.id}/item_search"><input class="child_btn" type="button" value="${children.name}" name= "${children.id}">
                          </a>
                        </li>
                        `;
    return child_category;
  }

  $('#categoBtn').hover(
    function (e) {
      e.preventDefault();
      e.stopPropagation();
      timeOut = setTimeout(function () {
        $('#tree_menu').show();
        $('.categoryTree').show();
      }, 500);
    },
    function () {
      clearTimeout(timeOut);
    }
  );

  $('.parent_btn').hover(
    function () {
      $('.parent_btn').css('color', '');
      $('.parent_btn').css('background-color', '');
      let categoryParent = $(this).attr('name');
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
            $('.category_child').remove();
            $('.categoryTree-child').show();
            data.forEach(function (child) {
              let child_html = childBuild(child);
              $('.categoryTree-child').append(child_html);
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

  $('#all_btn').hover(
    function (e) {
      e.preventDefault();
      e.stopPropagation();
      $('.categoryTree-child').hide();
      $('.category_child').remove();
    },
    function () {
    }
  );

  $(document).on(
    {
      mouseleave: function (e) {
        e.stopPropagation();
        e.preventDefault();
        timeChosed = setTimeout(function () {
          $('.categoryTree-child').hide();
          $('.categoryTree').hide();
          $(this).hide();
          $('.parent_btn').css('color', '');
          $('.parent_btn').css('background-color', '');
          $('.category_child').remove();
        }, 800);
      },
      mouseenter: function () {
        clearTimeout(timeChosed);
      },
    },
    '#tree_menu'
  );

  $(document).on(
    {
      mouseenter: function (e) {
        e.stopPropagation();
        e.preventDefault();
        timeOpened = setTimeout(function () {
          $('#tree_menu').show();
          $('.categoryTree').show();
        }, 500);
      },
      mouseleave: function (e) {
        e.stopPropagation();
        e.preventDefault();
        clearTimeout(timeOpened);
        $('.categoryTree-child').hide();
        $('.categoryTree').hide();
        $('#tree_menu').hide();
        $('.category_child').remove();
      },
    },
    '.header__headerInner__nav__listsLeft__item'
  );
});
