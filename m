Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64680 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab1HMV0c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Aug 2011 17:26:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH resend] asm/types.h: All architectures use int-ll64.h in kernelspace
Date: Sat, 13 Aug 2011 23:25:59 +0200
Message-ID: <1665974.2LGtkbyJmJ@wuerfel>
In-Reply-To: <alpine.DEB.2.00.1108132152050.18053@ayla.of.borg>
References: <alpine.DEB.2.00.1108132152050.18053@ayla.of.borg>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-ID: <20110813212559.YGQkEQwu4U-vL7JdGLgFBCInSApJHHAGWJ3gogNehqI@z>

On Saturday 13 August 2011 21:53:43 Geert Uytterhoeven wrote:
> Now all 64-bit architectures have been converted to int-ll64.h, we can
> deprecate int-l64.h in kernelspace:
>   - Add a check to prevent new architectures from using int-l64.h in
>     kernelspace,
>   - Update documentation, as the casts to (unsigned) long long are no longer
>     needed.
> 
> For backwards compatibility, alpha, ia64, mips, and powerpc still use
> int-l64.h in userspace.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> For the documentation parts:
> Acked-by: Randy Dunlap <rdunlap@xenotime.net>

I believe that Al Viro is working on a patch to unify all umode_t definitions
so that it becomes unsigned short everywhere. Once that is done,
asm-generic/int-ll64.h can become asm-generic/types.h and all architectures
can use that.

	Arnd
