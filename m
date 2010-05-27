From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch/tile: new multi-core architecture for Linux
Date: Thu, 27 May 2010 22:53:06 +0200
Message-ID: <201005272253.07498.arnd@arndb.de>
References: <201005200543.o4K5hFRF006079@farm-0002.internal.tilera.com> <201005271041.30519.arnd@arndb.de> <20100527203412.GB31920@shareable.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60015 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab0E0UxY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 May 2010 16:53:24 -0400
In-Reply-To: <20100527203412.GB31920@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Chris Metcalf <cmetcalf@tilera.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Thursday 27 May 2010 22:34:12 Jamie Lokier wrote:
> > > > compat_sys_sendfile will not be needed with the asm-generic/unistd.h definitions,
> > > > but I think you will still need a compat_sys_sendfile64, to which the same
> > > > applies as to compat_sys_sched_rr_get_interval.
> > > >   
> > > 
> > > I think it's the other way around: compat_sys_sendfile64() is just
> > > sys_sendfile64(), but compat_sys_sendfile() needs to exist since it has
> > > to write a 32-bit pointer back to userspace.
> > 
> > Ah. I guess you're right about compat_sys_sendfile64 not being needed.
> > Funny enough, parisc, powerpc, s390 and sparc all define it anyway, so
> > it didn't occur to me that they don't actually need to.
> 
> They do need it.
> 
> For example, on Sparc, compat_sys_sendfile64 takes a 32-bit
> compat_size_t argument, and calls sys_sendfile64 with a 64-bit size_t
> argument.

But size_t is unsigned and the upper halves of the argument registers
are always zero-filled in the sparc64 compat syscall entry, so I guess the
conversion is still not necessary there.

PowerPC probably still needs it but doesn't need to do the nasty set_fs()
stuff. s390x needs a proper assembly wrapper and parisc uses the same
method as sparc64 IIRC.

mips and x86 already just call the native sendfile64 syscall.

> I'll be very surprised if 32-bit tile is using 64-bit size_t already :-)

 ** Surprise! **

Chris mentioned that the tile compat support is not actually for the
native 32 bit ABI but for a third ILP32 ABI of the 64 bit Tile-GX
processors. I assume all registers in this mode are 64 bit, and so are the
syscall arguments.

	Arnd
