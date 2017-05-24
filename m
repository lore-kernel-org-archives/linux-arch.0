From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH v4 2/2] kernel.h: handle pointers to arrays better in
 container_of()
Date: Wed, 24 May 2017 11:46:17 +0100
Message-ID: <7dbdfa72-e168-3b50-90dc-bca8239e8081@mev.co.uk>
References: <201705240824.8lrwsHKo%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp104.iad3a.emailsrvr.com ([173.203.187.104]:55197 "EHLO
        smtp104.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1760703AbdEXKqV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 May 2017 06:46:21 -0400
In-Reply-To: <201705240824.8lrwsHKo%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Michal Nazarewicz <mina86@mina86.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Borislav Petkov <bp@suse.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Johannes Berg <johannes.berg@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Potapenko <glider@google.com>

On 24/05/17 01:54, kbuild test robot wrote:
> Hi Ian,
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.12-rc2 next-20170523]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Ian-Abbott/asm-generic-bug-h-declare-struct-pt_regs-before-function-prototype/20170524-070310
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from include/linux/kernel.h:14:0,
>                     from include/asm-generic/bug.h:15,
>                     from arch/x86/include/asm/bug.h:81,
>                     from drivers/block/drbd/drbd_interval.c:1:
>>> include/linux/bug.h:103:47: warning: 'struct bug_entry' declared inside parameter list will not be visible outside of this definition or declaration
>     static inline int is_warning_bug(const struct bug_entry *bug)
>                                                   ^~~~~~~~~
>    include/linux/bug.h: In function 'is_warning_bug':
>>> include/linux/bug.h:105:12: error: dereferencing pointer to incomplete type 'const struct bug_entry'
>      return bug->flags & BUGFLAG_WARNING;
>                ^~
>
> vim +105 include/linux/bug.h
>
> ff20c2e0 Kirill A. Shutemov  2016-03-01   97
> 35edd910 Paul Gortmaker      2011-11-16   98  #endif	/* __CHECKER__ */
> 35edd910 Paul Gortmaker      2011-11-16   99
> 7664c5a1 Jeremy Fitzhardinge 2006-12-08  100  #ifdef CONFIG_GENERIC_BUG
> 7664c5a1 Jeremy Fitzhardinge 2006-12-08  101  #include <asm-generic/bug.h>
> 7664c5a1 Jeremy Fitzhardinge 2006-12-08  102
> 7664c5a1 Jeremy Fitzhardinge 2006-12-08 @103  static inline int is_warning_bug(const struct bug_entry *bug)
> 7664c5a1 Jeremy Fitzhardinge 2006-12-08  104  {
> 7664c5a1 Jeremy Fitzhardinge 2006-12-08 @105  	return bug->flags & BUGFLAG_WARNING;
> 7664c5a1 Jeremy Fitzhardinge 2006-12-08  106  }
> 7664c5a1 Jeremy Fitzhardinge 2006-12-08  107
> 19d43626 Peter Zijlstra      2017-02-25  108  struct bug_entry *find_bug(unsigned long bugaddr);
>
> :::::: The code at line 105 was first introduced by commit
> :::::: 7664c5a1da4711bb6383117f51b94c8dc8f3f1cd [PATCH] Generic BUG implementation
>
> :::::: TO: Jeremy Fitzhardinge <jeremy@goop.org>
> :::::: CC: Linus Torvalds <torvalds@woody.osdl.org>

This breakage occurs when <asm-generic/bug.h> is included before 
<include/linux.h> due to a circular dependancy I introduced with this 
commit.

It can be fixed by replacing the `#include <linux/kernel.h>` with 
`#include <linux/types.h>` in "include/asm-generic/bug.h".  I can send a 
patch to fix that, but ideally, it should be committed before this 
commit to avoid breakage during git bisect builds.  So my question is, 
should I send a single patch to fix this breakage, or resend the series 
of patches to incorporate this fix before the current commit?

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
