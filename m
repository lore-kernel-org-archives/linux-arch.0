Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de ([212.227.126.186]:37369 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261605AbUFEOyE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 5 Jun 2004 10:54:04 -0400
Subject: =?iso-8859-1?Q?Re:_Re:_Re:_sys_getdents64_needs_compat_wrapper_??=
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Message-Id: <26879984$108644643740c1db65f33611.91624784@config13.schlund.de>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Sat,  5 Jun 2004 16:52:01 +0200
To: =?iso-8859-1?Q?Arun_Sharma?= <arun.sharma@intel.com>
Cc: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Arun Sharma <arun.sharma@intel.com> schrieb am 05.06.2004, 02:16:09:

> - use put_user instead of copy_to_user for simple data types.

Not that I care too much, but what's the point of this change? A single
__copy_to_user should be both faster and easier to read than two 
seperate __put_user when writing an unaligned 64 bit value.

       Arnd <><
