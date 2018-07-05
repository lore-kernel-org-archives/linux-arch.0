Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:52998 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754092AbeGEUGa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jul 2018 16:06:30 -0400
MIME-Version: 1.0
In-Reply-To: <201807051322.sUohKhUO%fengguang.wu@intel.com>
References: <20180703054422.12089-4-deepa.kernel@gmail.com> <201807051322.sUohKhUO%fengguang.wu@intel.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Thu, 5 Jul 2018 13:06:29 -0700
Message-ID: <CABeXuvoXX2=0XrnpDjxu74QBK3zd6qEk46tzYrMuRD+-FKjbZw@mail.gmail.com>
Subject: Re: [PATCH 3/6] timex: prepare compat helpers for y2038 changes
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, linux-arch <linux-arch@vger.kernel.org>, palmer@sifive.com, linux-riscv@lists.infradead.org
Message-ID: <20180705200629.ZiM8qWyajzEzDK2jHOgZv8_wK0DE5An9ng6OkZkSvXA@z>

The error is fixed with the following patch that goes in before patch
3/6 above in the series.
Let me know if I should post a v2 instead.

Thanks,
Deepa


commit bfe4b046ed7f01154aef44fcb77d3f172929ccc2
Author: Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Thu Jul 5 11:47:25 2018 -0700

    riscv: Include asm-generic/compat.h

    riscv does not enable CONFIG_COMPAT in default configurations:
    defconfig, allmodconfig and nomodconfig.
    And hence does not inlude definitions for compat data types.

    Now that time syscalls are being reused in non CONFIG_COMPAT
    modes, include asm-generic definitions for riscv.

    Alternative would be to make compat_time.h to be conditional on
    CONFIG_COMPAT_32BIT_TIME. But, since riscv is already has an
    asm/compat.h include the generic version instead.

    Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
    Cc: palmer@sifive.com
    Cc: linux-riscv@lists.infradead.org

diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
index 044aecff8854..e78c5054e178 100644
--- a/arch/riscv/include/asm/compat.h
+++ b/arch/riscv/include/asm/compat.h
@@ -15,6 +15,9 @@
  */
 #ifndef __ASM_COMPAT_H
 #define __ASM_COMPAT_H
+
+#include <asm-generic/compat.h>
+
 #ifdef CONFIG_COMPAT

 #if defined(CONFIG_64BIT)

On Thu, Jul 5, 2018 at 12:06 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Deepa,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tip/timers/core]
> [also build test ERROR on next-20180704]
> [cannot apply to linus/master v4.18-rc3]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Deepa-Dinamani/arm64-Make-basic-compat_-types-always-available/20180703-151440
> config: riscv-defconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=riscv
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/compat.h:10,
>                     from include/linux/ethtool.h:17,
>                     from include/linux/netdevice.h:41,
>                     from drivers/net/mii.c:32:
>>> include/linux/compat_time.h:29:2: error: unknown type name 'compat_uint_t'
>      compat_uint_t modes;
>      ^~~~~~~~~~~~~
>>> include/linux/compat_time.h:30:2: error: unknown type name 'compat_long_t'
>      compat_long_t offset;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:31:2: error: unknown type name 'compat_long_t'
>      compat_long_t freq;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:32:2: error: unknown type name 'compat_long_t'
>      compat_long_t maxerror;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:33:2: error: unknown type name 'compat_long_t'
>      compat_long_t esterror;
>      ^~~~~~~~~~~~~
>>> include/linux/compat_time.h:34:2: error: unknown type name 'compat_int_t'
>      compat_int_t status;
>      ^~~~~~~~~~~~
>    include/linux/compat_time.h:35:2: error: unknown type name 'compat_long_t'
>      compat_long_t constant;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:36:2: error: unknown type name 'compat_long_t'
>      compat_long_t precision;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:37:2: error: unknown type name 'compat_long_t'
>      compat_long_t tolerance;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:39:2: error: unknown type name 'compat_long_t'
>      compat_long_t tick;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:40:2: error: unknown type name 'compat_long_t'
>      compat_long_t ppsfreq;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:41:2: error: unknown type name 'compat_long_t'
>      compat_long_t jitter;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:42:2: error: unknown type name 'compat_int_t'
>      compat_int_t shift;
>      ^~~~~~~~~~~~
>    include/linux/compat_time.h:43:2: error: unknown type name 'compat_long_t'
>      compat_long_t stabil;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:44:2: error: unknown type name 'compat_long_t'
>      compat_long_t jitcnt;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:45:2: error: unknown type name 'compat_long_t'
>      compat_long_t calcnt;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:46:2: error: unknown type name 'compat_long_t'
>      compat_long_t errcnt;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:47:2: error: unknown type name 'compat_long_t'
>      compat_long_t stbcnt;
>      ^~~~~~~~~~~~~
>    include/linux/compat_time.h:48:2: error: unknown type name 'compat_int_t'
>      compat_int_t tai;
>      ^~~~~~~~~~~~
>>> include/linux/compat_time.h:50:2: error: expected specifier-qualifier-list before 'compat_int_t'
>      compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
>      ^~~~~~~~~~~~
>
> vim +/compat_uint_t +29 include/linux/compat_time.h
>
>     27
>     28  struct compat_timex {
>   > 29          compat_uint_t modes;
>   > 30          compat_long_t offset;
>   > 31          compat_long_t freq;
>     32          compat_long_t maxerror;
>     33          compat_long_t esterror;
>   > 34          compat_int_t status;
>     35          compat_long_t constant;
>     36          compat_long_t precision;
>     37          compat_long_t tolerance;
>     38          struct compat_timeval time;
>     39          compat_long_t tick;
>     40          compat_long_t ppsfreq;
>     41          compat_long_t jitter;
>     42          compat_int_t shift;
>     43          compat_long_t stabil;
>     44          compat_long_t jitcnt;
>     45          compat_long_t calcnt;
>   > 46          compat_long_t errcnt;
>     47          compat_long_t stbcnt;
>     48          compat_int_t tai;
>     49
>   > 50          compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
>     51          compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
>     52          compat_int_t:32; compat_int_t:32; compat_int_t:32;
>     53  };
>     54
>     55
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
