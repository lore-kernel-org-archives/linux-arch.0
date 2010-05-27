From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch/tile: new multi-core architecture for Linux
Date: Thu, 27 May 2010 17:02:45 +0200
Message-ID: <201005271702.45730.arnd@arndb.de>
References: <201005200543.o4K5hFRF006079@farm-0002.internal.tilera.com> <201005271611.47963.arnd@arndb.de> <4BFE831A.8050002@tilera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57009 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687Ab0E0PCv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 May 2010 11:02:51 -0400
In-Reply-To: <4BFE831A.8050002@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Thursday 27 May 2010, Chris Metcalf wrote:
> On 5/27/2010 10:11 AM, Arnd Bergmann wrote:
>
> The issue is that libc support for 64-bit operands on 32-bit platforms
> tends to look like "syscall(foo64, arg1, LOW(arg2), HIGH(arg2))".  This
> naturally passes the arguments in consecutive registers, for a
> register-based calling convention like ours.  However, invoking
> "foo64(arg1, (u64)arg2)" passes the u64 argument in the next consecutive
> even/odd numbered pair of registers on our architecture.  Arguably this
> notion of register alignment isn't particularly helpful, but we opted to
> do it this way when we settled on the API.  The upshot is that to match
> this, userspace needs to do "syscall(foo64, arg1, dummy, LOW(arg2),
> HIGH(arg2))".  So we need to provide these dummy-argument versions of
> the syscall wrappers to all the libcs that we use (currently uclibc,
> glibc, and sometimes newlib).  Where the 64-bit argument falls naturally
> on an even register boundary we don't need to provide any kernel stub.

ok, makes sense. IIRC, the s390 architecture has the same requirement,
probably some others as well.

> Basically the scenario is your #2 above, but userspace already has an
> implementation of the user-space wrapper in the generic code, and I'm
> trying to avoid having to provide a tile-specific version of it.
> 
> For reference, here's readahead() in glibc (overridden to be a pure
> syscall wrapper for 64-bit architectures):
> 
> ssize_t
> __readahead (int fd, off64_t offset, size_t count)
> {
>   return INLINE_SYSCALL (readahead, 4, fd,
>                          __LONG_LONG_PAIR ((off_t) (offset >> 32),
>                                            (off_t) (offset & 0xffffffff)),
>                          count);
> }

Ok, I see. No objection to your kernel code then, we just need to
figure out how to do that with the generic sys_call_table.

	Arnd
