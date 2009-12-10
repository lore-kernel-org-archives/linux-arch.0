From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: What's in asm-generic.git
Date: Thu, 10 Dec 2009 22:10:11 +0100
Message-ID: <200912102210.12124.arnd@arndb.de>
References: <OF24184D8B.2F7F8AA9-ON48257685.002069EF-48257685.00207E45@sunplusct.com> <200912071614.46166.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54659 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759417AbZLJVKL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 16:10:11 -0500
In-Reply-To: <200912071614.46166.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Frysinger <vapier.adi@gmail.com>

On Monday 07 December 2009, Arnd Bergmann wrote:
> On Monday 07 December 2009, liqin.chen@sunplusct.com wrote:
> > Arnd Bergmann <arnd@arndb.de> =D0=B4=D3=DA 2009-12-04 03:14:08:
> >=20
> > Maybe you can add a __NR_set_thread_area define in asm-generic/unsi=
td.h
> > for tls used.
>=20
> Yes, good point. I'll update the syscall list with this, and also che=
ck if more
> syscalls have been addded.

I have found now that sys_accept4 was missing. sys_set_thread_area howe=
ver
is only defined on x86 and mips. Since you don't currently implement th=
is
on score, maybe it would be more appropriate to handle it like the othe=
r
architectures do, rather than adding it to asm-generic/unistd.h?

	Arnd
