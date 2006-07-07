Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:19407 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932280AbWGGT1t (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2006 15:27:49 -0400
Date: Fri, 7 Jul 2006 12:27:24 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Kconfig] add disable command (was Re: [patch] s390 kconfig
 cleanup, 2nd version).
Message-Id: <20060707122724.a7b5243c.akpm@osdl.org>
In-Reply-To: <1152289148.6390.11.camel@localhost>
References: <1151670404.11575.5.camel@localhost>
	<20060630104103.0b394b20.akpm@osdl.org>
	<1152289148.6390.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: linux-arch@vger.kernel.org, ak@suse.de, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 07 Jul 2006 18:19:08 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Fri, 2006-06-30 at 10:41 -0700, Andrew Morton wrote:
> > Even better would be to teach the Kconfig sytem about this, so in
> > arch/s390/Kconfig we do
> > 
> > disable	VT
> > 
> > and the Kconfig system knows not to offer VT, so there's no need to go
> > adding `depends on !DISABLE_foo' all over the place.  The above DISABLE_foo
> > convention just simulates that missing feature.
> > 
> > 
> > > +	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM && !S390
> > 
> > Imagine not having crud like this in there.
> 
> I've given this a try and implemented the "disable" command. Seems to
> work fine for me. The command would certainly make my life easier in
> regard to the s390 Kconfig stuff.

Neat.  Now we all need to cower in fear at Roman's reaction ;)

One would expect that doing "/VGA_CONSOLE" in menuconfig would answer the
question "ytf can't I enable VGA_CONSOLE".
