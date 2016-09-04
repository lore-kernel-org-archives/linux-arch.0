From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2] arch: all: include: asm: bitops: Use bool instead of
 int for all bit test functions
Date: Sun, 4 Sep 2016 08:07:30 +0800
Message-ID: <201609040800.5IcW0UrX%fengguang.wu@intel.com>
References: <1472396129-28665-1-git-send-email-chengang@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41747 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbcIDALg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 3 Sep 2016 20:11:36 -0400
Content-Disposition: inline
In-Reply-To: <1472396129-28665-1-git-send-email-chengang@emindsoft.com.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: chengang@emindsoft.com.cn
Cc: kbuild-all@01.org, akpm@linux-foundation.org, minchan@kernel.org, vbabka@suse.cz, gi-oh.kim@profitbricks.com, iamjoonsoo.kim@lge.com, hillf.zj@alibaba-inc.com, mgorman@techsingularity.net, mhocko@suse.com, rientjes@google.com, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@l


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chen,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc4 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/chengang-emindsoft-com-cn/arch-all-include-asm-bitops-Use-bool-instead-of-int-for-all-bit-test-functions/20160828-230301
config: powerpc-makalu_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from include/linux/bitops.h:36:0,
                    from include/linux/radix-tree.h:24,
                    from kernel/memremap.c:13:
