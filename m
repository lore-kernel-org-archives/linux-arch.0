Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:65253 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920AbaENOBM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 10:01:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/25] Change time_t and clock_t to 64 bit
Date: Wed, 14 May 2014 16:01:05 +0200
Message-ID: <6811994.pqkAjrM8xH@wuerfel>
In-Reply-To: <alpine.DEB.2.02.1405141359460.6261@ionos.tec.linutronix.de>
References: <1399971456-3941-1-git-send-email-lftan@altera.com> <8468354.y2kUZdOz9e@wuerfel> <alpine.DEB.2.02.1405141359460.6261@ionos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@infradead.org>, Ley Foon Tan <lftan@altera.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LeyFoon Tan <lftan.linux@gmail.com>, Chung-Lin Tang <cltang@codesourcery.com>
Message-ID: <20140514140105.JlFQUZpGOO9DH63glygVnPLwnm9VmRbcKcmw4b97kks@z>

On Wednesday 14 May 2014 14:21:48 Thomas Gleixner wrote:
> 
> So in the 32-on-64 case we'll have two compat variants:
> 
> SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
>                 struct timespec __user *, utime, u32 __user *, uaddr2,
>                 u32, val3)
> 
> COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
>                 struct compat_timespec __user *, utime, u32 __user *, uaddr2,
>                 u32, val3)
> 
> COMPAT_SYSCALL_DEFINE6(futex64, u32 __user *, uaddr, int, op, u32, val,
>                 struct timespec64 __user *, utime, u32 __user *, uaddr2,
>                 u32, val3)
> 
> The native 64bit futex64 syscall is mapped to futex.

I was actually hoping that we could map the compat futex64 to futex
as well here, since 64-bit timespec and compat timespec64 would be
the same structure.

> And for a 32bit kernel you have two
> 
> SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
>                 struct timespec __user *, utime, u32 __user *, uaddr2,
>                 u32, val3)
> 
> SYSCALL_DEFINE6(futex64, u32 __user *, uaddr, int, op, u32, val,
>                 struct timespec64 __user *, utime, u32 __user *, uaddr2,
>                 u32, val3)

And here, we could think about renaming the kernel internal symbols
so that we use the same two definitions as well, one for compat_timespec
and one for timespec64. Those are details we don't need to debate now.

> Fine with me, but we really need to discuss the timespec64 with user
> space folks.

Definitely.

> I'm curious, whether quite some code, like high frequency timestamps
> wouldn't be better of with a strict 64 bit nanosecond granular time
> represenation.

At least in the kernel, I think ktime_t is already the right type
to use on both 64-bit and 32-bit architectures as it can be slow to
extract the seconds portion of 64-bit nanoseconds on a 32-bit machine.
FWIW, 64-bit ns gives us 584 years worth of nanoseconds, which
means none of us or the people we know will be around before this
becomes a problem ;-)

For the user interface, we can decide which representation to use
for each syscall individually depending on the needs. We should just
not have to many different variants. I was going for timespec64
just because that would allow us to keep the 64-bit kernel ABI
unchanged.

> I often enough cursed timespec for clock_nanosleep on an absolute
> timeline. I need to go through all that normalizing stuff instead of
> just doing next_event += 500000;

And all user space needs to do it too.

	Arnd
