import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const GeneratedLocalizationsDelegate delegate =
    GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get app_title => "Mail Client";
  String get btn_cancel => "Cancel";
  String get btn_delete => "Delete";
  String get btn_login => "Login";
  String get btn_to_spam => "To spam";
  String get compose_body_placeholder => "Message text...";
  String get compose_forward_body_original_message => "---- Original Message ----";
  String get compose_forward_date_format => "EEE, MMM d, yyyy, HH:mm";
  String get compose_reply_date_format => "EEE, MMM d, yyyy 'at' HH:mm";
  String get contacts => "Contacts";
  String get contacts_birth_date_format => "MMM d, yyyy";
  String get contacts_edit => "Edit contact";
  String get contacts_edit_cancel => "Cancel editing contact";
  String get contacts_edit_save => "Save changes";
  String get contacts_empty => "No contacts";
  String get contacts_list_app_bar_mail => "Mail";
  String get contacts_view_address => "Address";
  String get contacts_view_app_bar_attach => "Send this contact";
  String get contacts_view_app_bar_edit_contact => "Edit contact";
  String get contacts_view_app_bar_search_messages => "Search messages with this contact";
  String get contacts_view_app_bar_send_message => "Email to this contact";
  String get contacts_view_birthday => "Birthday";
  String get contacts_view_business_email => "Business email";
  String get contacts_view_city => "City";
  String get contacts_view_company => "Company";
  String get contacts_view_country => "Country/Region";
  String get contacts_view_department => "Department";
  String get contacts_view_display_name => "Display name";
  String get contacts_view_email => "Email";
  String get contacts_view_facebook => "Facebook";
  String get contacts_view_fax => "Fax";
  String get contacts_view_first_name => "First name";
  String get contacts_view_hide_additional_fields => "Hide additional fields";
  String get contacts_view_job_title => "Job Title";
  String get contacts_view_last_name => "Last name";
  String get contacts_view_mobile => "Mobile";
  String get contacts_view_nickname => "Nickname";
  String get contacts_view_notes => "Notes";
  String get contacts_view_office => "Office";
  String get contacts_view_other_email => "Other email";
  String get contacts_view_personal_email => "Personal email";
  String get contacts_view_phone => "Phone";
  String get contacts_view_province => "State/Province";
  String get contacts_view_section_business => "Business";
  String get contacts_view_section_groups => "Groups";
  String get contacts_view_section_home => "Home";
  String get contacts_view_section_other_info => "Other";
  String get contacts_view_show_additional_fields => "Show additional fields";
  String get contacts_view_skype => "Skype";
  String get contacts_view_street_address => "Street address";
  String get contacts_view_web_page => "Web Page";
  String get contacts_view_zip => "Zip Code";
  String get error_compose_no_receivers => "Please provide receivers";
  String get error_compose_wait_attachments => "Please wait until attachments finish uploading";
  String get error_connection => "Could not connect to the server";
  String get error_connection_offline => "You're offline";
  String get error_input_validation_email => "The email is not valid";
  String get error_input_validation_empty => "This field is required";
  String get error_input_validation_name_illegal_symbol => "The name cannot contain \"/\\*?<>|:\"";
  String get error_input_validation_unique_name => "This name already exists";
  String get error_login_auto_discover => "Could not detect domain from this email, please specify your server url manually.";
  String get error_login_input_email => "Please enter email";
  String get error_login_input_hostname => "Please enter hostname";
  String get error_login_input_password => "Please enter password";
  String get error_login_no_accounts => "This user doesn't have mail accounts";
  String get error_server_access_denied => "Access denied";
  String get error_server_account_exists => "Such account already exists";
  String get error_server_account_old_password_not_correct => "Account's old password is not correct";
  String get error_server_auth_error => "Invalid email/password";
  String get error_server_calendars_not_allowed => "Calendars not allowed";
  String get error_server_can_not_change_password => "Cannot change password";
  String get error_server_can_not_create_account => "Cannot create account";
  String get error_server_can_not_create_contact => "Cannot create contact";
  String get error_server_can_not_create_group => "Cannot create group";
  String get error_server_can_not_create_helpdesk_user => "Cannot create helpdesk user";
  String get error_server_can_not_get_contact => "Cannot get contact";
  String get error_server_can_not_save_settings => "Cannot save settings";
  String get error_server_can_not_update_contact => "Cannot update contact";
  String get error_server_can_not_update_group => "Cannot update group";
  String get error_server_can_not_upload_file_limit => "Cannot upload file limit";
  String get error_server_can_not_upload_file_quota => "You have reached your cloud storage space limit. Can't upload file.";
  String get error_server_captcha_error => "Captcha error";
  String get error_server_contact_data_has_been_modified_by_another_application => "Contact data has been modified by another application";
  String get error_server_contacts_not_allowed => "Contacts not allowed";
  String get error_server_data_base_error => "DataBase error";
  String get error_server_demo_account => "Demo account";
  String get error_server_file_already_exists => "Such file already exists";
  String get error_server_file_not_found => "File not found";
  String get error_server_files_not_allowed => "Files not allowed";
  String get error_server_helpdesk_system_user_exists => "Helpdesk system user already exists";
  String get error_server_helpdesk_unactivated_user => "Helpdesk unactivated user";
  String get error_server_helpdesk_unknown_user => "Helpdesk unknown user";
  String get error_server_helpdesk_user_already_exists => "Helpdesk user already exists";
  String get error_server_incorrect_file_extension => "Incorrect file extension";
  String get error_server_invalid_input_parameter => "Invalid input parameter";
  String get error_server_invalid_token => "Invalid token";
  String get error_server_license_limit => "License limit";
  String get error_server_license_problem => "License problem";
  String get error_server_mail_server_error => "Mail server error";
  String get error_server_method_not_found => "Method not found";
  String get error_server_module_not_found => "Module not found";
  String get error_server_rest_account_find_failed => "Rest account find failed";
  String get error_server_rest_api_disabled => "Rest api disabled";
  String get error_server_rest_invalid_credentials => "Rest invalid credentials";
  String get error_server_rest_invalid_parameters => "Rest invalid parameters";
  String get error_server_rest_invalid_token => "Rest invalid token";
  String get error_server_rest_other_error => "Rest other error";
  String get error_server_rest_tenant_find_failed => "Rest tenant find failed";
  String get error_server_rest_token_expired => "Rest token expired";
  String get error_server_rest_unknown_method => "Rest unknown method";
  String get error_server_system_not_configured => "System is not configured";
  String get error_server_unknown_email => "Unknown email";
  String get error_server_user_already_exists => "Such user already exists";
  String get error_server_user_not_allowed => "User is not allowed";
  String get error_server_voice_not_allowed => "Voice not allowed";
  String get error_unknown => "Unknown error";
  String get folders_empty => "No folders";
  String get folders_starred => "Starred";
  String get login_input_email => "Email";
  String get login_input_host => "Host";
  String get login_input_password => "Password";
  String get messages_attachment_delete => "Delete attachment";
  String get messages_attachment_download => "Download attachment";
  String get messages_attachment_download_cancel => "Cancel download";
  String get messages_attachment_download_failed => "Download failed";
  String get messages_attachment_upload => "Upload attachment";
  String get messages_attachment_upload_cancel => "Cancel upload";
  String get messages_attachment_upload_failed => "Upload failed";
  String get messages_attachments_empty => "No attachments";
  String get messages_bcc => "BCC";
  String get messages_cc => "CC";
  String get messages_delete_desc => "Are you sure you want to delete this message?";
  String get messages_delete_title => "Delete message";
  String get messages_empty => "No messages";
  String get messages_forward => "Forward";
  String get messages_from => "From";
  String get messages_list_app_bar_contacts => "Contacts";
  String get messages_list_app_bar_loading_folders => "Loading folders...";
  String get messages_list_app_bar_logout => "Log out";
  String get messages_list_app_bar_settings => "Settings";
  String get messages_no_receivers => "No receivers";
  String get messages_no_subject => "No subject";
  String get messages_reply => "Reply";
  String get messages_reply_all => "Reply to all";
  String get messages_saved_in_drafts => "Message saved in drafts";
  String get messages_sending => "Sending message...";
  String get messages_show_details => "Show details";
  String get messages_subject => "Subject";
  String get messages_to => "To";
  String get messages_to_me => "To me";
  String get messages_view_tab_attachments => "Attachments";
  String get messages_view_tab_message_body => "Message body";
  String get new_message => "new message";
  String get new_messages => "new messages";
  String get settings => "Settings";
  String get settings_about => "About";
  String get settings_about_privacy_policy => "Privacy policy";
  String get settings_about_terms_of_service => "Terms of Service";
  String get settings_common => "Common";
  String get settings_dark_theme => "Dark theme";
  String get settings_language => "Language";
  String get settings_language_system => "System language";
  String get settings_sync => "Sync";
  String get settings_sync_frequency => "Sync frequency";
  String get settings_sync_frequency_daily => "daily";
  String get settings_sync_frequency_hours1 => "1 hour";
  String get settings_sync_frequency_hours2 => "2 hours";
  String get settings_sync_frequency_minutes1 => "1 minute";
  String get settings_sync_frequency_minutes5 => "5 minutes";
  String get settings_sync_frequency_monthly => "monthly";
  String get settings_sync_frequency_never => "never";
  String get settings_sync_period => "Sync period";
  String get settings_sync_period_all_time => "all time";
  String get settings_sync_period_months1 => "1 month";
  String get settings_sync_period_months3 => "3 months";
  String get settings_sync_period_months6 => "6 months";
  String get settings_sync_period_years1 => "1 year";
  String compose_forward_bcc(String emails) => "BCC: $emails";
  String compose_forward_cc(String emails) => "CC: $emails";
  String compose_forward_from(String emails) => "From: $emails";
  String compose_forward_sent(String date) => "Sent: $date";
  String compose_forward_subject(String subject) => "Subject: $subject";
  String compose_forward_to(String emails) => "To: $emails";
  String compose_reply_body_title(String time, String from) => "On $time, $from wrote:";
  String messages_attachment_download_success(String path) => "File downloaded into: $path";
  String messages_attachment_downloading(String fileName) => "Downloading $fileName...";
  String messages_attachment_upload_success(String path) => "File uploaded into: $path";
  String messages_attachment_uploading(String fileName) => "Uploading $fileName...";
  String messages_delete_desc_with_subject(String subject) => "Are you sure you want to delete $subject?";
  String settings_about_app_version(String version) => "Version $version";
  String you_have_new_message(String s1, String s2) => "You have $s1 $s2";
}

