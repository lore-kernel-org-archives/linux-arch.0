Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de ([212.227.126.187]:14825 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262730AbUDHWYI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Apr 2004 18:24:08 -0400
Subject: =?iso-8859-1?Q?Re:_posix_message_queues?=
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Message-Id: <26879984$10814625564075cf1c382fe8.54494376@config6.schlund.de>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Fri,  9 Apr 2004 00:22:01 +0200
To: =?iso-8859-1?Q?Andrew_Morton?= <akpm@osdl.org>
Cc: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>, manfred@colorfullife.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Andrew Morton <akpm@osdl.org> schrieb am 08.04.2004, 22:24:28:
> 
> It broke ppc64.   Please check other architectures for the same pattern.
> 
> In file included from arch/ppc64/kernel/signal.c:29:
> include/asm/ppc32.h:144: redefinition of `struct compat_sigevent'
> include/asm/ppc32.h:156: redefinition of `compat_sigevent_t'
> include/linux/compat.h:107: `compat_sigevent_t' previously declared here

D'oh! I remember thinking that would break but forgot to fix it. On the 
other architectures, the existing structure is called sigevent_t32 or
similar, so it does not conflict but should still be changed to use
the common definition.

      Arnd <><
