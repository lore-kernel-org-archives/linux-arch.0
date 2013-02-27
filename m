From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [tile] sys_llseek() can *not* be used as compat_sys_llseek()
 there
Date: Wed, 27 Feb 2013 13:46:09 -0500
Message-ID: <512E5471.2060908@tilera.com>
References: <20130225002913.GW4503@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:45860 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580Ab3B0SqM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Feb 2013 13:46:12 -0500
In-Reply-To: <20130225002913.GW4503@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On 2/24/2013 7:29 PM, Al Viro wrote:
> 	Unless I'm seriously misreading your code, you have all arguments of
> compat syscall sign-extended by asm glue.  If that's the case, consider
> what will happen to 32bit binary doing
> 	llseek(fd, 0, 0xffffffff, &pos, SEEK_CUR)
> on 32bit and 64bit hosts resp.  The former will move the current position
> by 4Gb forward; the latter - by one byte backwards...

Without testing this (I'm in an airport), I think you might be right.  But the fix seems like it might just be changing the parameters of the llseek syscall in read_write.c to be "unsigned int" for offset_high and offset_low.  That would let the usual syscall-wrappers code properly zero-extend the high bits.

> 	sys_llseek() will do the right thing for compat on architectures that
> zero-extend the arguments of compat syscall; x86/sparc/ppc/arm64 fall into
> that category.  mips and (AFAICS) tile do not (and s390 is just plain weird
> and needs wrappers for just about everything).  mips has sys_32_llseek() for
> a good reason; we probably want to take that into fs/read_write.c, but
> on such architectures something *is* needed - plain sys_llseek() won't work...
>
> 	FWIW, I suspect that we want __ARCH_COMPAT_ZERO_EXTENDS or
> __ARCH_COMPAT_SIGN_EXTENDS defined in asm/compat.h; the need of sys_llseek()
> would be "it's 32bit or it has compat and it's zero-extending", while
> "has compat and it's not zero-extending" would pick compat_sys_llseek()
> instead.  __ARCH_WANT_SYS_LLSEEK shouldn't exist...
>
> 	And things like "do we need compat_sys_lseek(), compat_sys_truncate()
> and their ilk" could be expressed via those as well - compat && !sign_extends.
>
> 	Comments?

Cleanups like these sound generally good.  For tilegx32, for good or bad, we emulated the register allocation conventions of our 32-bit tilepro architecture, so that for example truncate64 has r0 = filename, r1 = dummy, r2+r3 = offset.  This doesn't match what the compiler would generate for a simple "char *, long long" argument pair, since for tilegx32 we (obviously) represent long long as a 64-bit register value in general.  But for new architectures it might be good to look to make changes like those you are suggesting.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