class $ru extends S {
  const $ru();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get messages_view_tab_attachments => "Вложения";
  @override
  String get error_server_rest_invalid_parameters => "Неверные параметры REST";
  @override
  String get settings_sync_period_years1 => "1 год";
  @override
  String get compose_body_placeholder => "Текст сообщения...";
  @override
  String get error_server_file_not_found => "Файл не найден";
  @override
  String get error_input_validation_email => "Адрес электронной почты не действителен";
  @override
  String get messages_attachment_upload_failed => "Загрузка не удалась";
  @override
  String get settings_about_terms_of_service => "Правила пользования";
  @override
  String get error_server_voice_not_allowed => "Голос не разрешен";
  @override
  String get error_server_data_base_error => "Ошибка базы данных";
  @override
  String get error_server_can_not_create_group => "Не удалось создать группу";
  @override
  String get settings_sync_frequency_daily => "ежедневно";
  @override
  String get error_server_invalid_input_parameter => "Неверный входной параметр";
  @override
  String get messages_from => "От кого";
  @override
  String get error_server_invalid_token => "Неверный токен";
  @override
  String get messages_attachment_upload => "Загрузить файл";
  @override
  String get messages_no_receivers => "Нет получателей";
  @override
  String get error_server_user_already_exists => "Такой пользователь уже существует";
  @override
  String get error_server_can_not_update_contact => "Не удается обновить контакт";
  @override
  String get error_server_can_not_get_contact => "Не удалось получить контакт";
  @override
  String get settings_common => "Общие";
  @override
  String get error_server_contact_data_has_been_modified_by_another_application => "Контактные данные были изменены другим приложением";
  @override
  String get messages_cc => "CC";
  @override
  String get error_server_method_not_found => "Метод не найден";
  @override
  String get settings_sync_frequency_monthly => "ежемесячно";
  @override
  String get messages_list_app_bar_contacts => "Контакты";
  @override
  String get error_server_module_not_found => "Модуль не найден";
  @override
  String get messages_list_app_bar_loading_folders => "Загрузка папок...";
  @override
  String get error_server_captcha_error => "Ошибка Captcha";
  @override
  String get error_server_unknown_email => "Неизвестный адрес электронной почты";
  @override
  String get error_server_helpdesk_system_user_exists => "Пользователь системы службы поддержки уже существует";
  @override
  String get error_server_rest_unknown_method => "Неизвестный метод REST";
  @override
  String get error_server_rest_invalid_token => "Недействительный токен REST";
  @override
  String get messages_view_tab_message_body => "Тело письма";
  @override
  String get error_compose_wait_attachments => "Пожалуйста, дождитесь окончания загрузки файлов";
  @override
  String get error_server_files_not_allowed => "Файлы не разрешены";
  @override
  String get messages_saved_in_drafts => "Сообщение сохранено в черновиках";
  @override
  String get contacts_empty => "Контактов нет";
  @override
  String get error_server_demo_account => "Демо аккаунт";
  @override
  String get messages_to => "Кому";
  @override
  String get login_input_password => "Пароль";
  @override
  String get settings_language_system => "Язык системы";
  @override
  String get error_server_user_not_allowed => "Пользователь не допущен";
  @override
  String get btn_to_spam => "Спам";
  @override
  String get settings_sync_frequency_hours1 => "1 час";
  @override
  String get settings_sync_frequency_hours2 => "два часа";
  @override
  String get messages_subject => "Тема";
  @override
  String get btn_delete => "Удалить";
  @override
  String get messages_list_app_bar_logout => "Выйти";
  @override
  String get error_server_system_not_configured => "Система не настроена";
  @override
  String get error_server_rest_api_disabled => "Остальные API отключены";
  @override
  String get settings_about_privacy_policy => "Политика конфиденциальности";
  @override
  String get app_title => "Mail Client";
  @override
  String get error_server_helpdesk_unactivated_user => "Неактивированный пользователь службы поддержки";
  @override
  String get messages_attachment_upload_cancel => "Отменить загрузку";
  @override
  String get error_server_calendars_not_allowed => "Календари не разрешены";
  @override
  String get error_server_can_not_save_settings => "Не удалось сохранить настройки";
  @override
  String get btn_cancel => "Отмена";
  @override
  String get error_server_contacts_not_allowed => "Контакты не разрешены";
  @override
  String get error_server_can_not_change_password => "Не удалось сменить пароль";
  @override
  String get contacts => "Контакты";
  @override
  String get error_server_rest_tenant_find_failed => "Не удалось найти тенант REST";
  @override
  String get messages_list_app_bar_settings => "Настройки";
  @override
  String get messages_attachment_download => "Скачать файл";
  @override
  String get error_unknown => "Неизвестная ошибка";
  @override
  String get messages_attachment_download_cancel => "Отменить загрузку";
  @override
  String get error_server_rest_other_error => "Другая ошибка REST";
  @override
  String get messages_reply_all => "Ответить всем";
  @override
  String get messages_sending => "Отправка сообщения...";
  @override
  String get messages_show_details => "Показать детали";
  @override
  String get messages_no_subject => "Без темы";
  @override
  String get settings => "Настройки";
  @override
  String get settings_sync_frequency => "Обновлять каждые";
  @override
  String get messages_attachment_delete => "Удалить файл";
  @override
  String get messages_bcc => "BCC";
  @override
  String get settings_sync_period => "Синхронизировать письма за";
  @override
  String get error_login_input_email => "Пожалуйста, введите адрес электронной почты";
  @override
  String get folders_empty => "Нет папок";
  @override
  String get btn_login => "Войти";
  @override
  String get error_server_license_limit => "Лимит лицензии";
  @override
  String get error_server_rest_invalid_credentials => "Неверные учетные данные REST";
  @override
  String get error_server_access_denied => "Доступ запрещён";
  @override
  String get messages_empty => "Нет сообщений";
  @override
  String get error_login_auto_discover => "Не удалось обнаружить домен по этому адресу электронной почты, укажите URL-адрес вашего сервера вручную.";
  @override
  String get settings_sync_frequency_minutes1 => "1 минута";
  @override
  String get settings_sync_period_months1 => "1 месяц";
  @override
  String get messages_forward => "Переслать";
  @override
  String get settings_sync_period_months3 => "3 месяца";
  @override
  String get contacts_list_app_bar_mail => "Почта";
  @override
  String get error_input_validation_empty => "Это поле обязательно к заполнению";
  @override
  String get error_login_no_accounts => "У этого пользователя нет почтовых аккаунтов";
  @override
  String get settings_sync_period_months6 => "6 месяцев";
  @override
  String get error_input_validation_name_illegal_symbol => "Имя не может содержать \"/ \\ *? <> |:\"";
  @override
  String get compose_forward_body_original_message => "---- Оригинал сообщения ----";
  @override
  String get error_compose_no_receivers => "Пожалуйста, укажите получателей";
  @override
  String get messages_delete_title => "Удалить сообщение";
  @override
  String get error_server_rest_account_find_failed => "Не удалось найти аккаунт REST";
  @override
  String get error_server_file_already_exists => "Такой файл уже существует";
  @override
  String get error_server_can_not_update_group => "Не удается обновить группу";
  @override
  String get error_server_rest_token_expired => "Срок действия токена REST истек";
  @override
  String get error_login_input_hostname => "Пожалуйста, введите имя хоста";
  @override
  String get error_login_input_password => "Пожалуйста введите пароль";
  @override
  String get settings_sync => "Синхронизация";
  @override
  String get settings_sync_frequency_minutes5 => "5 минут";
  @override
  String get settings_about => "О приложении";
  @override
  String get error_server_account_exists => "Такой аккаунт уже существует";
  @override
  String get error_server_can_not_create_account => "Не могу создать аккаунт";
  @override
  String get messages_to_me => "Мне";
  @override
  String get settings_sync_period_all_time => "все время";
  @override
  String get login_input_email => "Почта";
  @override
  String get error_input_validation_unique_name => "Это имя уже существует";
  @override
  String get messages_delete_desc => "Вы уверены, что хотите удалить это сообщение?";
  @override
  String get error_server_license_problem => "Проблема с лицензией";
  @override
  String get error_server_auth_error => "Неверный адрес электронной почты / пароль";
  @override
  String get settings_language => "Язык";
  @override
  String get error_connection => "Не удалось установить соединение с сервером";
  @override
  String get settings_sync_frequency_never => "отключено";
  @override
  String get login_input_host => "Хост";
  @override
  String get error_server_can_not_upload_file_quota => "Вы достигли лимита места в облачном хранилище. Не могу загрузить файл.";
  @override
  String get error_server_helpdesk_unknown_user => "Служба поддержки неизвестного пользователя";
  @override
  String get messages_reply => "Ответить";
  @override
  String get folders_starred => "Отмеченные";
  @override
  String get messages_attachments_empty => "Нет вложений";
  @override
  String get error_server_mail_server_error => "Ошибка почтового сервера";
  @override
  String get error_server_can_not_create_helpdesk_user => "Невозможно создать пользователя службы поддержки";
  @override
  String get error_server_incorrect_file_extension => "Неверное расширение файла";
  @override
  String get error_server_account_old_password_not_correct => "Неправильный старый пароль учетной записи";
  @override
  String get error_server_can_not_upload_file_limit => "Превышен лимит загрузки файлов";
  @override
  String get settings_dark_theme => "Тёмная тема";
  @override
  String get messages_attachment_download_failed => "Ошибка загрузки";
  @override
  String get error_server_helpdesk_user_already_exists => "Пользователь службы поддержки уже существует";
  @override
  String get error_server_can_not_create_contact => "Не удалось создать контакт";
  @override
  String messages_attachment_downloading(String fileName) => "Загрузка $fileName...";
  @override
  String compose_forward_from(String emails) => "От: $emails";
  @override
  String compose_forward_to(String emails) => "Кому: $emails";
  @override
  String messages_attachment_download_success(String path) => "Файл загружен в: $path";
  @override
  String compose_forward_sent(String date) => "Отправлено: $date";
  @override
  String messages_attachment_upload_success(String path) => "Файл загружен в: $path";
  @override
  String compose_forward_subject(String subject) => "Тема: $subject";
  @override
  String settings_about_app_version(String version) => "Версия $version";
  @override
  String messages_attachment_uploading(String fileName) => "Загрузка $fileName...";
  @override
  String compose_forward_bcc(String emails) => "BCC: $emails";
  @override
  String compose_forward_cc(String emails) => "CC: $emails";
  @override
  String messages_delete_desc_with_subject(String subject) => "Вы уверены, что хотите удалить $subject?";
  @override
  String compose_reply_body_title(String time, String from) => "В $time, $from написал(а):";
}

