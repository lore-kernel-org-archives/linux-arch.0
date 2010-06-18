From: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
Subject: Re: PATCH : cmpxchg does not handle int * arguments on LP64
Date: Fri, 18 Jun 2010 16:37:53 +0200
Message-ID: <1276871873.1999.38.camel@localhost.localdomain>
References: <1276865516.1999.18.camel@localhost.localdomain>
	 <201006181530.30338.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:29734
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933443Ab0FROhz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Jun 2010 10:37:55 -0400
In-Reply-To: <201006181530.30338.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On Fri, 2010-06-18 at 15:30 +0200, Arnd Bergmann wrote:

> > I have been using the asm-generic/system.h header to implement my
> > version of arch/xx/include/asm/system.h: it appears that the version of
> > cmpxchg defined in this generic header does not handle correctly
> > non-long arguments on an LP64 arch. 
> 
> That looks like a correct observation. It's also true on ILP32
> architectures.
> 
> I am not sure though if it is actually supposed to operate on other
> types, I think there was some disagreement on this in the past.
> What code specifically did you find needs to do cmpxchg on non-long
> data?

asm-generic/atomic.h defines atomic_add_unless to use atomic_cmpxchg
which uses cmpxchg and all of that is supposed to work on struct
atomic_t * which contains an int defined in include/linux/types.h

atomic_add_unless is used through atomic_inc_not_zero to do some
refcounting of sockets in the network stack so it did not take me long
to notice that it appeared to not work.

> > -
> > -#define cmpxchg(ptr, o, n)					\
> > -	((__typeof__(*(ptr))) __cmpxchg((unsigned long *)(ptr), \
> > -					(unsigned long)(o),	\
> > -					(unsigned long)(n)))
> > +#define cmpxchg(ptr, o, n) cmpxchg_local(ptr, o, n)
> 
> This seems to match what we have in include/asm-generic/cmpxchg.h.
> Maybe the best option would be to include that in asm-generic/system.h.

This appears to work, indeed.

> Nobody so far is using asm-generic/system.h, not even tile, which
> uses most of the generic headers. This makes it quite likely that
> the file is not correct right now. If you think you can improve it,
> go wild.
> 
> BTW, what architecture are you working on? Is this something you
> plan to submit for inclusion soon?

I am working on a version of the linux kernel network stack which runs
in userspace as a shared library in a network simulator. My 'arch' port
(named sim) provides glue code to replace all the code used by net/ in
kernel/, lib/, crypto/, fs/ et al. The code is pretty rough and just
started to run udp and netlink sockets yesterday but I could post it if
others are interested.

Mathieu
-- 
Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
Tel: +33 4 9238 5056