>> arch/powerpc/include/asm/bitops.h:103:19: error: unknown type name 'bool'
    static __inline__ bool fn(    \
                      ^
   arch/powerpc/include/asm/bitops.h:123:1: note: in expansion of macro 'DEFINE_TESTOP'
    DEFINE_TESTOP(test_and_set_bits, or, PPC_ATOMIC_ENTRY_BARRIER,
    ^
>> arch/powerpc/include/asm/bitops.h:103:19: error: unknown type name 'bool'
    static __inline__ bool fn(    \
                      ^
   arch/powerpc/include/asm/bitops.h:125:1: note: in expansion of macro 'DEFINE_TESTOP'
    DEFINE_TESTOP(test_and_set_bits_lock, or, "",
    ^
>> arch/powerpc/include/asm/bitops.h:103:19: error: unknown type name 'bool'
    static __inline__ bool fn(    \
                      ^
   arch/powerpc/include/asm/bitops.h:127:1: note: in expansion of macro 'DEFINE_TESTOP'
    DEFINE_TESTOP(test_and_clear_bits, andc, PPC_ATOMIC_ENTRY_BARRIER,
    ^
>> arch/powerpc/include/asm/bitops.h:103:19: error: unknown type name 'bool'
    static __inline__ bool fn(    \
                      ^
   arch/powerpc/include/asm/bitops.h:129:1: note: in expansion of macro 'DEFINE_TESTOP'
    DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
    ^
   arch/powerpc/include/asm/bitops.h:132:19: error: unknown type name 'bool'
    static __inline__ bool test_and_set_bit(unsigned long nr,
                      ^
   arch/powerpc/include/asm/bitops.h:138:19: error: unknown type name 'bool'
    static __inline__ bool test_and_set_bit_lock(unsigned long nr,
                      ^
   arch/powerpc/include/asm/bitops.h:145:19: error: unknown type name 'bool'
    static __inline__ bool test_and_clear_bit(unsigned long nr,
                      ^
   arch/powerpc/include/asm/bitops.h:151:19: error: unknown type name 'bool'
    static __inline__ bool test_and_change_bit(unsigned long nr,
                      ^
   In file included from arch/powerpc/include/asm/bitops.h:157:0,
                    from include/linux/bitops.h:36,
                    from include/linux/radix-tree.h:24,
                    from kernel/memremap.c:13:
>> include/asm-generic/bitops/non-atomic.h:57:15: error: unknown type name 'bool'
    static inline bool __test_and_set_bit(int nr, volatile unsigned long *addr)
                  ^
   include/asm-generic/bitops/non-atomic.h:76:15: error: unknown type name 'bool'
    static inline bool __test_and_clear_bit(int nr, volatile unsigned long *addr)
                  ^
   include/asm-generic/bitops/non-atomic.h:87:15: error: unknown type name 'bool'
    static inline bool __test_and_change_bit(int nr,
                  ^
   include/asm-generic/bitops/non-atomic.h:103:15: error: unknown type name 'bool'
    static inline bool test_bit(int nr, const volatile unsigned long *addr)
                  ^

vim +/bool +103 arch/powerpc/include/asm/bitops.h

    97		change_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
    98	}
    99	
   100	/* Like DEFINE_BITOP(), with changes to the arguments to 'op' and the output
   101	 * operands. */
   102	#define DEFINE_TESTOP(fn, op, prefix, postfix, eh)	\
 > 103	static __inline__ bool fn(				\
   104			unsigned long mask,			\
   105			volatile unsigned long *_p)		\
   106	{							\

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--7JfCtLOvnd9MIVvH
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICEhky1cAAy5jb25maWcAjFxdc9s2s77vr+CkZ860F238lTSZM76AQFBCRRIMAMp2bjiK
rTSaOrJfSW6Tf392QVIEqIXydqaTCLv43o9nF8v8/NPPCXvZP31d7tf3y8fH78lfq81qu9yv
HpLP68fV/yWpSkplE5FK+zsw5+vNy7fXz0//rrbP98nV7+9+P/tte3+ZzFfbzeox4U+bz+u/
XmCA9dPmp5+hA1dlJqdNVfG3V8l6l2ye9slutf/JEavt0/1qt3vaJruX5+en7X7UpZkoNb80
zeWF3zXgePfm27c4MaR1lKuzb9ffB8arK3oAcXF2RvX+hr29SYqibko1Y2bmj9pSGpNLLgwx
DBxqw9VMaFHCXxifiXHvVCk9EXlOdF6kRl1eDMvgVd1McMllKlkZLM9nu7yYSDv8vFE6bYz8
KK4vL4apmeazpprdmYalqW5s8/YKepEn5FjTgkU5Oz44IX9zM7YQjRG2rppKaLd4pgUjpyiF
SA9copjAr0xqA0c2q8s5da66kfqDuX5zftE3Gcv43GrGYda6qpT2zqBthh5ZzqbmmJ4rPk9F
dUzQN0YUzS2fTWHzDcunSks7KwYGdzggFY3M1fSiqf2LmIpSaMmb2Y2Q05klOuGpwhENIlIw
Mw8u1j/Rfjxu6oI4E8F0ftdUWpbWH4OV0MXKQqjaXp+/Oxuvrlxo5m3IgIymjSqkbTIgiKZS
MKDQo9UX7K69YRDhLOWhrtTpZNqcv33z5oxavp2Yu5ITG2A1mB83/PEZTuqpP5aoWKXRbtAi
m4qM1bltalmwqaCmcjcgJ0KXzEpVwi6NkZNcjLZpalOBuhFkp7tcN9h/cazVQCkKqYipO/LR
RE7yQCQEbBVubSpYDmIZY6srrSbChOth6aLrr8U0SpOMm+sLmpaeoi2AdhCfamoZHEiTi4XI
vT5w9L1SSWOvX71+XH96/fXp4eVxtXv9P3WJIqVFLpgRr3+/d47kVd8XFBTNFUqvcxFT56Ue
8fRenqGlY5toNRdlA7dmimrYpSxBekS5gJPCyUGC0eL1tlPDDYKeFZWEW3z1ariurq2xwlBW
De6A5QuhDUgJ9iOaQXCtGtbRC99MGYvbvX71y+Zps/r10NfcMG/Z5s4sZMWPGvBPbnPvFpWR
t03xoRa1oFuPurS7LkSh9F3DLFhIT7WyGSvTPBDd2ohcTmgvgMpJnI8zAk42HQeuAAS3v0G4
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

--7JfCtLOvnd9MIVvH--
