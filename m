Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:57760 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZDBNG1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2009 09:06:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] asm-generic/{unistd,types,posix_types}.h for new arch
Date: Thu, 2 Apr 2009 15:06:12 +0200
References: <49D071A8.4010703@petalogix.com> <49D3DABA.2050001@zytor.com> <20090401213219.7B324FC3AB@magilla.sf.frob.com>
In-Reply-To: <20090401213219.7B324FC3AB@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-ID: <200904021506.13942.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Will Newton <will.newton@gmail.com>, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, michal.simek@petalogix.com, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Chen Liqin <liqin.chen@sunplusct.com>
Message-ID: <20090402130612.1fOxjH9z4U5OJ68iIN_9IOC_LuZqQYMWyNEUFxB9QMw@z>

On Wednesday 01 April 2009, Roland McGrath wrote:
> > Actually, gcc does have the _LP64 and __SIZEOF_POINTER__ macros (as well 
> > as __CHAR_BIT__), although I don't know how far back it does have that. 
> >      If it has been with us for long enough it might be possible to 
> > switch over to using panarch macros.

For user space, we also need to consider non-gcc compilers that could have
a different set of macros. As long as we don't start relying on any new
ones besides those we already use (__x86_64__, __s390x__, __powerpc64__,
__mips64, __arch64__), we at least don't break anything accidentally.

> Worst case the oldest compilers had <limits.h> and 
> "#if ULONG_MAX == 0xffffffffUL", though I wouldn't like
> myself to be using a setup where <limits.h> got pulled in.

That would of course work with non-gcc, but we are really not allowed
to pull in <limits.h> from places like <types.h> where it would be needed
then.

	Arnd <><
