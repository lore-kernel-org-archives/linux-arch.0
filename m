From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [tile] sys_llseek() can *not* be used as compat_sys_llseek() there
Date: Mon, 25 Feb 2013 00:29:13 +0000
Message-ID: <20130225002913.GW4503@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:50347 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759178Ab3BYA3Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 24 Feb 2013 19:29:16 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

	Unless I'm seriously misreading your code, you have all arguments of
compat syscall sign-extended by asm glue.  If that's the case, consider
what will happen to 32bit binary doing
	llseek(fd, 0, 0xffffffff, &pos, SEEK_CUR)
on 32bit and 64bit hosts resp.  The former will move the current position
by 4Gb forward; the latter - by one byte backwards...

	sys_llseek() will do the right thing for compat on architectures that
zero-extend the arguments of compat syscall; x86/sparc/ppc/arm64 fall into
that category.  mips and (AFAICS) tile do not (and s390 is just plain weird
and needs wrappers for just about everything).  mips has sys_32_llseek() for
a good reason; we probably want to take that into fs/read_write.c, but
on such architectures something *is* needed - plain sys_llseek() won't work...

	FWIW, I suspect that we want __ARCH_COMPAT_ZERO_EXTENDS or
__ARCH_COMPAT_SIGN_EXTENDS defined in asm/compat.h; the need of sys_llseek()
would be "it's 32bit or it has compat and it's zero-extending", while
"has compat and it's not zero-extending" would pick compat_sys_llseek()
instead.  __ARCH_WANT_SYS_LLSEEK shouldn't exist...

	And things like "do we need compat_sys_lseek(), compat_sys_truncate()
and their ilk" could be expressed via those as well - compat && !sign_extends.

	Comments?
