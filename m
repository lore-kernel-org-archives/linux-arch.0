Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:36776 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbXFPSU7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 16 Jun 2007 14:20:59 -0400
Subject: Re: [PATCH] Wire up sys_sync_file_range() on powerpc
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1181992681.25228.683.camel@pmac.infradead.org>
References: <1181992681.25228.683.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sat, 16 Jun 2007 19:20:44 +0100
Message-Id: <1182018044.2808.75.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: paulus@samba.org
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, rmk@arm.linux.org.uk, torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 2007-06-16 at 12:18 +0100, David Woodhouse wrote:
> Every time I build a ppc kernel it bitches at me that
> sys_sync_file_range is unimplemented. Shut it up...
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> ---
> The compat bit is untested although the assembly looks right, when
> compared with 32-bit calls to sys_sync_file_range(). Test kernel
> building now, although I leave for the airport within 24 hours and may
> not get round to actually testing it. 

+asmlinkage long compat_sys_sync_file_range(int fd, int dummy,
+                                  unsigned offset_hi, unsigned offset_lo,
+                                  unsigned nbytes_hi, unsigned nbytes_lo,
+                                  int flags)

Pants. It doesn't work because the 'flags' argument ends up in r9, and
we can only use r3-r8 for syscall arguments. We'll need to do it the
same way as ARM does, with the flags as the second argument.

I _wish_ people would remember that not all the world's an i386 when
they add new syscalls.

And I wish Linus would refuse to merge anything which just says "I wired
it up on i386" without even thinking about 32-on-64 compatibility.
Once we've merged it, it's too late to change the ABI to be sane.

Or is it? Can we ditch sys_sync_file_range now and implement a new
sys_sync_file_range2 with the two 32-bit arguments first?

-- 
dwmw2

