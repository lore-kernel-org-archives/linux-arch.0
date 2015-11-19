From: hejianet <hejianet@gmail.com>
Subject: Re: [PATCH 3/3] linux/bitmap: Replace find_fisrt_{zero_}bit with the
 new lightweight api
Date: Thu, 19 Nov 2015 11:24:20 +0800
Message-ID: <564D40E4.5070900@gmail.com>
References: <201511191057.JOoDSHXo%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33896 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbbKSDYb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2015 22:24:31 -0500
In-Reply-To: <201511191057.JOoDSHXo%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Denys Vlasenko <dvlasenk@redhat.com>, Kyungmin Park <kyungmin.park@samsung.com>, Michal Nazarewicz <mina86@mina86.com>, Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>

Thanks, I only compiled and tested in x86_64, will check what's wrong i=
n=20
m68k

B.R.
Justin


=E5=9C=A8 11/19/15 10:53 AM, kbuild test robot =E5=86=99=E9=81=93:
> Hi Jia,
>
> [auto build test ERROR on: v4.4-rc1]
> [also build test ERROR on: next-20151118]
>
> url:    https://github.com/0day-ci/linux/commits/Jia-He/Improve-bitma=
p_empty-and-bitmap_full/20151119-103554
> config: m68k-allyesconfig (attached as .config)
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-te=
sts.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=3Dm68k
>
> All errors (new ones prefixed by >>):
>
>     kernel/time/Kconfig:155:warning: range is invalid
>     warning: (USB_OTG_FSM && FSL_USB2_OTG && USB_MV_OTG) selects USB_=
OTG which has unmet direct dependencies (USB_SUPPORT && USB && PM)
>     warning: (SINGLE_MEMORY_CHUNK) selects NEED_MULTIPLE_NODES which =
has unmet direct dependencies (DISCONTIGMEM || NUMA)
>     warning: (PREEMPT && DEBUG_ATOMIC_SLEEP) selects PREEMPT_COUNT wh=
ich has unmet direct dependencies (COLDFIRE)
>     warning: (USB_OTG_FSM && FSL_USB2_OTG && USB_MV_OTG) selects USB_=
OTG which has unmet direct dependencies (USB_SUPPORT && USB && PM)
>     warning: (SINGLE_MEMORY_CHUNK) selects NEED_MULTIPLE_NODES which =
has unmet direct dependencies (DISCONTIGMEM || NUMA)
>     warning: (PREEMPT && DEBUG_ATOMIC_SLEEP) selects PREEMPT_COUNT wh=
ich has unmet direct dependencies (COLDFIRE)
>     In file included from include/linux/cpumask.h:11:0,
>                      from include/linux/rcupdate.h:40,
>                      from include/linux/rbtree.h:34,
>                      from include/linux/sched.h:22,
>                      from arch/m68k/kernel/asm-offsets.c:14:
>     include/linux/bitmap.h: In function 'bitmap_empty':
>>> include/linux/bitmap.h:284:2: error: implicit declaration of functi=
on 'all_bit_is_zero' [-Werror=3Dimplicit-function-declaration]
>       return all_bit_is_zero(src, nbits);
>       ^
>     include/linux/bitmap.h: In function 'bitmap_full':
>>> include/linux/bitmap.h:292:2: error: implicit declaration of functi=
on 'all_bit_is_one' [-Werror=3Dimplicit-function-declaration]
>       return all_bit_is_one(src, nbits);
>       ^
>     cc1: some warnings being treated as errors
>     make[2]: *** [arch/m68k/kernel/asm-offsets.s] Error 1
>     make[2]: Target '__build' not remade because of errors.
>     make[1]: *** [prepare0] Error 2
>     make[1]: Target 'prepare' not remade because of errors.
>     make: *** [sub-make] Error 2
>
> vim +/all_bit_is_zero +284 include/linux/bitmap.h
>
>     278=09
>     279	static inline int bitmap_empty(const unsigned long *src, unsi=
gned nbits)
>     280	{
>     281		if (small_const_nbits(nbits))
>     282			return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
>     283=09
>   > 284		return all_bit_is_zero(src, nbits);
>     285	}
>     286=09
>     287	static inline int bitmap_full(const unsigned long *src, unsig=
ned int nbits)
>     288	{
>     289		if (small_const_nbits(nbits))
>     290			return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
>     291=09
>   > 292		return all_bit_is_one(src, nbits);
>     293	}
>     294=09
>     295	static __always_inline int bitmap_weight(const unsigned long =
*src, unsigned int nbits)
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technolog=
y Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Cor=
poration
