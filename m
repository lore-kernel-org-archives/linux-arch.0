From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Date: Tue, 24 Jan 2017 01:49:48 +0800
Message-ID: <201701240138.rYat3c0G%fengguang.wu@intel.com>
References: <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-kbuild-owner@vger.kernel.org
Cc: kbuild-all@01.org, arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, Nicolas Dichtel <nicolas.dichtel@6wind.com>
List-Id: linux-arch.vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicolas,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc5 next-20170123]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nicolas-Dichtel/uapi-export-all-headers-under-uapi-directories/20170124-011935
config: i386-tinyconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/processor.h:20:0,
                    from arch/x86/include/asm/cpufeature.h:4,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:25,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from include/linux/crypto.h:24,
                    from arch/x86/kernel/asm-offsets.c:8:
>> arch/x86/include/asm/msr.h:4:23: fatal error: msr-index.h: No such file or directory
    #include "msr-index.h"
                          ^
   compilation terminated.
   make[2]: *** [arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +4 arch/x86/include/asm/msr.h

1965aae3 arch/x86/include/asm/msr.h H. Peter Anvin            2008-10-22   1  #ifndef _ASM_X86_MSR_H
1965aae3 arch/x86/include/asm/msr.h H. Peter Anvin            2008-10-22   2  #define _ASM_X86_MSR_H
be7baf80 include/asm-x86/msr.h      Thomas Gleixner           2007-10-23   3  
b72e7464 arch/x86/include/asm/msr.h Borislav Petkov           2015-06-04  @4  #include "msr-index.h"
be7baf80 include/asm-x86/msr.h      Thomas Gleixner           2007-10-23   5  
8f12dea6 include/asm-x86/msr.h      Glauber de Oliveira Costa 2008-01-30   6  #ifndef __ASSEMBLY__
c210d249 include/asm-x86/msr.h      Glauber de Oliveira Costa 2008-01-30   7  
c210d249 include/asm-x86/msr.h      Glauber de Oliveira Costa 2008-01-30   8  #include <asm/asm.h>
c210d249 include/asm-x86/msr.h      Glauber de Oliveira Costa 2008-01-30   9  #include <asm/errno.h>
6bc1096d arch/x86/include/asm/msr.h Borislav Petkov           2009-05-22  10  #include <asm/cpumask.h>
b72e7464 arch/x86/include/asm/msr.h Borislav Petkov           2015-06-04  11  #include <uapi/asm/msr.h>
6bc1096d arch/x86/include/asm/msr.h Borislav Petkov           2009-05-22  12  

:::::: The code at line 4 was first introduced by commit
:::::: b72e7464e4cf80117938e6adb8c22fdc1ca46d42 x86/uapi: Do not export <asm/msr-index.h> as part of the user API headers

:::::: TO: Borislav Petkov <bp@suse.de>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--0OAP2g/MAC+5xKAE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
+tSAp9qFdYK74WoSaEEC8Au4XaZ4u1oAAA==

--0OAP2g/MAC+5xKAE--
