From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] kbuild: Remove stale asm-generic wrappers
Date: Tue, 19 Jan 2016 18:42:52 +0800
Message-ID: <201601191806.sph9h01K%fengguang.wu@intel.com>
References: <1453199503-30900-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453199503-30900-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kbuild-owner@vger.kernel.org
Cc: kbuild-all@01.org, Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, James Hogan <james.hogan@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi James,

[auto build test ERROR on kbuild/for-next]
[also build test ERROR on v4.4 next-20160119]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild.git for-next
config: i386-tinyconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:25:0:
>> arch/x86/kernel/asm-offsets_32.c:12:29: fatal error: asm/syscalls_32.h: No such file or directory
   compilation terminated.
   make[2]: *** [arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +12 arch/x86/kernel/asm-offsets_32.c

5de2b61a6 arch/x86/kernel/asm-offsets_32.c  Borislav Petkov 2014-12-09   1  #ifndef __LINUX_KBUILD_H
5de2b61a6 arch/x86/kernel/asm-offsets_32.c  Borislav Petkov 2014-12-09   2  # error "Please do not build this file directly, build asm-offsets.c instead"
5de2b61a6 arch/x86/kernel/asm-offsets_32.c  Borislav Petkov 2014-12-09   3  #endif
5de2b61a6 arch/x86/kernel/asm-offsets_32.c  Borislav Petkov 2014-12-09   4  
8d0d37cfb arch/i386/kernel/asm-offsets_32.c Thomas Gleixner 2007-10-11   5  #include <asm/ucontext.h>
8d0d37cfb arch/i386/kernel/asm-offsets_32.c Thomas Gleixner 2007-10-11   6  
8d0d37cfb arch/i386/kernel/asm-offsets_32.c Thomas Gleixner 2007-10-11   7  #include <linux/lguest.h>
8d0d37cfb arch/i386/kernel/asm-offsets_32.c Thomas Gleixner 2007-10-11   8  #include "../../../drivers/lguest/lg.h"
8d0d37cfb arch/i386/kernel/asm-offsets_32.c Thomas Gleixner 2007-10-11   9  
303395ac3 arch/x86/kernel/asm-offsets_32.c  H. Peter Anvin  2011-11-11  10  #define __SYSCALL_I386(nr, sym, compat) [nr] = 1,
303395ac3 arch/x86/kernel/asm-offsets_32.c  H. Peter Anvin  2011-11-11  11  static char syscalls[] = {
303395ac3 arch/x86/kernel/asm-offsets_32.c  H. Peter Anvin  2011-11-11 @12  #include <asm/syscalls_32.h>
303395ac3 arch/x86/kernel/asm-offsets_32.c  H. Peter Anvin  2011-11-11  13  };
303395ac3 arch/x86/kernel/asm-offsets_32.c  H. Peter Anvin  2011-11-11  14  
8d0d37cfb arch/i386/kernel/asm-offsets_32.c Thomas Gleixner 2007-10-11  15  /* workaround for a warning with -Wmissing-prototypes */
8d0d37cfb arch/i386/kernel/asm-offsets_32.c Thomas Gleixner 2007-10-11  16  void foo(void);
8d0d37cfb arch/i386/kernel/asm-offsets_32.c Thomas Gleixner 2007-10-11  17  
8d0d37cfb arch/i386/kernel/asm-offsets_32.c Thomas Gleixner 2007-10-11  18  void foo(void)
8d0d37cfb arch/i386/kernel/asm-offsets_32.c Thomas Gleixner 2007-10-11  19  {
8d0d37cfb arch/i386/kernel/asm-offsets_32.c Thomas Gleixner 2007-10-11  20  	OFFSET(CPUINFO_x86, cpuinfo_x86, x86);

:::::: The code at line 12 was first introduced by commit
:::::: 303395ac3bf3e2cb488435537d416bc840438fcb x86: Generate system call tables and unistd_*.h from tables

:::::: TO: H. Peter Anvin <hpa@linux.intel.com>
:::::: CC: H. Peter Anvin <hpa@linux.intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--MGYHOYXEY6WxJCY8
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
z8JVAAA=

--MGYHOYXEY6WxJCY8--
