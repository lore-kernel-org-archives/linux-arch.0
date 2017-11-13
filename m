From: Vincent Chen <deanbo422@gmail.com>
Subject: Fwd: FW: [PATCH 15/31] nds32: System calls handling
Date: Mon, 13 Nov 2017 10:51:00 +0800
Message-ID: <CAJsyPhzVyV43-N4R+ckXVauceCoeXK24P9Swup2_kpbL866naQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <61b5cd5e7f2cf2f485a990cdf238788b817a1d53.1510118606.git.green.hu@gmail.com>
 <CAK8P3a33noF5+QCe8QsDVb+xpCtgSs-HDUTrO-C3NT0M4W4KUg@mail.gmail.com> <E26F4CF8B7DDDB4383A6C2D78D5C3CD56B497241@ATCPCS16.andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:55972 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbdKMCvB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Nov 2017 21:51:01 -0500
In-Reply-To: <E26F4CF8B7DDDB4383A6C2D78D5C3CD56B497241@ATCPCS16.andestech.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arndbergmann@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, vincentc@andestech.com

>>On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>
>> +#endif /* __ASM_NDS32_SYSCALLS_H */
>> diff --git a/arch/nds32/include/asm/unistd.h
>> b/arch/nds32/include/asm/unistd.h new file mode 100644 index
>> 0000000..b30adca
>> --- /dev/null
>> +++ b/arch/nds32/include/asm/unistd.h
>> @@ -0,0 +1,21 @@
>
>> +#define __ARCH_WANT_SYS_LLSEEK
>
>This gets set from include/asm-generic/unistd.h if you include that file.
>
Dear Arnd:

Thanks
I will remove it in the next version patch.


>> +#define __ARCH_WANT_SYS_CLONE
>
>This seems ok, though it would be nice to have the reverse logic and have architectures opt-out of the generic version when they need to provide their own, rather than having most architectures set it.
>

Thanks
I will provide nds32 SYSCALL_DEFINE_5(clone) in the next version patch.

>> +#define __ARCH_WANT_SYS_OLD_MMAP
>
>I don't see why you need this, can it be dropped?

Thanks
I will remove it in the next version patch.

>
>> diff --git a/arch/nds32/include/uapi/asm/unistd.h
>> b/arch/nds32/include/uapi/asm/unistd.h
>> new file mode 100644
>> index 0000000..01b466d
>> --- /dev/null
>> +++ b/arch/nds32/include/uapi/asm/unistd.h
>
>> +#define __NR_ipc               (__NR_arch_specific_syscall + 2)
>> +#define __NR_sysfs             (__NR_arch_specific_syscall + 3)
>> +#define __NR__llseek             __NR_llseek
>
>
>
>> +__SYSCALL(__NR_cacheflush, sys_cacheflush) __SYSCALL(__NR_syscall,
>> +sys_syscall) __SYSCALL(__NR_ipc, sys_ipc) __SYSCALL(__NR_sysfs,
>> +sys_sysfs)
>> +
>> +__SYSCALL(__NR_fadvise64_64, sys_fadvise64_64_wrapper)
>> +__SYSCALL(__NR_rt_sigreturn, sys_rt_sigreturn_wrapper)
>> +__SYSCALL(__NR_mmap, sys_old_mmap)
>
>Usually we handle those overrides by defining the macros in asm/unistd.h before including the asm-generic version. Can you do that as well for consistency?
>

Thanks
Ok, I will modify it in the next version patch

>I don't see a reason for sys_ipc, sys_sysfs or sys_old_mmap() here in a new architecture. Can you drop those or explain why you need them?
>

Thanks
 I will remove them in the next version patch

>> +/*
>> + * Special system call wrappers
>> + *
>> + * $r0 = syscall number
>> + * $r8 = syscall table
>> + */
>> +       .type   sys_syscall, #function
>> +ENTRY(sys_syscall)
>> +       addi    $p1, $r0, #-__NR_syscalls
>> +       bgtz    $p1, 3f
>> +       move    $p1, $r0
>> +       move    $r0, $r1
>> +       move    $r1, $r2
>> +       move    $r2, $r3
>> +       move    $r3, $r4
>> +       move    $r4, $r5
>> +! add for syscall 6 args
>> +       lwi     $r5, [$sp + #SP_OFFSET ]
>> +       lwi     $r5, [$r5]
>> +! ~add for syscall 6 args
>> +
>> +       lw      $p1, [tbl+$p1<<2]
>> .+       jr      $p1
>> +3:     b       sys_ni_syscall
>> +ENDPROC(sys_syscall)
>
>Can you explain what this is used for?
>

This is used to handle syscall(int number, ....).
Unlike other architectures,  the system number shall be determined in
compile time when issuing system call in nds32.
Therefore, we  only can parse the content of syscall(int number, ....)
and distribute it to destination handler in kernel space
(Other architecture can handle it in user space by glibc's syscall wrapper)

>> --- /dev/null
>> +++ b/arch/nds32/kernel/sys_nds32.c
>> +
>> +long sys_mmap2(unsigned long addr, unsigned long len,
>> +              unsigned long prot, unsigned long flags,
>> +              unsigned long fd, unsigned long pgoff) {
>> +       if (pgoff & (~PAGE_MASK >> 12))
>> +               return -EINVAL;
>> +
>> +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
>> +                             pgoff >> (PAGE_SHIFT - 12)); }
>> +
>> +asmlinkage long sys_fadvise64_64_wrapper(int fd, int advice, loff_t offset,
>> +                                        loff_t len) {
>> +       return sys_fadvise64_64(fd, offset, len, advice); }
>
>You should always use SYSCALL_DEFINE*() macros to define entry points for your own syscalls in C code for consistency. I also wonder if we should just move those two into common code, a lot of architectures need the first one in particular.
>

The sys_fadvise64_64_wrapper is used to reorder the input parameter.

In order to solve register alignment problem, we adjust the input
parameter order of fadvise64_64 while issuing this syscall.
Therefore, we need this wrapper to reorder the input parameter to fit
sys_fadvise64_64's API in kernel.

>       Arnd


Best regard
Vincent
