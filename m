From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 05/19] csky: System Call
Date: Tue, 3 Jul 2018 21:53:48 +0200
Message-ID: <CAK8P3a3djWfXAKBL6WnJb4t5C2bcYGE-JT+zCoefLBUnksduXw@mail.gmail.com>
References: <cover.1530465325.git.ren_guo@c-sky.com> <1005fef6031efbee4b5041ee286c053dd97670e6.1530465326.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1005fef6031efbee4b5041ee286c053dd97670e6.1530465326.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Sun, Jul 1, 2018 at 7:30 PM, Guo Ren <ren_guo@c-sky.com> wrote:
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

We really need all new architectures to use the generic syscall ABI,
see below for the details.

> diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
> new file mode 100644
> index 0000000..0ea9b5a
> --- /dev/null
> +++ b/arch/csky/include/uapi/asm/unistd.h
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#define __ARCH_WANT_OLD_READDIR
> +#define __ARCH_WANT_RENAMEAT
> +#define __ARCH_WANT_STAT64
> +#define __ARCH_WANT_SYS_ALARM
> +#define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_SYS_FORK
> +#define __ARCH_WANT_SYS_GETHOSTNAME
> +#define __ARCH_WANT_SYS_GETPGRP
> +#define __ARCH_WANT_SYS_IPC
> +#define __ARCH_WANT_SYS_LLSEEK
> +#define __ARCH_WANT_SYS_NICE
> +#define __ARCH_WANT_SYS_OLD_GETRLIMIT
> +#define __ARCH_WANT_SYS_OLDUMOUNT
> +#define __ARCH_WANT_SYS_PAUSE
> +#define __ARCH_WANT_SYS_SIGNAL
> +#define __ARCH_WANT_SYS_SIGPENDING
> +#define __ARCH_WANT_SYS_SIGPROCMASK
> +#define __ARCH_WANT_SYS_SOCKETCALL
> +#define __ARCH_WANT_SYS_TIME
> +#define __ARCH_WANT_SYS_UTIME
> +#define __ARCH_WANT_SYS_VFORK
> +#define __ARCH_WANT_SYS_WAITPID

I think these all need to be removed, with the exception of
__ARCH_WANT_SYS_CLONE. It would be nice though to change
the imlpementation in the kernel so we no longer need to set that
either.

> +#define __NR_set_thread_area   (__NR_arch_specific_syscall + 0)
> +__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
> +#define __NR_ipc               (__NR_arch_specific_syscall + 1)
> +__SYSCALL(__NR_ipc, sys_ipc)
> +#define __NR_socketcall                (__NR_arch_specific_syscall + 2)
> +__SYSCALL(__NR_socketcall, sys_socketcall)
> +#define __NR_ugetrlimit                (__NR_arch_specific_syscall + 3)
> +__SYSCALL(__NR_ugetrlimit, sys_getrlimit)
> +#define __NR_cacheflush                (__NR_arch_specific_syscall + 4)
> +__SYSCALL(__NR_cacheflush, sys_cacheflush)
> +#define __NR_sysfs             (__NR_arch_specific_syscall + 5)
> +__SYSCALL(__NR_sysfs, sys_sysfs)
> +
> +__SYSCALL(__NR_fadvise64_64, sys_csky_fadvise64_64)

We definitely don't want ipc, socketcall, ugetrlimit, or sysfs.

cacheflush is probbably needed.

For fadvise64_64, please redefine the symbol name so the
table points at the right entry.

I'm not completely sure about set_thread_area, can you explain
what you need that for?

> +#define __NR_setgroups32       __NR_setgroups
> +#define __NR_getgid32          __NR_getgid
> +#define __NR_getgroups32       __NR_getgroups
> +#define __NR_setuid32          __NR_setuid
> +#define __NR_setgid32          __NR_setgid
> +#define __NR_getresgid32       __NR_getresgid
> +#define __NR_setfsuid32                __NR_setfsuid
> +#define __NR_setfsgid32                __NR_setfsgid
> +#define __NR_fchown32          __NR_fchown
> +#define __NR_geteuid32         __NR_geteuid
> +#define __NR_getegid32         __NR_getegid
> +#define __NR_getresuid32       __NR_getresuid
> +#define __NR_setresuid32       __NR_setresuid
> +#define __NR_setresgid32       __NR_setresgid
> +#define __NR_setreuid32                __NR_setreuid
> +#define __NR_setregid32                __NR_setregid
> +#define __NR__llseek           __NR_llseek

These should also get removed.

> +struct mmap_arg_struct {
> +       unsigned long addr;
> +       unsigned long len;
> +       unsigned long prot;
> +       unsigned long flags;
> +       unsigned long fd;
> +       unsigned long offset;
> +};
> +
> +SYSCALL_DEFINE1(mmap,
> +       struct mmap_arg_struct *, arg)
> +{
> +       struct mmap_arg_struct a;
> +
> +       if (copy_from_user(&a, arg, sizeof(a)))
> +               return -EINVAL;
> +
> +       if (unlikely(a.offset & ~PAGE_MASK))
> +               return -EINVAL;
> +
> +       return sys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE_SHIFT);
> +}

This can be removed since there is mmap2()

       Arnd
