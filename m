Return-Path: <rusty@rustcorp.com.au>
Received: from ozlabs.org ([203.10.76.45]:19895 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264344AbUEEJdv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2004 05:33:51 -0400
Subject: Re: static DEFINE_PER_CPU vs. modules
From: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <200405051021.13944.arnd@arndb.de>
References: <200405031741.52504.arnd@arndb.de>
	 <20040504122352.2b554573.akpm@osdl.org>
	 <16535.62156.173458.969241@napali.hpl.hp.com>
	 <200405051021.13944.arnd@arndb.de>
Content-Type: text/plain
Message-Id: <1083749604.14112.36.camel@bach>
Mime-Version: 1.0
Date: Wed, 05 May 2004 19:33:24 +1000
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>, davidm@napali.hpl.hp.com, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2004-05-05 at 18:21, Arnd Bergmann wrote:
> On Tuesday 04 May 2004 21:45, David Mosberger wrote:
> >   Andrew> But then things will work OK on x86 but there's a risk that
> >   Andrew> s390 will see duplicated symbols at link-time.  Admittedly
> >   Andrew> the risk is pretty low, but in that case the risk is also
> >   Andrew> low on other architectures, so they can live with making the
> >   Andrew> symbols global.
> > 
> >   Andrew> What's the concern?  Just the tidiness thing?
> > 
> > It's wrong to change the kernel just because it happens to be the easy
> > way out.

Arnd,

	I agree with David Mosberger-Tang.  If there is no simpler way, do what
other archs do: make your module_alloc() allocate in a restricted
range.  Then have your own setup_per_cpu_areas() allocate from that
space, too, at boot.

This will solve the problem.  I realized this might be an issue when I
wrote this code, but wasn't aware of an existing arch which required it.

Hope that helps (took some time off, sorry for delayed response)
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell
