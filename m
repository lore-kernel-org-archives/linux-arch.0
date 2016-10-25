Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34224 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753714AbcJYRK2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2016 13:10:28 -0400
MIME-Version: 1.0
In-Reply-To: <4146248.jXuviLlvH5@wuerfel>
References: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk> <3851270.xZRcP9hae0@wuerfel>
 <20161025091210.rjfhvq4mqtuquei5@tower> <4146248.jXuviLlvH5@wuerfel>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Oct 2016 19:09:36 +0200
Message-ID: <CAMuHMdUdi353sSYwnfk85CnhOkFB5ddE8U2x2Z+yjTCo58s+3A@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: convert to generated system call tables
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Cree <mcree@orcon.net.nz>, Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>
Message-ID: <20161025170936.viN7rVRuP0XPqUVGJpl322lIkh1ZpaDvGBoTXl95350@z>

On Tue, Oct 25, 2016 at 12:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday, October 25, 2016 10:12:10 PM CEST Michael Cree wrote:
>> On Fri, Oct 21, 2016 at 03:06:45PM +0200, Arnd Bergmann wrote:
>> > I see your point, but I think there are serious issues with the current
>> > approach as well:
>> >
>> > - a lot of the less common architectures just don't get updated
>> >   in time, out of 22 architectures that don't use asm-generic/unistd.h,
>> >   only 12 have pwritev2 in linux-next, and only three have pkey_mprotect
>> >
>> > - some architectures that add all syscalls sometimes make a mistake
>> >   and forget one, e.g. alpha apparently never added __NR_bpf, but it
>> >   did add the later __NR_execveat.
>>
>> __NR_bpf was not forgotten on Alpha.  It was not wired up because
>> extra architecture support is needed which has not been implemented.
>>
>> But maybe we should just wire it up to sys_ni_syscall in the meantime
>> so a syscall number is reserved for it, and user space can call it to
>> get -ENOSYS returned.
>
> Ah, I must have misinterpreted the code then. I assumed that the
> bpf syscall always works on all architectures, but that only the
> jit compiler for it required architecture specific code to make it
> more efficient.
>
> The implementation of sys_bfp is compile-time selectable at the moment
> and falls back to sys_no_syscall if CONFIG_BPF_SYSCALL is disabled.
> If it doesn't work on Alpha, maybe that symbol could have a "depends
> on !ALPHA" or "depends on BPF_SUPPORT"?

Yes, BPF should just work (m68k has it).

> sys_seccomp is another one that falls into a similar category, but
> it already depends on HAVE_ARCH_SECCOMP_FILTER, and most other
> architectures have assigned a syscall number but not set this symbol.
> This one will actually allow you to set strict seccomp mode even
> without the Kconfig symbol, just not allow to set a filter.

Seccomp needs architecture support (m68k doesn't have it).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
