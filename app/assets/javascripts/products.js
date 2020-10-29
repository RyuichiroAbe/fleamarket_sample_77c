$(function(){
  const buildFileField = (index)=> {
      // 画像用のinputを生成する関数
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[images_attributes][${index}][src]"
                    id="item_images_attributes_${index}_src"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }
  const buildImg = (index, url)=> {
    const html = `<div class="item-image"><img class="preview-image" data-index="${index}" src="${url}" width="120px" height="100px">
    <button class="item-image__js-remove" data-index="${index}">削除</button><div class="item-image__js-edit" data-index="${index}">編集</div></div>`;
    return html;
  }
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();


  $('.ItemNew-Select').on('click', function(e) {
    const previewImages = $('.preview-image');
    
    if(previewImages.length >= 5){
      alert('limit');
      return false;
    }
    const fileField = $('input[type="file"]:last');
    fileField.trigger('click');
  });

  $('#file-fields').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {
      $('#previews').append(buildImg(targetIndex, blobUrl));
    $('#file-fields').append(buildFileField(fileIndex[0]));
    fileIndex.shift();
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    }
  });

  $('#previews').on('click', '.item-image__js-remove', function() {
    
    // 削除ボタンを押した画像を取得
    var target_image = $(this).parent();
    console.log($(this));
    // 削除画像のdata-image番号を取得
    var target_image_num = target_image.data('image');
    // 対象の画像をビュー上で削除
    target_image.remove();
    console.log(target_image);
    console.log(target_image_num);

    var index_num = $(this).data('index');

    var img_file = document.getElementById(`item_images_attributes_${index_num}_src`);
    console.log(img_file)

    img_file.remove();
    
    var img_file_edit = document.getElementById(`item_images_attributes_${index_num}__destroy`);
    console.log(img_file_edit)

    $(img_file_edit).trigger("change").attr('checked', 'checked');
// trigger

  });

  $('#previews').on('click', '.item-image__js-edit', function() {




    var index_num = $(this).data('index');

    var img_file = document.getElementById(`item_images_attributes_${index_num}_src`);
    console.log(img_file)
 
    $(img_file).trigger("click")


  });



});