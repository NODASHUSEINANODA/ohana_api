// 管理者権限チェックボックスのチェック状態によって管理者メールアドレス入力欄を表示する
$(document).on('change', "#is_president", function () {
  const isAdmin = $(this).prop('value')
  const adminMailAddress = $('#admin_mail_address_group')

  if (isAdmin) { return adminMailAddress.removeClass('d-none') }
  adminMailAddress.addClass('d-none')
})


// 編集モーダルのDOM操作
$(document).on('click', '#edit-employee-btn', function () {
  const employee_id = $(this).data('employee-id');
  const employee_name = $(this).data('employee-name');
  const employee_sex = $(this).data('employee-sex');
  const employee_birthday = $(this).data('employee-birthday');
  const employee_address = $(this).data('employee-address');
  const employee_joined_at = $(this).data('employee-joined_at');
  const employee_phone_number = $(this).data('employee-phone_number');
  const employee_message = $(this).data('employee-message');
  const modal = $('#editModal');

  const url = `/employees/${employee_id}`

  // TODO: あとでbirthdayとjoined_atの型を揃える
  const date = new Date(employee_birthday);
  const formattedBirthday = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);

  modal.find('.modal-content, form').attr("action", url);
  modal.find('#name').attr('value', employee_name);
  modal.find('#sex').val(employee_sex);
  modal.find('#birthday').attr('value', formattedBirthday);
  modal.find('#address').attr('value', employee_address);
  modal.find('#joined_at').attr('value', employee_joined_at);
  modal.find('#phone_number').attr('value', employee_phone_number);
  modal.find('#message').val(employee_message);
})


// 削除用モーダルのDOM操作
$(document).on('click', '#delete-employee-btn', function () {
  const employee_id = $(this).data('employee-id');
  const employee_name = $(this).data('employee-name');
  const modal = $('#deleteModal');

  const url = `/employees/${employee_id}`

  console.log('employee_id')
  console.log(employee_id)

  console.log('deleteModal')
  console.log(modal)

  modal.find('.modal-content, form').attr("action", url);
  modal.find('.modal-title').html(`${employee_name}さんを削除しますか？`);
})

// 絞り込み検索で、空文字はparamsとして送信しない
$(document).on('click', '#search-employee-btn', function () {
  $('#search_condition, input[type="text"]').filter(function () { return $(this).val() == ""; }).prop('disabled', true)
  $('#search_condition, input[type="date"]').filter(function () { return $(this).val() == ""; }).prop('disabled', true)
  $('#search_condition, select').filter(function () { return $(this).val() == "invalid"; }).prop('disabled', true)
})
