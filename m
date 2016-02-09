From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] asm-generic: Fix build when __set_fixmap is absent
Date: Wed, 10 Feb 2016 00:13:31 +0800
Message-ID: <201602100053.LjML6D6b%fengguang.wu@intel.com>
References: <20160209143554.GA9332@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160209143554.GA9332@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: kbuild-all@01.org, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>
List-Id: linux-arch.vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

[auto build test ERROR on next-20160209]
[also build test ERROR on v4.5-rc3]
[cannot apply to v4.5-rc3 v4.5-rc2 v4.5-rc1]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Mark-Rutland/asm-generic-Fix-build-when-__set_fixmap-is-absent/20160209-223916
config: um-alldefconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by >>):

   In file included from arch/um/include/asm/fixmap.h:54:0,
                    from arch/um/include/asm/pgtable.h:11,
                    from include/linux/mm.h:67,
                    from include/linux/ring_buffer.h:5,
                    from include/linux/trace_events.h:5,
                    from include/trace/syscall.h:6,
                    from include/linux/syscalls.h:81,
                    from init/main.c:18:
>> include/asm-generic/fixmap.h:72:6: error: conflicting types for '__set_fixmap'
    void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
         ^
   In file included from arch/um/include/asm/pgtable.h:11:0,
                    from include/linux/mm.h:67,
                    from include/linux/ring_buffer.h:5,
                    from include/linux/trace_events.h:5,
                    from include/trace/syscall.h:6,
                    from include/linux/syscalls.h:81,
                    from init/main.c:18:
   arch/um/include/asm/fixmap.h:39:13: note: previous declaration of '__set_fixmap' was here
    extern void __set_fixmap (enum fixed_addresses idx,
                ^

vim +/__set_fixmap +72 include/asm-generic/fixmap.h

    66	
    67	#ifndef clear_fixmap
    68	#define clear_fixmap(idx)			\
    69		__set_fixmap(idx, 0, FIXMAP_PAGE_CLEAR)
    70	#endif
    71	
  > 72	void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
    73	
    74	/* Return a pointer with offset calculated */
    75	static inline unsigned long __set_fixmap_offset(enum fixed_addresses idx,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--VS++wcV0S1rZb1Fb
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--VS++wcV0S1rZb1Fb--
