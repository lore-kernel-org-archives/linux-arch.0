From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [tile] sys_llseek() can *not* be used as compat_sys_llseek()
 there
Date: Wed, 27 Feb 2013 19:41:57 +0000
Message-ID: <20130227194156.GQ4503@ZenIV.linux.org.uk>
References: <20130225002913.GW4503@ZenIV.linux.org.uk>
 <512E5471.2060908@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:42575 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104Ab3B0Tl6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Feb 2013 14:41:58 -0500
Content-Disposition: inline
In-Reply-To: <512E5471.2060908@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Feb 27, 2013 at 01:46:09PM -0500, Chris Metcalf wrote:
> On 2/24/2013 7:29 PM, Al Viro wrote:
> > 	Unless I'm seriously misreading your code, you have all arguments of
> > compat syscall sign-extended by asm glue.  If that's the case, consider
> > what will happen to 32bit binary doing
> > 	llseek(fd, 0, 0xffffffff, &pos, SEEK_CUR)
> > on 32bit and 64bit hosts resp.  The former will move the current position
> > by 4Gb forward; the latter - by one byte backwards...
> 
> Without testing this (I'm in an airport), I think you might be right.  But the fix seems like it might just be changing the parameters of the llseek syscall in read_write.c to be "unsigned int" for offset_high and offset_low.  That would let the usual syscall-wrappers code properly zero-extend the high bits.

... and screw binary compatibility on 64bit architectures that have llseek(2).
I also thought that there's no such thing - after all, any such architecture
has perfectly usable lseek(2).  No such luck - parisc64, ppc64, sparc64, s390x
and sh64 all have both of those.  AFAICS, glibc does not use llseek(2) on any
of those and any userland code directly using that syscall would be rather
dumb, but then this is precisely the sort of userland code likely to screw
it up.

I don't know; it's a borderline case, but strictly speaking we would be
breaking syscall ABI compatibility on those architectures by doing that.
OTOH, the real rule is more squishy - "don't break real userland code",
so...  Hell knows.

Linus, do you have any comments on that proposal?  Basically, that would make
sys_llseek() ignore upper 32 bits of offset_low on 64bit targets.  Benefit:
fixes bug in tile compat, removes the need of compat wrapper on mips, slightly
simpler rules for populating compat syscall tables.  Cost: changes behaviour
of llseek(2) for 64bit binaries on parisc, ppc, sparc, s390, sh64.  AFAIK,
glibc ignores that syscall on those targets, so affected userland would have
to do it manually via syscall(__NR_llseek,...).

TBH, I'd rather solve it by providing a mips-style wrapper for tile, but...
