From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH/RFC 01/16] compat: let architectures define __ARCH_WANT_COMPAT_SYS_GETDENTS64
Date: Thu, 20 Mar 2014 11:29:33 -0400
Message-ID: <532B095D.9010704@tilera.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com> <1394121083-2507-2-git-send-email-heiko.carstens@de.ibm.com> <CAMuHMdUqjhcmaRo-2=qr_DgbXoj9bAGfvzuRPDZ+tOMx6Hvr-Q@mail.gmail.com> <20140320113333.GD4403@osiris> <20140320145128.GE4403@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:59783 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932796AbaCTP3f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Mar 2014 11:29:35 -0400
In-Reply-To: <20140320145128.GE4403@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linux-Arch <linux-arch@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Linux-Next <linux-next@vger.kernel.org>

On 3/20/2014 10:51 AM, Heiko Carstens wrote:
> I think the simple patch below should fix the compile error.
> Unfortunately I don't have a tile cross compiler.
>
> But at least s390, x86_64, sparc64 and mip64 still compile, so it
> looks like I'm not immediatly lost in include order hell.
>
> (pushed to the s390 compat branch, so the next linux-next release
>  should contain the fix)
>
> From f80f4cd232c56f491ecbeea3dd0627598b59b61e Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Thu, 20 Mar 2014 15:30:14 +0100
> Subject: [PATCH] compat: include linux/unistd.h within linux/compat.h
>
> linux/compat.h does not include linux/unistd.h but the compat.h header
> file contains various conditional
>
>  #ifdef __ARCH_WANT_COMPAT_...
>  asmlinkage long compat...()
>  #endif
>
> compat system call function declarations.
> If linux/unistd.h isn't included it depends on previous includes if those
> __ARCH_WANT_COMPAT_... defines are defined or not. So add an additional
> linux/unistd.h include.
>
> Should fix this compile error on tile:
>
> include/uapi/asm-generic/unistd.h:195:1: error: 'compat_sys_getdents64' undeclared
> make[3]: *** [arch/tile/kernel/compat.o] Error 1
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

This does fix the error on tilegx.  Thanks.

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
