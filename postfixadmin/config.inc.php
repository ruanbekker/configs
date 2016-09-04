<?php
$CONF['configured'] = false;
$CONF['setup_password'] = 'changeme';
$CONF['postfix_admin_url'] = '';
$CONF['postfix_admin_path'] = dirname(__FILE__);
$CONF['default_language'] = 'en';
$CONF['database_type'] = 'mysql';
$CONF['database_host'] = 'localhost';
$CONF['database_user'] = 'postfix';
$CONF['database_password'] = 'postfixadmin';
$CONF['database_name'] = 'postfix';
$CONF['database_prefix'] = '';
$CONF['database_tables'] = array (
    'admin' => 'admin',
    'alias' => 'alias',
    'alias_domain' => 'alias_domain',
    'config' => 'config',
    'domain' => 'domain',
    'domain_admins' => 'domain_admins',
    'fetchmail' => 'fetchmail',
    'log' => 'log',
    'mailbox' => 'mailbox',
    'vacation' => 'vacation',
    'vacation_notification' => 'vacation_notification',
    'quota' => 'quota',
    'quota2' => 'quota2',
);

$CONF['admin_email'] = 'postmaster@change-this-to-your.domain.tld';

$CONF['smtp_server'] = 'localhost';
$CONF['smtp_port'] = '25';
$CONF['encrypt'] = 'md5crypt';
$CONF['authlib_default_flavor'] = 'md5raw';
$CONF['dovecotpw'] = "/usr/sbin/dovecotpw";
$CONF['min_password_length'] = 5;
$CONF['generate_password'] = 'NO';
$CONF['show_password'] = 'NO';
$CONF['page_size'] = '10';
$CONF['default_aliases'] = array (
    'abuse' => 'abuse@change-this-to-your.domain.tld',
    'hostmaster' => 'hostmaster@change-this-to-your.domain.tld',
    'postmaster' => 'postmaster@change-this-to-your.domain.tld',
    'webmaster' => 'webmaster@change-this-to-your.domain.tld'
);
$CONF['domain_path'] = 'YES';
$CONF['domain_in_mailbox'] = 'NO';
$CONF['maildir_name_hook'] = 'NO';
$CONF['aliases'] = '10';
$CONF['mailboxes'] = '10';
$CONF['maxquota'] = '10';
$CONF['quota'] = 'NO';
$CONF['quota_multiplier'] = '1024000';
// If you want to define additional transport options for a domain set this to 'YES'.
$CONF['transport'] = 'NO';
$CONF['transport_options'] = array (
    'virtual',  // for virtual accounts
    'local',    // for system accounts
    'relay'     // for backup mx
);
$CONF['transport_default'] = 'virtual';
$CONF['vacation'] = 'NO';
$CONF['vacation_domain'] = 'autoreply.change-this-to-your.domain.tld';
$CONF['vacation_control'] ='YES';
$CONF['vacation_control_admin'] = 'YES';
$CONF['alias_control'] = 'NO';
$CONF['alias_control_admin'] = 'NO';
$CONF['special_alias_control'] = 'NO';
$CONF['alias_goto_limit'] = '0';
$CONF['alias_domain'] = 'YES';
$CONF['backup'] = 'YES';
$CONF['sendmail'] = 'YES';
$CONF['logging'] = 'YES';
$CONF['fetchmail'] = 'YES';
$CONF['fetchmail_extra_options'] = 'NO';
$CONF['show_header_text'] = 'NO';
$CONF['header_text'] = ':: Postfix Admin ::';
$CONF['user_footer_link'] = "http://change-this-to-your.domain.tld/main";
$CONF['show_footer_text'] = 'YES';
$CONF['footer_text'] = 'Return to change-this-to-your.domain.tld';
$CONF['footer_link'] = 'http://change-this-to-your.domain.tld';
$CONF['welcome_text'] = <<<EOM
Hi,

Welcome to your new account.

For any queries mail me at <mailto:ruan@ruanbekker.com>

EOM;
$CONF['emailcheck_resolve_domain']='YES';
$CONF['show_status']='NO';
$CONF['show_status_key']='NO';
$CONF['show_status_text']='&nbsp;&nbsp;';
$CONF['show_undeliverable']='NO';
$CONF['show_undeliverable_color']='tomato';
$CONF['show_undeliverable_exceptions']=array("unixmail.domain.ext","exchangeserver.domain.ext","gmail.com");
$CONF['show_popimap']='NO';
$CONF['show_popimap_color']='darkgrey';
$CONF['show_custom_domains']=array("subdomain.domain.ext","domain2.ext");
$CONF['show_custom_colors']=array("lightgreen","lightblue");
$CONF['recipient_delimiter'] = "";
$CONF['create_mailbox_subdirs_prefix']='INBOX.';
$CONF['used_quotas'] = 'NO';
$CONF['new_quota_table'] = 'NO';
$CONF['theme_logo'] = 'images/logo-default.png';
$CONF['theme_css'] = 'css/default.css';
$CONF['xmlrpc_enabled'] = false;
if (file_exists(dirname(__FILE__) . '/config.local.php')) {
    include(dirname(__FILE__) . '/config.local.php');
}