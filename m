From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] arch: all: include: asm: bitops: Use bool instead of
 int for all bit test functions
Date: Tue, 6 Sep 2016 12:27:32 -0700
Message-ID: <20160906122732.2086f1bcb1c3daa378e21d3b@linux-foundation.org>
References: <1472396129-28665-1-git-send-email-chengang@emindsoft.com.cn>
        <201609040802.ueL85Ttu%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:58042 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935127AbcIFT1g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2016 15:27:36 -0400
In-Reply-To: <201609040802.ueL85Ttu%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: chengang@emindsoft.com.cn, kbuild-all@01.org, minchan@kernel.org, vbabka@suse.cz, gi-oh.kim@profitbricks.com, iamjoonsoo.kim@lge.com, hillf.zj@alibaba-inc.com, mgorman@techsingularity.net, mhocko@suse.com, rientjes@google.com, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@l

On Sun, 4 Sep 2016 08:27:36 +0800 kbuild test robot <lkp@intel.com> wrote:

> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.8-rc4 next-20160825]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
> 
> url:    https://github.com/0day-ci/linux/commits/chengang-emindsoft-com-cn/arch-all-include-asm-bitops-Use-bool-instead-of-int-for-all-bit-test-functions/20160828-230301
> config: s390-default_defconfig (attached as .config)
> compiler: s390x-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=s390 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/bitops.h:36:0,
>                     from fs/btrfs/extent_io.c:1:
> >> arch/s390/include/asm/bitops.h:176:15: error: unknown type name 'bool'
>     static inline bool
>                   ^
>    arch/s390/include/asm/bitops.h:187:15: error: unknown type name 'bool'
>     static inline bool

My s390 cross compiler doesn't like that config.  Can someone test this?

--- a/arch/s390/include/asm/bitops.h~a
+++ a/arch/s390/include/asm/bitops.h
@@ -40,6 +40,7 @@
 #error only <linux/bitops.h> can be included directly
 #endif
 
+#include <linux/types.h>
 #include <linux/typecheck.h>
 #include <linux/compiler.h>
 #include <asm/barrier.h>
_
