From: Chen Gang <chengang@emindsoft.com.cn>
Subject: Re: [PATCH] arch: all: include: asm: bitops: Use bool instead of
 int for all bit test functions
Date: Sun, 28 Aug 2016 22:54:10 +0800
Message-ID: <57C2FB12.2070905@emindsoft.com.cn>
References: <201608281537.rfLlXwlL%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out1134-227.mail.aliyun.com ([42.120.134.227]:56317 "EHLO
        out1134-227.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755557AbcH1OzW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Aug 2016 10:55:22 -0400
In-Reply-To: <201608281537.rfLlXwlL%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, akpm@linux-foundation.org, minchan@kernel.org, vbabka@suse.cz, gi-oh.kim@profitbricks.com, iamjoonsoo.kim@lge.com, hillf.zj@alibaba-inc.com, mgorman@techsingularity.net, mhocko@suse.com, rientjes@google.com, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@l

Hello all:

I have tried m68k and aarch64, they need include linux/types.h just like
another archs have done (e.g. arc). And then they can pass building for
the default config.

For alpha, it can pass building with my alpha cross compiler (gcc 5.0),
but for safety reason, we'd better let it include linux/types.h, too.

For openrisc, after check the code, I guess, it is the same reason. And
excuse me, I lost my openrisc cross compiler which I originally built,
so I do not give a test now, I can generate it, but really need time.

Thanks.

On 8/28/16 15:10, kbuild test robot wrote:
> Hi Chen,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.8-rc3 next-20160825]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
> 
> url:    https://github.com/0day-ci/linux/commits/chengang-emindsoft-com-cn/arch-all-include-asm-bitops-Use-bool-instead-of-int-for-all-bit-test-functions/20160828-134633
> config: m68k-sun3_defconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 4.9.0
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=m68k 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/bitops.h:36:0,
>                     from include/linux/jhash.h:26,
>                     from net/ipv6/ila/ila_xlat.c:1:
>>> arch/m68k/include/asm/bitops.h:151:15: error: unknown type name 'bool'
>     static inline bool test_bit(int nr, const unsigned long *vaddr)
>                   ^
>    arch/m68k/include/asm/bitops.h:157:15: error: unknown type name 'bool'
>     static inline bool bset_reg_test_and_set_bit(int nr,
>                   ^
>    arch/m68k/include/asm/bitops.h:170:15: error: unknown type name 'bool'
>     static inline bool bset_mem_test_and_set_bit(int nr,
>                   ^
>    arch/m68k/include/asm/bitops.h:182:15: error: unknown type name 'bool'
>     static inline bool bfset_mem_test_and_set_bit(int nr,
>                   ^
>    arch/m68k/include/asm/bitops.h:207:15: error: unknown type name 'bool'
>     static inline bool bclr_reg_test_and_clear_bit(int nr,
>                   ^
>    arch/m68k/include/asm/bitops.h:220:15: error: unknown type name 'bool'
>     static inline bool bclr_mem_test_and_clear_bit(int nr,
>                   ^
>    arch/m68k/include/asm/bitops.h:232:15: error: unknown type name 'bool'
>     static inline bool bfclr_mem_test_and_clear_bit(int nr,
>                   ^
>    arch/m68k/include/asm/bitops.h:257:15: error: unknown type name 'bool'
>     static inline bool bchg_reg_test_and_change_bit(int nr,
>                   ^
>    arch/m68k/include/asm/bitops.h:270:15: error: unknown type name 'bool'
>     static inline bool bchg_mem_test_and_change_bit(int nr,
>                   ^
>    arch/m68k/include/asm/bitops.h:282:15: error: unknown type name 'bool'
>     static inline bool bfchg_mem_test_and_change_bit(int nr,
>                   ^
> 
> vim +/bool +151 arch/m68k/include/asm/bitops.h
> 
>    145					bfchg_mem_change_bit(nr, vaddr))
>    146	#endif
>    147	
>    148	#define __change_bit(nr, vaddr)	change_bit(nr, vaddr)
>    149	
>    150	
>  > 151	static inline bool test_bit(int nr, const unsigned long *vaddr)
>    152	{
>    153		return (vaddr[nr >> 5] & (1UL << (nr & 31))) != 0;
>    154	}
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

-- 
Chen Gang (陈刚)

Managing Natural Environments is the Duty of Human Beings.
