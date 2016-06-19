create database postfix;
USE postfix;
CREATE TABLE `alias` (
  `address` varchar(255) NOT NULL default '',
  `goto` text NOT NULL,
  `domain` varchar(255) NOT NULL default '',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `modified` datetime NOT NULL default '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`address`)
) ENGINE=MyISAM COMMENT='Postfix Admin - Virtual Aliases';

USE postfix;
CREATE TABLE `domain` (
  `domain` varchar(255) NOT NULL default '',
  `description` varchar(255) NOT NULL default '',
  `aliases` int(10) NOT NULL default '0',
  `mailboxes` int(10) NOT NULL default '0',
  `maxquota` int(10) NOT NULL default '0',
  `transport` varchar(255) default NULL,
  `backupmx` tinyint(1) NOT NULL default '0',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `modified` datetime NOT NULL default '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`domain`)
) ENGINE=MyISAM COMMENT='Postfix Admin - Virtual Domains';

USE postfix;
CREATE TABLE `mailbox` (
  `username` varchar(255) NOT NULL default '',
  `password` varchar(255) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `maildir` varchar(255) NOT NULL default '',
  `quota` int(10) NOT NULL default '0',
  `domain` varchar(255) NOT NULL default '',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `modified` datetime NOT NULL default '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`username`)
) ENGINE=MyISAM COMMENT='Postfix Admin - Virtual Mailboxes';

USE postfix;
INSERT INTO domain (domain,description) VALUES ('domain.tld','Test Domain');
INSERT INTO alias (address,goto) VALUES ('alias@domain.tld', 'user@domain.tld');
INSERT INTO mailbox (username,password,name,maildir) \
  VALUES ('user@domain.tld','secret','Mailbox User','user@domain.tld/');
GRANT select, insert, update, delete on postfix.* to postfix@localhost IDENTIFIED BY 'postfix';
GRANT ALL on postfix.* to postfix@localhost IDENTIFIED BY 'postfix';