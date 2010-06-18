From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: PATCH : cmpxchg does not handle int * arguments on LP64
Date: Fri, 18 Jun 2010 15:30:30 +0200
Message-ID: <201006181530.30338.arnd@arndb.de>
References: <1276865516.1999.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55716 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758413Ab0FRNaf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2010 09:30:35 -0400
In-Reply-To: <1276865516.1999.18.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Lacage <mathieu.lacage@sophia.inria.fr>
Cc: linux-arch@vger.kernel.org

On Friday 18 June 2010, Mathieu Lacage wrote:
> I have been using the asm-generic/system.h header to implement my
> version of arch/xx/include/asm/system.h: it appears that the version of
> cmpxchg defined in this generic header does not handle correctly
> non-long arguments on an LP64 arch. 

That looks like a correct observation. It's also true on ILP32
architectures.

I am not sure though if it is actually supposed to operate on other
types, I think there was some disagreement on this in the past.
What code specifically did you find needs to do cmpxchg on non-long
data?

> -
> -#define cmpxchg(ptr, o, n)					\
> -	((__typeof__(*(ptr))) __cmpxchg((unsigned long *)(ptr), \
> -					(unsigned long)(o),	\
> -					(unsigned long)(n)))
> +#define cmpxchg(ptr, o, n) cmpxchg_local(ptr, o, n)

This seems to match what we have in include/asm-generic/cmpxchg.h.
Maybe the best option would be to include that in asm-generic/system.h.

Nobody so far is using asm-generic/system.h, not even tile, which
uses most of the generic headers. This makes it quite likely that
the file is not correct right now. If you think you can improve it,
go wild.

BTW, what architecture are you working on? Is this something you
plan to submit for inclusion soon?

	Arnd
