From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] tile: work around bug in the generic sys_llseek
Date: Mon, 4 Mar 2013 16:54:10 +0000
Message-ID: <20130304165410.GS4503@ZenIV.linux.org.uk>
References: <20130227194156.GQ4503@ZenIV.linux.org.uk>
 <201303041627.r24GR7Ql032052@farm-0021.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34250 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756866Ab3CDQyN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Mar 2013 11:54:13 -0500
Content-Disposition: inline
In-Reply-To: <201303041627.r24GR7Ql032052@farm-0021.internal.tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Mar 04, 2013 at 11:19:09AM -0500, Chris Metcalf wrote:
> sys_llseek should specify the high and low 32-bit seek values as "unsigned
> int" but instead it specifies "unsigned long".  Since compat syscall
> arguments are always sign-extended on tile, this means that a seek value
> of 0xffffffff will be incorrectly interpreted as a value of -1ULL.
> 
> To avoid the risk of breaking binary compatibility on architectures
> that already use sys_llseek this way, we follow the same path as MIPS
> and provide a wrapper override.
> 
> Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
> Cc: stable@kernel.org [v3.6 onwards]
> ---
> Al Viro suggested changing the generic implementation but there has
> been no followup, and his preference was just fixing tile anyway,
> so this is what this patch does.  Al, can you ack this if it looks OK?
> The generated code for compat_sys_llseek just clears the high 32 bits
> of the two offset parameters and jumps to sys_llseek.

That's not enough - the reason why mips variant works is that they
use SYSCALL_DEFINE, which casts the sucker down to unsigned int.  Simply
declaring it as something that takes unsigned int will just tell the
compiler that upper bits of register are all zero, so it's free to pass
the damn thing unchanged.

Explicit cast down (for old versions) or use of COMPAT_SYSCALL_DEFINE would
work; longer term I'd prefer to have something (select or explicit defines
in asm/compat.h) telling whether we have a sign-extending or zero-extending
biarch and have that COMPAT_SYSCALL_DEFINE in fs/read_write.c, under ifdef
for arch being a sign-extender, but that's the next cycle fodder and can
be done on top of minimal (and easier backportable) fix.
