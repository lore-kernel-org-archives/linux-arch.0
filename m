From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Drop IPC_OLD for direct ipc syscalls? (was: Re: [PATCH v2 3/4] m68k:
 Wire up direct ipc calls)
Date: Sun, 20 Sep 2015 11:07:28 +0200
Message-ID: <CAMuHMdW-w6yMDcgK-T38n45c1rURPHsVw+SwULjbgoG7d1HOOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35570 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbbITJH3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 20 Sep 2015 05:07:29 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Greg Ungerer <gerg@uclinux.org>, Linux/m68k <linux-m68k@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>

Hi Andreas,

On Thu, Sep 17, 2015 at 5:39 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > > > > It would be nice if the direct syscalls would drop the use of
> > > > > ipc_parse_version.  Currently, apart from going through the ipc
> > > > > multiplexer, the semctl, shmctl and msgctl wrappers in libc need to add
> > > > > the IPC_64 bit to the cmd operand.  If that would be implied then no
> > > > > special wrappers would be needed any more for direct syscalls.
> > > >
> > > > You mean that we should drop "select ARCH_WANT_IPC_PARSE_VERSION",
> > > > but we can't do that because an indirect call through sys_ipc() would
> > > > still need it when dispatching to sys_{sem,shm,msg}ctl()?
> > >
> > > Yes.  But all architectures that currently use both sys_ipc and
> > > ARCH_WANT_IPC_PARSE_VERSION would benefit from decoupling it when they
> > > add the direct syscalls.
> >
> > Do we currently have architectures that use both sys_ipc and the direct
> > syscalls, where keeping ipc_parse_version() in the direct syscalls is
> > required?
>
> IMHO it doesn't make sense to suport IPC_OLD via the direct syscalls,
> even for those architectures that started with them in the first place.
> There are quite a few architectures that define
> ARCH_WANT_IPC_PARSE_VERSION even though they started life after IPC_64
> was added.  They probably just forgot to adjust ipc/util.h back then.

Thanks!

I had a quick look at the code, but I'm not feeling sufficiently familiar with
the (g)libc interaction to cook up a patch dropping ipc_parse_version() from
direct ipc calls.

Should I postpone wiring up the direct ipc syscalls on m68k (and thus renumber
__NR_membarrier) until the above is resolved, or can they go in in v4.3?

I guess the same is true for x86-32.

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
