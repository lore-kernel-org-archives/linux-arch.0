From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3] asm-generic: add a generic uaccess.h
Date: Fri, 1 May 2009 16:06:04 +0200
Message-ID: <200905011606.05319.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <200905011513.25344.arnd@arndb.de> <49FAFD63.2080102@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53997 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbZEAOGI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 10:06:08 -0400
In-Reply-To: <49FAFD63.2080102@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu
Cc: linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>

On Friday 01 May 2009, Michal Simek wrote:
> Arnd Bergmann wrote:
> > +
> > +#include <asm/segment.h>
> > +
> > +#ifndef get_fs
> > +#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
> 
> one line above -> get_fs could be defined in different space
> and this arch could use MAKE_MM_SEG too -> for example powerpc.

I don't think I understand what you are trying to tell me.
How do you think this should look?

> > +
> > +#define VERIFY_READ	0
> > +#define VERIFY_WRITE	1
> > +
> 
> 
> Not sure if any arch do READ/WRITE check but if yes.

I could not find any architecture using it either, but the
API is defined this way.

> #ifndef access_ok
> 
> > +#define access_ok(type, addr, size) __access_ok((unsigned long)(addr),(size))
> 
> #endif

right, will change.

> > +
> > +/*
> > + * The architecture should really override this if possible, at least
> > + * doing a check on the get_fs()
> > + */
> 
> If they should really override it but why write it here.

Mostly for documentation purposes, so that an architecture maintainer
can copy the prototype. I see the asm-generic headers as both fallbacks
for architectures and as templates of what should be implemented.

> > +#define get_user(x, ptr)					\
> > +({								\
> > +	might_sleep();						\
> > +	__access_ok(ptr, sizeof (*ptr)) ?			\
> > +		__get_user(x, ptr) :				\
> > +		-EFAULT;					\
> > +})
> 
> I am getting here (for put_user macro too) any error on noMMU. :-(

What kind of error do you see?
 
> > +static inline long
> > +strncpy_from_user(char *dst, const char __user *src, long count)
> > +{
> > +	if (!__access_ok(src, 1))
> > +		return -EFAULT;
> > +	return __strncpy_from_user(dst, src, count);
> > +}
> 
> Is it a good place to add might_sleep() and unlikely(+ some other cases) too?
> We have almost the same code.

Yes, I think so. The unlikely() can probably go into __access_ok() though,
so we don't have to write it every time.

	Arnd <><
