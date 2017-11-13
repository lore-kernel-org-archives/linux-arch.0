From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: FW: [PATCH 15/31] nds32: System calls handling
Date: Mon, 13 Nov 2017 12:42:41 +0100
Message-ID: <CAK8P3a0nLTbTE4SuRPVSDKzeOs0TCejfhDA1RccmYVPyWdiHHQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <61b5cd5e7f2cf2f485a990cdf238788b817a1d53.1510118606.git.green.hu@gmail.com>
 <CAK8P3a33noF5+QCe8QsDVb+xpCtgSs-HDUTrO-C3NT0M4W4KUg@mail.gmail.com>
 <E26F4CF8B7DDDB4383A6C2D78D5C3CD56B497241@ATCPCS16.andestech.com> <CAJsyPhzVyV43-N4R+ckXVauceCoeXK24P9Swup2_kpbL866naQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43764 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdKMLmn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Nov 2017 06:42:43 -0500
In-Reply-To: <CAJsyPhzVyV43-N4R+ckXVauceCoeXK24P9Swup2_kpbL866naQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincent Chen <deanbo422@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

On Mon, Nov 13, 2017 at 3:51 AM, Vincent Chen <deanbo422@gmail.com> wrote:
>>>On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>> From: Greentime Hu <greentime@andestech.com>

>
>>> +#define __ARCH_WANT_SYS_CLONE
>>
>>This seems ok, though it would be nice to have the reverse logic and have architectures opt-out of the generic version when they need to provide their own, rather than having most architectures set it.
>>
>
> Thanks
> I will provide nds32 SYSCALL_DEFINE_5(clone) in the next version patch.

That's not what I meant, my suggestion is to create a new patch to remove the
__ARCH_WANT_SYS_CLONE symbol from all architectures, and instead use
something like __ARCH_HAVE_SYS_CLONE on architectures that do *not*
want the generic implementation.

nds32 clearly wants the generic implementation here, it just shouldn't have to
select that symbol to get it.

>>> +/*
>>> + * Special system call wrappers
>>> + *
>>> + * $r0 = syscall number
>>> + * $r8 = syscall table
>>> + */
>>> +       .type   sys_syscall, #function
>>> +ENTRY(sys_syscall)
>>> +       addi    $p1, $r0, #-__NR_syscalls
>>> +       bgtz    $p1, 3f
>>> +       move    $p1, $r0
>>> +       move    $r0, $r1
>>> +       move    $r1, $r2
>>> +       move    $r2, $r3
>>> +       move    $r3, $r4
>>> +       move    $r4, $r5
>>> +! add for syscall 6 args
>>> +       lwi     $r5, [$sp + #SP_OFFSET ]
>>> +       lwi     $r5, [$r5]
>>> +! ~add for syscall 6 args
>>> +
>>> +       lw      $p1, [tbl+$p1<<2]
>>> .+       jr      $p1
>>> +3:     b       sys_ni_syscall
>>> +ENDPROC(sys_syscall)
>>
>>Can you explain what this is used for?
>>
>
> This is used to handle syscall(int number, ....).
> Unlike other architectures,  the system number shall be determined in
> compile time when issuing system call in nds32.
> Therefore, we  only can parse the content of syscall(int number, ....)
> and distribute it to destination handler in kernel space
> (Other architecture can handle it in user space by glibc's syscall wrapper)

Hmm, I think other architectures that run into this problem use self-modifying
code for syscall(), but that is also ugly as it requires having a page that
is both writable and executable.

I think your approach can be tricky for things like seccomp(). It's possible
that you get all of it right, but if you can come up with a different solution,
that might be better.

How much would it cost to simply always pass the syscall number
in a register, and not use the immediate argument at all?

>>> --- /dev/null
>>> +++ b/arch/nds32/kernel/sys_nds32.c
>>> +
>>> +long sys_mmap2(unsigned long addr, unsigned long len,
>>> +              unsigned long prot, unsigned long flags,
>>> +              unsigned long fd, unsigned long pgoff) {
>>> +       if (pgoff & (~PAGE_MASK >> 12))
>>> +               return -EINVAL;
>>> +
>>> +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
>>> +                             pgoff >> (PAGE_SHIFT - 12)); }
>>> +
>>> +asmlinkage long sys_fadvise64_64_wrapper(int fd, int advice, loff_t offset,
>>> +                                        loff_t len) {
>>> +       return sys_fadvise64_64(fd, offset, len, advice); }
>>
>>You should always use SYSCALL_DEFINE*() macros to define entry points for your own syscalls in C code for consistency. I also wonder if we should just move those two into common code, a lot of architectures need the first one in particular.
>>
>
> The sys_fadvise64_64_wrapper is used to reorder the input parameter.
>
> In order to solve register alignment problem, we adjust the input
> parameter order of fadvise64_64 while issuing this syscall.
> Therefore, we need this wrapper to reorder the input parameter to fit
> sys_fadvise64_64's API in kernel.

I understand what it's used for, it's just that I would recommend writing it
differently, as

SYSCALL_DEFINE4(fadvise64_64_wrapper, int, fd, int, advice, loff_t,
offset, loff_t, len)
{
       return sys_fadvise64_64(fd, offset, len, advice);
}

      Arnd