class $en extends S {
  const $en();
}

class $tr extends S {
  const $tr();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get messages_view_tab_attachments => "Attachments";
  @override
  String get error_server_rest_invalid_parameters => "REST geçersiz parametre";
  @override
  String get settings_sync_period_years1 => "1 yıl";
  @override
  String get compose_body_placeholder => "İleti metni...";
  @override
  String get error_server_file_not_found => "Dosya bulunamadı";
  @override
  String get error_input_validation_email => "E-posta geçerli değil";
  @override
  String get messages_attachment_upload_failed => "Yükleme işlemi başarısız";
  @override
  String get error_server_voice_not_allowed => "Ses'e izin verilmiyor";
  @override
  String get error_server_data_base_error => "Veri tabanı hatası";
  @override
  String get error_server_can_not_create_group => "Grup oluşturulamıyor";
  @override
  String get settings_sync_frequency_daily => "günlük";
  @override
  String get error_server_invalid_input_parameter => "Geçersiz giriş parametresi";
  @override
  String get messages_from => "Gönderen";
  @override
  String get error_server_invalid_token => "Geçersiz anahtar (token)";
  @override
  String get messages_attachment_upload => "Dosya yükle";
  @override
  String get messages_no_receivers => "Alıcı yok";
  @override
  String get error_server_user_already_exists => "Böyle bir kullanıcı zaten var";
  @override
  String get error_server_can_not_update_contact => "Kişi güncellenemiyor";
  @override
  String get error_server_can_not_get_contact => "Kişi verileri alınamıyor";
  @override
  String get settings_common => "Genel";
  @override
  String get error_server_contact_data_has_been_modified_by_another_application => "Kişi verileri başka bir uygulama tarafından değiştirildi";
  @override
  String get messages_cc => "CC";
  @override
  String get error_server_method_not_found => "Yöntem bulunamadı";
  @override
  String get settings_sync_frequency_monthly => "aylık";
  @override
  String get messages_list_app_bar_contacts => "Contacts";
  @override
  String get error_server_module_not_found => "Modül bulunamadı";
  @override
  String get messages_list_app_bar_loading_folders => "Klasörler yükleniyor...";
  @override
  String get compose_forward_date_format => "EEE, MMM d, yyyy, HH:mm";
  @override
  String get error_server_captcha_error => "CAPTCHA hatası";
  @override
  String get error_server_unknown_email => "Bilinmeyen e-posta";
  @override
  String get error_server_helpdesk_system_user_exists => "Yardım masası sistemi kullanıcısı zaten var";
  @override
  String get error_server_rest_unknown_method => "REST bilinmeyen yöntem";
  @override
  String get error_server_rest_invalid_token => "REST geçersiz anahtar";
  @override
  String get messages_view_tab_message_body => "Message body";
  @override
  String get error_compose_wait_attachments => "Lütfen eklerin yüklenmesi tamamlanıncaya kadar bekleyin";
  @override
  String get error_server_files_not_allowed => "Dosyalara izin verilmiyor";
  @override
  String get messages_saved_in_drafts => "İleti taslaklara kaydedildi";
  @override
  String get contacts_empty => "No contacts";
  @override
  String get error_server_demo_account => "Demo hesabı";
  @override
  String get messages_to => "Alıcı";
  @override
  String get login_input_password => "Şifre";
  @override
  String get error_server_user_not_allowed => "Kullanıcıya izin verilmiyor";
  @override
  String get btn_to_spam => "Spam'e taşı";
  @override
  String get settings_sync_frequency_hours1 => "1 saat";
  @override
  String get settings_sync_frequency_hours2 => "2 saat";
  @override
  String get messages_subject => "Konu";
  @override
  String get btn_delete => "Sil";
  @override
  String get messages_list_app_bar_logout => "Oturumu kapat";
  @override
  String get error_server_system_not_configured => "Sistem yapılandırılmamış";
  @override
  String get error_server_rest_api_disabled => "REST API devre dışı";
  @override
  String get app_title => "E-posta Okuyucu";
  @override
  String get error_server_helpdesk_unactivated_user => "Etkin olmayan Yardım masası kullanıcısı";
  @override
  String get messages_attachment_upload_cancel => "Yüklemeyi iptal et";
  @override
  String get error_server_calendars_not_allowed => "Takvimlere izin verilmiyor";
  @override
  String get error_server_can_not_save_settings => "Ayarlar kaydedilemiyor";
  @override
  String get btn_cancel => "Iptal";
  @override
  String get error_server_contacts_not_allowed => "Kişilere izin verilmiyor";
  @override
  String get error_server_can_not_change_password => "Şifre değiştirilemiyor";
  @override
  String get contacts => "Contacts";
  @override
  String get error_server_rest_tenant_find_failed => "REST kullanıcı bulma başarısız oldu";
  @override
  String get messages_list_app_bar_settings => "Ayarlar";
  @override
  String get messages_attachment_download => "Eki indir";
  @override
  String get error_unknown => "Bilinmeyen hata";
  @override
  String get messages_attachment_download_cancel => "İndirmeyi iptal et";
  @override
  String get error_server_rest_other_error => "Diğer REST hatası";
  @override
  String get messages_reply_all => "Tümünü yanıtla";
  @override
  String get messages_sending => "İleti gönderiliyor...";
  @override
  String get messages_show_details => "Detayları göster";
  @override
  String get messages_no_subject => "Konu yok";
  @override
  String get settings => "Ayarlar";
  @override
  String get settings_sync_frequency => "Senkronizasyon sıklığı";
  @override
  String get messages_attachment_delete => "Eki sil";
  @override
  String get messages_bcc => "BCC";
  @override
  String get settings_sync_period => "Senkronizasyon periyodu";
  @override
  String get error_login_input_email => "Lütfen e-posta adresini girin";
  @override
  String get folders_empty => "Klasör yok";
  @override
  String get btn_login => "Oturum aç";
  @override
  String get error_server_license_limit => "Lisans limiti";
  @override
  String get error_server_rest_invalid_credentials => "REST geçersiz kimlik bilgileri";
  @override
  String get compose_reply_date_format => "EEE, MMM d, yyyy, HH:mm";
  @override
  String get error_server_access_denied => "Erişim engellendi";
  @override
  String get messages_empty => "İleti yok";
  @override
  String get error_login_auto_discover => "Bu e-postada alan adı tespit edilemedi, lütfen sunucunuzun URL'sini manuel olarak belirtin.";
  @override
  String get settings_sync_frequency_minutes1 => "1 dakika";
  @override
  String get settings_sync_period_months1 => "1 ay";
  @override
  String get messages_forward => "Yönlendir";
  @override
  String get settings_sync_period_months3 => "3 ay";
  @override
  String get contacts_list_app_bar_mail => "Mail";
  @override
  String get error_input_validation_empty => "Bu alanı doldurmak zorunludur";
  @override
  String get error_login_no_accounts => "Bu kullanıcının e-posta hesabı yok";
  @override
  String get settings_sync_period_months6 => "6 ay";
  @override
  String get error_input_validation_name_illegal_symbol => "İsim, \"/\\*?<>|:\" karakterleri içeremez";
  @override
  String get compose_forward_body_original_message => "---- Orijinal İleti ----";
  @override
  String get error_compose_no_receivers => "Lütfen alıcı ekleyin";
  @override
  String get messages_delete_title => "İletiyi sil";
  @override
  String get error_server_rest_account_find_failed => "REST hesap bulma başarısız";
  @override
  String get error_server_file_already_exists => "Böyle bir dosya zaten var";
  @override
  String get error_server_can_not_update_group => "Grup güncellenemiyor";
  @override
  String get error_server_rest_token_expired => "REST anahtar süresi doldu";
  @override
  String get error_login_input_hostname => "Lütfen mobile uygulama sunucu URL sini girin";
  @override
  String get error_login_input_password => "Lütfen şifrenizi girin";
  @override
  String get settings_sync => "Senkronizasyon";
  @override
  String get settings_sync_frequency_minutes5 => "5 dakika";
  @override
  String get error_server_account_exists => "Böyle bir hesap zaten var";
  @override
  String get error_server_can_not_create_account => "Hesap oluşturulamıyor";
  @override
  String get messages_to_me => "Bana";
  @override
  String get settings_sync_period_all_time => "her zaman";
  @override
  String get login_input_email => "E-posta";
  @override
  String get error_input_validation_unique_name => "Bu isim zaten var";
  @override
  String get messages_delete_desc => "Bu iletiyi silmek istediğinden emin misin?";
  @override
  String get error_server_license_problem => "Lisans sorunu";
  @override
  String get error_server_auth_error => "Geçersiz e-posta/şifre";
  @override
  String get settings_language => "Dil";
  @override
  String get error_connection => "Sunucuya bağlanılamadı";
  @override
  String get settings_sync_frequency_never => "hiçbir zaman";
  @override
  String get login_input_host => "Sunucu";
  @override
  String get error_server_can_not_upload_file_quota => "Bulut depolama alanı sınırınıza ulaştınız. Dosya yüklenemiyor.";
  @override
  String get error_server_helpdesk_unknown_user => "Bilinmeyen yardım masası kullanıcısı";
  @override
  String get messages_reply => "Yanıtla";
  @override
  String get folders_starred => "Yıldızlı";
  @override
  String get messages_attachments_empty => "No attachments";
  @override
  String get error_server_mail_server_error => "E-posta sunucusu hatası";
  @override
  String get error_server_can_not_create_helpdesk_user => "Yardım masası kullanıcısı oluşturulamıyor";
  @override
  String get error_server_incorrect_file_extension => "Yanlış dosya uzantısı";
  @override
  String get error_server_account_old_password_not_correct => "Hesabın eski şifresi doğru değil";
  @override
  String get error_server_can_not_upload_file_limit => "Dosya yüklenemiyor: dosya limiti";
  @override
  String get messages_attachment_download_failed => "İndirme işlemi başarısız";
  @override
  String get error_server_helpdesk_user_already_exists => "Yardım masası kullanıcısı zaten var";
  @override
  String get error_server_can_not_create_contact => "Kişi oluşturulamıyor";
  @override
  String messages_attachment_downloading(String fileName) => "$fileName indiriliyor ...";
  @override
  String compose_forward_from(String emails) => "Gönderen: $emails";
  @override
  String compose_forward_to(String emails) => "Alıcı: $emails";
  @override
  String messages_attachment_download_success(String path) => "Dosya şuraya indirildi: $path";
  @override
  String compose_forward_sent(String date) => "Gönderildi: $date";
  @override
  String messages_attachment_upload_success(String path) => "Dosya şuraya yüklendi: $path";
  @override
  String compose_forward_subject(String subject) => "Konu: $subject";
  @override
  String messages_attachment_uploading(String fileName) => "$fileName yükleniyor ...";
  @override
  String compose_forward_bcc(String emails) => "BCC: $emails";
  @override
  String compose_forward_cc(String emails) => "CC: $emails";
  @override
  String messages_delete_desc_with_subject(String subject) => "$subject silmek istediğinize emin misiniz?";
  @override
  String compose_reply_body_title(String time, String from) => "$time,tarihinde $from yazdı:";
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("ru", ""),
      Locale("en", ""),
      Locale("tr", ""),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "ru":
          S.current = const $ru();
          return SynchronousFuture<S>(S.current);
        case "en":
          S.current = const $en();
          return SynchronousFuture<S>(S.current);
        case "tr":
          S.current = const $tr();
          return SynchronousFuture<S>(S.current);
        default:
          // NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported, bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
  ? null
  : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();
