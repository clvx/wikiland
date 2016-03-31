Localization
============

/usr/share/zoneinfo and /usr/bin/locale
=======================================
• /etc/timezone
    ◦ Text file that simply contains the locally defined system timezone information.
    ◦ timezone as defined in zoneinfo database (see Video Two).
    ◦ It only exists if a timezone has been defined, otherwise is UTC.

• /etc/localtime
    ◦ Binary file that contains local time and timezone information as defined in the zoneinfo database,
    ◦ Provides call back information to programs that implement the system 'strftime()' in their routines for getting information about localtime and timezone settings.
    ◦ Newer distributions will be making it a symlink to the local time setting rather than a copy of the information in zoneinfo as set.

• /usr/share/zoneinfo
    ◦ A directory and text based “database” of all available known timezones throughout the world.
    ◦ Used by a large number of applications and local system utilities to get information about timezones, times in other zones, zone information in large zone settings, etc.
    ◦ Used by localtime to provide information as part of its call back response to system time calls.

• /usr/bin/locale: get locale specific information:
    ◦ -a: all locale (writes the names of all available locales).
    ◦ -m: character maps (writes the names of all available character maps).
    ◦ -c: write the name of selected categories.
    ◦ -k: write the names and values of selected keywords indicated.
    ◦ <no option>: provides all environment variable settings for locale information (money, number, time, date, papersize, etc).

tzselect and tzconfig
=====================

• tzconfig – deprecated in modern distributions, replaced by system reconfiguration utilities for tzdata (i.e. Debian 'dpkg-reconfigure tzdata'), used to reset local timezone information.
    ◦ export TZ="$TIMEZONE", another method to change timezone.

• tzselect – view timezone information, query date and time in other zones.
    ◦ Uses the settings and offsets defined in the zoneinfo database (see Video Two).
    ◦ Interactive script that will prompt you to choose more and more specific zones to view information on.
    ◦ When final zone is chosen, will display the current date/time and timezone setting for the selected zone.
    ◦ Will NOT reconfigure your timezone, see notes above on tzconfig and tzdata reconfiguration for details.

IOS8859, Unicode, ASCII and UTF-8
=================================

• Detailed information is beyond the scope of these notes and is discussed in some detail in the videos, content from that discussion is pulled from each of the linksbelow for each encoding.
• ISO8859.
    ◦ http://en.wikipedia.org/wiki/ISO8859
• Unicode
    ◦ http://en.wikipedia.org/wiki/Unicode
• ASCII
    ◦ http://en.wikipedia.org/wiki/Ascii
• UTF8
    ◦ http://en.wikipedia.org/wiki/Utf-8

iconv and date
==============

• /usr/bin/locale, defines default code set or character set or localization language setting on the environment variable LANG.
• iconv – convert encoding of files from one encoding to another as defined in $LANG environment variable.
    ◦ -f: from code
    ◦ -t to-encoding, --to-code=to-encoding [input_file], to code
    ◦ -l: list all known character encodings
    ◦ -o outputfile, --output=outputfile, outputs to file rather than standard output
    ◦ -s: suppress warnings
    ◦ --verbose: print progress information
        - `iconv --to-code=UNICODE file_input -o file_output` 

• date – print or set the system date and time
    ◦ <no option>: print the date and time (i.e. Wed Jul 5 10:50:21 CST 2013)
    ◦ -V: week number of the year
    ◦ -R: output date and time in RFC 2822 format.  Example: Mon, 07 Aug 2006 12:34:56 -0600
    ◦ -u: print or set Coordinated Universal Time (UTC).
    ◦ -s: set the date and/or time as indicated
    ◦ --rfc-3330=date|seconds|ns: set the date and/or time as indicated
    ◦ abbreviations
        ▪ %D: date
        ▪ %T: time
        ▪ %A: weekday name
        ▪ %d: day of month
        ▪ %t: tab
        ▪ %a: abbreviated weekday name

Environment Variables
=====================

• Existing variables as managed by system utilities for localization settings.
    ◦ /usr/bin/locale
• Overriding variables can be done the same way as any other variable is changed at the command line.
    ◦ export LC_MONEY=<new value>
• overriding variables permanently for system
    ◦ /etc/rc.local
        ▪ exportrt LC_MONEY=<new value>
• overriding value for a logged in user or shell running with environment passed in
    ◦ /home/user/.bash_profile
        ▪ export LC_MONEY=<new value>
• otherwise locale specifies most localizations calls and zoneinfo determines other local information returned by /etc/localtime

• Locale Variables, more info locale(7)
```
LANG=en_US.UTF-8
LANGUAGE=en_US
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC=es_PE.UTF-8
LC_TIME=es_PE.UTF-8
LC_COLLATE="en_US.UTF-8"
LC_MONETARY=es_PE.UTF-8
LC_MESSAGES="en_US.UTF-8"
LC_PAPER=es_PE.UTF-8
LC_NAME=es_PE.UTF-8
LC_ADDRESS=es_PE.UTF-8
LC_TELEPHONE=es_PE.UTF-8
LC_MEASUREMENT=es_PE.UTF-8
LC_IDENTIFICATION=es_PE.UTF-8
LC_ALL=
```


Localization - LC_ALL
=====================

• A locale is a set of language and cultural rules.  These cover aspects such as language for messages, different character sets, lexicographic conventions, and so on.  
    ◦ A program needs to be able to determine its locale and act accordingly to be portable to  different cultures.
    ◦ If a program throws an error during installation about LC_ALL unset. LC_ALL must be configured.
        - LC_ALL is used to override every LC_* and LANG and LANGUAGE.
    ◦ /etc/locale.alias, The  locale.alias database file (/etc/locale.alias) lists all variables for locales available for the system; also, it's used by the `locale` command for the locales, 
        - With each line being of the form `<alias> <localename>`. 
        - Where `<localename>` is in the POSIX format: xx_YY.CHARSET. The first two letters xx are the ISO-639 Language code, the next two YY are the ISO-3166 Country code, and the Charset is one of the character sets (listed in  /usr/share/i18n/charsets).
    ◦ locale-gen [locale] [language]- compile a list of locale definition files
        - If  a list of languages and/or locales is specified as arguments, then locale-gen only generates these particular locales and adds the new ones to /var/lib/locales/supported.d/local.  Otherwise it generates all supported locales.


Localization - LANG
===================

• LANG, contains the setting for every categories that are not directly set by a LC_* variable.
