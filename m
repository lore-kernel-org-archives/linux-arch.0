Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j1A9VsvU194434
	for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2005 09:31:54 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j1A9VsYg180748
	for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2005 10:31:54 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id j1A9VsjF004237
	for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2005 10:31:54 +0100
In-Reply-To: <20050210092159.GB15548@wotan.suse.de>
Subject: Re: Re: [patch] Fix shmget for ppc64, s390-64 & sparc64.
Message-ID: <OF28FFA41F.EF7FB8B5-ON41256FA4.0033B0D5-41256FA4.00345D12@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 10 Feb 2005 10:31:56 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, anton@samba.org, Arnd Bergmann <arnd@arndb.de>, davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen <ak@suse.de> wrote on 10.02.2005 10:21:59:
> > Andrew Morton <akpm@osdl.org> schrieb am 09.02.2005, 23:50:37:
> > > Martin Schwidefsky  wrote:
> > > >
> > > > [patch] Fix shmget for ppc64, s390-64 & sparc64.
> > >
> > > OK, but Andi's patch fixed mips and x86_64 as well, but only for
> > > compat_shmget and not for sys_msgsnd and sys_msgrcv.
> >
> > mips, x86_64, ia64 and parisc always got this right, they are not
> > using sys_ipc in 64 bit mode. The rest is 32 bit only, so the fix
> > is not needed either.
>
> Sorry, someone is confused here.
>
> The patch was explicitely to fix the 32bit emulation.   The problem was
> reported on x86-64 for a 32bit program.

Yes sure. Arnd has been taking about the native 64 bit ipc system
calls, not the 32 bit emulation.

> The 32bit emulation layer for sys_ipc() would incorrectly sign extend the
> passed shared memory size when converting the argument to the native
> sys_shmget()
>
> I think you need it even for s390 - even though you don't have more than
> 2GB someone could still pass a bigger size and then get the wrong
> errno.

Well, it certainly doesn't break anything to have the correct sign
extension but I still think it not needed. If the sign bit is set the
value gets converted into something HUGE. If it is only a little bit
too big or way too big doesn't matter.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
