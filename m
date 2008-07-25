From: Adrian Bunk <bunk@kernel.org>
Subject: PAGE_ALIGN() compile breakage
Date: Fri, 25 Jul 2008 11:39:43 +0300
Message-ID: <20080725083943.GC19310@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:39770 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbYGYIkI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Jul 2008 04:40:08 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Righi <righi.andrea@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Commit 27ac792ca0b0a1e7e65f20342260650516c95864
(PAGE_ALIGN(): correctly handle 64-bit values on 32-bit architectures)
causes on some architectures (e.g. avr32 and mips) compile errors
like the following in some configurations starting with:

<--  snip  -->

...
  CC      init/main.o
In file included from 
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/utsname.h:35,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/init/main.c:20:
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/sched.h: In function 'arch_pick_mmap_layout':
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/sched.h:2149: error: implicit declaration of function 'PAGE_ALIGN'
make[2]: *** [init/main.o] Error 1

<--  snip  -->

and more nasty problems follow later.

My suggestion is to:
- revert commit 27ac792ca0b0a1e7e65f20342260650516c95864 and then
- fix all PAGE_ALIGN() instances without moving them.

Unifying code is a good thing, but in this case it is not worth the 
trouble it causes by poking into the heart of our headers mess.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
