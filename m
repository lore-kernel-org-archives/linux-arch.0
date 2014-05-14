From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/25] Change time_t and clock_t to 64 bit
Date: Wed, 14 May 2014 17:48:33 +0200
Message-ID: <6143833.A3bOpIVfCF@wuerfel>
References: <1399971456-3941-1-git-send-email-lftan@altera.com> <6811994.pqkAjrM8xH@wuerfel> <alpine.DEB.2.02.1405141628130.6261@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:50655 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbaENPs5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 11:48:57 -0400
In-Reply-To: <alpine.DEB.2.02.1405141628130.6261@ionos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@infradead.org>, Ley Foon Tan <lftan@altera.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LeyFoon Tan <lftan.linux@gmail.com>, Chung-Lin Tang <cltang@codesourcery.com>

On Wednesday 14 May 2014 16:46:29 Thomas Gleixner wrote:
> On Wed, 14 May 2014, Arnd Bergmann wrote:
> 
> > On Wednesday 14 May 2014 14:21:48 Thomas Gleixner wrote:
> > > 
> > > So in the 32-on-64 case we'll have two compat variants:
> > > 
> > > SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
> > >                 struct timespec __user *, utime, u32 __user *, uaddr2,
> > >                 u32, val3)
> > > 
> > > COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
> > >                 struct compat_timespec __user *, utime, u32 __user *, uaddr2,
> > >                 u32, val3)
> > > 
> > > COMPAT_SYSCALL_DEFINE6(futex64, u32 __user *, uaddr, int, op, u32, val,
> > >                 struct timespec64 __user *, utime, u32 __user *, uaddr2,
> > >                 u32, val3)
> > > 
> > > The native 64bit futex64 syscall is mapped to futex.
> > 
> > I was actually hoping that we could map the compat futex64 to futex
> > as well here, since 64-bit timespec and compat timespec64 would be
> > the same structure.
> 
> Right, that might work with this one, but not for anything which has a
> pointer to a timespec and some other argument based on long.

We'd have to look at each one individually of course, but out of this
list, I think it will work for most:

   - getitimer/setitimer
   - timer_settime/timer_gettime
   - gettimeofday/settimeofday
   - adjtimex
   - clock_gettime/clock_settime/clock_adjtime
   - time/stime
   - sysv ipc (msg, sem, shm)
   - fstatat (or the statx replacement once we get to that)
   - futimesat

but not these ioctls:

   - socket time stamps
   - audio time stamps
   - v4l time stamps
   - input event time stamps

> > > I'm curious, whether quite some code, like high frequency timestamps
> > > wouldn't be better of with a strict 64 bit nanosecond granular time
> > > represenation.
> > 
> > At least in the kernel, I think ktime_t is already the right type
> > to use on both 64-bit and 32-bit architectures as it can be slow to
> > extract the seconds portion of 64-bit nanoseconds on a 32-bit machine.
> 
> On some of them yes. On i386 the u64 nsec ktime_t variant is way more
> efficient.

Ah, interesting. Do we have actual data for other architectures? If
it's much better on x86 and never much worse anywhere else, that
alone may be a reason to migrate the timestamp interfaces.

	Arnd
