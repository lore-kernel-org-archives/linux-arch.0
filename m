From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 0/6] {sched_,}find_first{_zero}_bit optimizations
Date: Mon, 12 Jun 2017 22:46:10 +0300
Message-ID: <20170612194610.skl7n5x5y5j7lbp7@yury-thinkpad>
References: <20170523184321.11452-1-ynorov@caviumnetworks.com>
 <20170602113443.6xa6dahtlwoaz2za@yury-thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com ([104.47.33.67]:39384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752065AbdFLTqZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Jun 2017 15:46:25 -0400
Content-Disposition: inline
In-Reply-To: <20170602113443.6xa6dahtlwoaz2za@yury-thinkpad>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Akinobu Mita <mita@miraclelinux.com>, Mike Galbraith <efault@gmx.de>, Paul Bolle <pebolle@tiscali.nl>

Ping again. Is there still any interest in the patchset?

Arnd, Ingo?

On Fri, Jun 02, 2017 at 02:34:43PM +0300, Yury Norov wrote:
> Ping?
> 
> On Tue, May 23, 2017 at 09:43:15PM +0300, Yury Norov wrote:
> > The series is the result of this discussion: https://lkml.org/lkml/2017/5/12/665
> > plus this patch: https://lkml.org/lkml/2017/5/13/137
> > (I'd like to have it together with others.)
> > 
> > Patch 1 remove useless GENERIC_FIND_FIRST_BIT option.  Patches 2 and 3 change
> > the order of macros definition and/or headers inclusion for frv and m86k, as
> > it's needed in patch 4. Patch 4 adds the optimization for find_first_bit() and
> > find_first_zero_bit(). Patches 5 and 6 consolidate the implementation of
> > sched_find_first_bit(), and make it local.
> > 
> > According to previous discussion, I added Arnd's ack to patches 5 and 6.
> > https://lkml.org/lkml/2017/5/15/514 and suggested-by to patch 4.
> > Arnd, are you OK with it?
> > 
> > Yury Norov (6):
> >   arch: remove GENERIC_FIND_FIRST_BIT
> >   m68k: make __ffs and ffz defined prior to including find.h
> >   frv: make __ffs() visible for find.h
> >   find_first{,_zero}_bit: unroll search cycle for small bitmaps
> >   alpha: drop custom implementation for sched_find_first_bit()
> >   sched: move sched_find_first_bit() from bitops.h to
> >     kernel/sched/sched.h
> > 
> >  arch/alpha/include/asm/bitops.h    |  18 -----
> >  arch/arc/Kconfig                   |   1 -
> >  arch/arc/include/asm/bitops.h      |   1 -
> >  arch/arm/include/asm/bitops.h      |   1 -
> >  arch/arm64/include/asm/bitops.h    |   1 -
> >  arch/blackfin/include/asm/bitops.h |   1 -
> >  arch/c6x/include/asm/bitops.h      |   1 -
> >  arch/cris/include/asm/bitops.h     |   2 -
> >  arch/frv/include/asm/bitops.h      |   4 +-
> >  arch/h8300/include/asm/bitops.h    |   1 -
> >  arch/hexagon/include/asm/bitops.h  |   1 -
> >  arch/ia64/include/asm/bitops.h     |   2 -
> >  arch/m32r/include/asm/bitops.h     |   1 -
> >  arch/m68k/include/asm/bitops.h     | 162 ++++++++++++++++++-------------------
> >  arch/metag/include/asm/bitops.h    |   1 -
> >  arch/mips/include/asm/bitops.h     |   2 -
> >  arch/mn10300/include/asm/bitops.h  |   1 -
> >  arch/openrisc/include/asm/bitops.h |   1 -
> >  arch/parisc/include/asm/bitops.h   |   1 -
> >  arch/powerpc/include/asm/bitops.h  |   2 -
> >  arch/s390/Kconfig                  |   1 -
> >  arch/s390/include/asm/bitops.h     |   1 -
> >  arch/sh/include/asm/bitops.h       |   1 -
> >  arch/sparc/include/asm/bitops_32.h |   1 -
> >  arch/sparc/include/asm/bitops_64.h |   1 -
> >  arch/tile/Kconfig                  |   1 -
> >  arch/tile/include/asm/bitops.h     |   1 -
> >  arch/unicore32/Kconfig             |   1 -
> >  arch/x86/Kconfig                   |   1 -
> >  arch/x86/include/asm/bitops.h      |   2 -
> >  arch/x86/um/Kconfig                |   1 -
> >  arch/xtensa/include/asm/bitops.h   |   1 -
> >  include/asm-generic/bitops.h       |   1 -
> >  include/asm-generic/bitops/find.h  |  82 +++++++++++++++++--
> >  include/asm-generic/bitops/sched.h |  31 -------
> >  kernel/sched/sched.h               |  23 ++++++
> >  lib/Kconfig                        |   3 -
> >  lib/find_bit.c                     |   8 +-
> >  38 files changed, 182 insertions(+), 184 deletions(-)
> >  delete mode 100644 include/asm-generic/bitops/sched.h
> > 
> > -- 
> > 2.11.0
