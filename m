From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/31] nds32: System calls handling
Date: Wed, 8 Nov 2017 10:30:48 +0100
Message-ID: <CAK8P3a33noF5+QCe8QsDVb+xpCtgSs-HDUTrO-C3NT0M4W4KUg@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <61b5cd5e7f2cf2f485a990cdf238788b817a1d53.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <61b5cd5e7f2cf2f485a990cdf238788b817a1d53.1510118606.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>

> +#endif /* __ASM_NDS32_SYSCALLS_H */
> diff --git a/arch/nds32/include/asm/unistd.h b/arch/nds32/include/asm/unistd.h
> new file mode 100644
> index 0000000..b30adca
> --- /dev/null
> +++ b/arch/nds32/include/asm/unistd.h
> @@ -0,0 +1,21 @@

> +#define __ARCH_WANT_SYS_LLSEEK

This gets set from include/asm-generic/unistd.h if you include that file.

> +#define __ARCH_WANT_SYS_CLONE

This seems ok, though it would be nice to have the reverse logic and have
architectures opt-out of the generic version when they need to provide their
own, rather than having most architectures set it.

> +#define __ARCH_WANT_SYS_OLD_MMAP

I don't see why you need this, can it be dropped?

> diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
> new file mode 100644
> index 0000000..01b466d
> --- /dev/null
> +++ b/arch/nds32/include/uapi/asm/unistd.h

> +#define __NR_ipc               (__NR_arch_specific_syscall + 2)
> +#define __NR_sysfs             (__NR_arch_specific_syscall + 3)
> +#define __NR__llseek             __NR_llseek



> +__SYSCALL(__NR_cacheflush, sys_cacheflush)
> +__SYSCALL(__NR_syscall, sys_syscall)
> +__SYSCALL(__NR_ipc, sys_ipc)
> +__SYSCALL(__NR_sysfs, sys_sysfs)
> +
> +__SYSCALL(__NR_fadvise64_64, sys_fadvise64_64_wrapper)
> +__SYSCALL(__NR_rt_sigreturn, sys_rt_sigreturn_wrapper)
> +__SYSCALL(__NR_mmap, sys_old_mmap)

Usually we handle those overrides by defining the macros in asm/unistd.h
before including the asm-generic version. Can you do that as well for
consistency?

I don't see a reason for sys_ipc, sys_sysfs or sys_old_mmap() here
in a new architecture. Can you drop those or explain why you need them?

> +/*
> + * Special system call wrappers
> + *
> + * $r0 = syscall number
> + * $r8 = syscall table
> + */
> +       .type   sys_syscall, #function
> +ENTRY(sys_syscall)
> +       addi    $p1, $r0, #-__NR_syscalls
> +       bgtz    $p1, 3f
> +       move    $p1, $r0
> +       move    $r0, $r1
> +       move    $r1, $r2
> +       move    $r2, $r3
> +       move    $r3, $r4
> +       move    $r4, $r5
> +! add for syscall 6 args
> +       lwi     $r5, [$sp + #SP_OFFSET ]
> +       lwi     $r5, [$r5]
> +! ~add for syscall 6 args
> +
> +       lw      $p1, [tbl+$p1<<2]
> +       jr      $p1
> +3:     b       sys_ni_syscall
> +ENDPROC(sys_syscall)

Can you explain what this is used for?

> --- /dev/null
> +++ b/arch/nds32/kernel/sys_nds32.c
> +
> +long sys_mmap2(unsigned long addr, unsigned long len,
> +              unsigned long prot, unsigned long flags,
> +              unsigned long fd, unsigned long pgoff)
> +{
> +       if (pgoff & (~PAGE_MASK >> 12))
> +               return -EINVAL;
> +
> +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
> +                             pgoff >> (PAGE_SHIFT - 12));
> +}
> +
> +asmlinkage long sys_fadvise64_64_wrapper(int fd, int advice, loff_t offset,
> +                                        loff_t len)
> +{
> +       return sys_fadvise64_64(fd, offset, len, advice);
> +}

You should always use SYSCALL_DEFINE*() macros to define entry points
for your own syscalls in C code for consistency. I also wonder if we should
just move those two into common code, a lot of architectures need the first
one in particular.

        Arnd
