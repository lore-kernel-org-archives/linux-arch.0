From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL, v4] S+core architecture (arch/score) support
Date: Mon, 31 Aug 2009 09:56:33 +0000
Message-ID: <200908310956.33802.arnd@arndb.de>
References: <OF0579E5F2.3B710FBD-ON48257623.002611FB-48257623.002B92AD@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59663 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbZHaJ5n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2009 05:57:43 -0400
In-Reply-To: <OF0579E5F2.3B710FBD-ON48257623.002611FB-48257623.002B92AD@sunplusct.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Monday 31 August 2009 07:48:33 liqin.chen@sunplusct.com wrote:
> Arnd Bergmann <arnd@arndb.de> =D0=B4=D3=DA 2009-08-27 22:00:37:
>=20
> >=20
> > I understand your problem here, and I think it would be good
> > to have second opinion from someone else here. The four
> > #defines you mention are roughly in reverse order of importance.
> >=20
> > I think you really need to remove __ARCH_WANT_SYSCALL_DEPRECATED
> > and get that working. Please tell us if some system call is
> > giving you problems and we can find a solution together.
> >=20
> > Removing __ARCH_WANT_SYSCALL_OFF_T should not be too hard, because
> > glibc uses the loff_t versions by default anyway. I have not tried
> > it though, so it may be more complicated than I thought.
> >=20
>=20
> in __ARCH_WANT_SYSCALL_DEPRECATED,
> asm-generic/unistd.h haven't define __NR_ipc and __NR__llseek
> which used in glibc.

__NR_ipc definitely should not be defined, it is a multiplexer
for other system calls that have their own number, e.g. msgctl
and semop. Look at e.g. how parisc does it in glibc.

I'm not sure what the problem with __NR_llseek could be, AFAICT
it is defined in asm-generic/unistd.h because you take the
default __BITSPERLONG=3D32 definition. You should however not
see __NR_lseek, which is used only on 64 bit systems these days.

> Now we have maintained 3 sets of syscall API code use for glibc.
> 1: Old syscall interface, which linux/score system work well.

Yes, and I guess this will continue to work, but it will never
work with upstream kernels.

> 2: New syscall interface, define all 4 macro __ARCH_WANT_SYSCALL_XXX,
>         linux/score system work now, but we still debug the glibc cod=
e.
> 3: New syscall interface, without define __ARCH_WANT_SYSCALL_DEPRECAT=
ED
>         and __ARCH_WANT_SYSCALL_OFF_T, linux/score system couldn't wo=
rk.
>         because glibc have many place need to fix.

Do you have a patch against the glibc git tree for score so I can look
at what needs to be done? None of the changes should be specific to
score after all, ideally it should all work without any glibc changes,
though I realize that we are not there yet.

	Arnd <><
