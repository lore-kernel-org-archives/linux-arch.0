Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de ([212.227.126.188]:61635 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264499AbUESTcL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 May 2004 15:32:11 -0400
Subject: =?iso-8859-1?Q?Re:_[PATCH]_fixing_sendfile_on_64bit_architectures?=
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Message-Id: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Wed, 19 May 2004 21:26:01 +0200
To: davidm@hpl.hp.com
Cc: =?iso-8859-1?Q?Andi_Kleen?= <ak@suse.de>, linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>


David Mosberger <davidm@napali.hpl.hp.com> schrieb am 19.05.2004,
20:17:44:

> The patch looks fine to me.  My only minor quibble is that it would be
> nice if sys_sendfile() wasn't defined at all when it isn't needed and,
> in that case, do_sendfile() should be inlined (unit-at-a-time
> compilation will take care of the inlining if sys_sendfile() isn't
> defined when not needed, so that part doesn't require extra code).

Note that we practically always need sys_sendfile anyway for calling
from sys32_sendfile. The only exception I can see is (CONFIG_64BIT &&
!CONFIG_COMPAT).
[OT: This reminds me that I have a bunch of mostly-finished compat_sys_*
consolidation patches on my disk that need to be completed. 
compat_sys_sendfile() could of course use do_sendfile() instead of
sys_sendfile().]

> I don't like adding yet another "#ifdef __ia64 && ..." though.  It
> would be nice if there was a cleaner way to get rid of unwanted
> syscall-stubs in generic code.  How would people feel about replacing
> the current #ifdef mess with "#ifdef SYS_NEED_foo" instead?  By my
> count, that would get rid of about a dozen of those ugly #ifdefs.  For
> example, in fs/stat.c we could have:
> 
> #ifdef SYS_NEED_OLD_STAT
> 
> instead of:
> 
> #if !defined(__alpha__) && !defined(__sparc__) && !defined(__ia64__) \
>   && !defined(CONFIG_ARCH_S390) && !defined(__hppa__) \
>   && !defined(__arm__) && !defined(CONFIG_V850) && !defined(__powerpc64__) \
>   && !defined(__mips__)

Seconded. While it may not be that drastic in case of sys_sendfile,
such constructions are always ugly and I suspect many of them would
turn out to be incorrect after closer inspection.

       Arnd <><
