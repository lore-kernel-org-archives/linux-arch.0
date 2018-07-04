From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 05/19] csky: System Call
Date: Wed, 4 Jul 2018 23:04:37 +0200
Message-ID: <CAK8P3a38u4=m2Zvn5a607PFZXtGYjQKZRAFr2tbgQFuqMmz6xQ@mail.gmail.com>
References: <cover.1530465325.git.ren_guo@c-sky.com> <1005fef6031efbee4b5041ee286c053dd97670e6.1530465326.git.ren_guo@c-sky.com>
 <CAK8P3a3djWfXAKBL6WnJb4t5C2bcYGE-JT+zCoefLBUnksduXw@mail.gmail.com> <20180704114952.GB22857@guoren>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180704114952.GB22857@guoren>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 4, 2018 at 1:49 PM, Guo Ren <ren_guo@c-sky.com> wrote:

>
>> > +#define __NR_set_thread_area   (__NR_arch_specific_syscall + 0)
>> > +__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
>> > +#define __NR_ipc               (__NR_arch_specific_syscall + 1)
>> > +__SYSCALL(__NR_ipc, sys_ipc)
>> > +#define __NR_socketcall                (__NR_arch_specific_syscall + 2)
>> > +__SYSCALL(__NR_socketcall, sys_socketcall)
>> > +#define __NR_ugetrlimit                (__NR_arch_specific_syscall + 3)
>> > +__SYSCALL(__NR_ugetrlimit, sys_getrlimit)
>> > +#define __NR_cacheflush                (__NR_arch_specific_syscall + 4)
>> > +__SYSCALL(__NR_cacheflush, sys_cacheflush)
>> > +#define __NR_sysfs             (__NR_arch_specific_syscall + 5)
>> > +__SYSCALL(__NR_sysfs, sys_sysfs)
>> > +
>> > +__SYSCALL(__NR_fadvise64_64, sys_csky_fadvise64_64)
>>
>> We definitely don't want ipc, socketcall, ugetrlimit, or sysfs.
> Ok, remove them.
>
>> For fadvise64_64, please redefine the symbol name so the
>> table points at the right entry.
> We need exchange the args for abiv1. loff_t is 64bit and abiv1 need
> 8-bytes align in args.
> /*
>  * for abiv1 the 64bits args should be even th, So we need mov the advice forward.
>  */
> SYSCALL_DEFINE4(csky_fadvise64_64,
>         int, fd,
>         int, advice,
>         loff_t, offset,
>         loff_t, len)
> {
>         return sys_fadvise64_64(fd, offset, len, advice);
> }

Right, I do understand what it's used for, my point was that you
don't really need a separate system call number for it, just redirect
the entry point using the same trick that nds32 has in
arch/nds32/kernel/syscall_table.c:

#define sys_fadvise64_64 csky_fadvise64_64

>> I'm not completely sure about set_thread_area, can you explain
>> what you need that for?
> In abiv1 there is no tls register, so we use "trap 3" for csky_get_tls
> defined in arch/csky/kernel/entry.S to get tls.
>
> Also we use set_thread_area to set tls in kernel.
>
> For abiv2 it has r31 for tls-reg, but we still keep the mechanism.

ok.

            Arnd
