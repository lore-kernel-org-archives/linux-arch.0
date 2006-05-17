Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:65463 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750716AbWEQQu4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 May 2006 12:50:56 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.6/8.13.6) with ESMTP id k4HGotFC143740
	for <linux-arch@vger.kernel.org>; Wed, 17 May 2006 16:50:55 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4HGqOeV114506
	for <linux-arch@vger.kernel.org>; Wed, 17 May 2006 18:52:24 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id k4HGotVA032522
	for <linux-arch@vger.kernel.org>; Wed, 17 May 2006 18:50:55 +0200
Subject: Re: [patch] s390 kconfig cleanup.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20060517132501.GC1604@parisc-linux.org>
References: <20060515171645.GA11397@skybase>
	 <20060517132501.GC1604@parisc-linux.org>
Content-Type: text/plain
Date: Wed, 17 May 2006 18:50:56 +0200
Message-Id: <1147884656.5540.28.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2006-05-17 at 07:25 -0600, Matthew Wilcox wrote: 
> > The "solution" so far had been to avoid drivers/Kconfig and
> > use a special s390 version in driver/s390/Kconfig which
> > includes some Kconfig files from the drivers directory
> > tree and <copies> a few more config options which are useful
> > for s390.
> 
> Yeah, I noticed that the other day ;-)
> 
> I don't know whether drivers/Kconfig makes sense for S390 since it is
> just so different.  I don't think the problem is really not using
> drivers/Kconfig, it's copying the bits-and-pieces.  And the
> bits-and-pieces seem to be entirely from drivers/char/Kconfig.
> So how about keeping drivers/s390/Kconfig and sanitising
> drivers/char/Kconfig so it's reasonable for you to include it?

Hmm, that way I could pick the directories from drivers/ that s390
wants. The downside is that we might forget new things, e.g. like
the connector support we only recently added. By using drivers/Kconfig
we can avoid that.

> > The attached patch makes s390 use the common drivers/Kconfig
> > and adds a lot of "depends on !S390" to hide all the config
> > options that do not make sense for us. What I think could
> > be improved is the fact that the dependency is negative,
> > that is not-something, it would be much cleaner to have
> > positive dependencies.
> 
> Actually, I think that's the right thing.  By default, new architectures
> should get these options.  They can put in negative dependencies to hide
> them if they want, but by default people should see them.

It does make sense if it is unclear if an architecture does support
some piece of hardware or not. Better would be to have a dependency
on some prereq for the driver to work, e.g. PCI or ISA.

> > That is where the arch people get involved. Can we come
> > up with a method how to "tag" all menus in the Kconfig files
> > under drivers/ with a positive list of the architectures
> > that actually want to include the menu/driver? Or even
> > better tag the menu/driver with the bus that is required
> > to attach the device?
> 
> The problem is that so many of these things are not on a particular kind
> of bus.  They're built-in to the chipset, or they're attached on some
> kind of hidden bus, or they're features of some other chip.  Or they're
> on basically every bus in existence.

Nod, these are the troublesome drivers.

> > @@ -761,7 +763,7 @@ config SGI_IP27_RTC
> >  
> >  config GEN_RTC
> >  	tristate "Generic /dev/rtc emulation"
> > -	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
> > +	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV && !S390
> >  	---help---
> >  	  If you say Y here and create a character special file /dev/rtc with
> >  	  major number 10 and minor number 135 using mknod ("man mknod"), you
> 
> Yeah, the RTC config is a bit of a mess.  That should definitely be
> cleaned up to be positive dependencies.

As I learned from Geert we might actually want GEN_RTC on s390.

> > @@ -814,6 +816,7 @@ config COBALT_LCD
> >  
> >  config DTLK
> >  	tristate "Double Talk PC internal speech card support"
> > +	depends on !S390
> >  	help
> >  	  This driver is for the DoubleTalk PC, a speech synthesizer
> >  	  manufactured by RC Systems (<http://www.rcsys.com/>).  It is also
> 
> This one looks like an ISA card, judging by how the driver's written,
> and also the website above.  So that should be 'depends on ISA'.

Ok, I will change the patch accordingly.

> > @@ -824,6 +827,7 @@ config DTLK
> >  
> >  config R3964
> >  	tristate "Siemens R3964 line discipline"
> > +	depends on !S390
> >  	---help---
> >  	  This driver allows synchronous communication with devices using the
> >  	  Siemens R3964 packet protocol. Unless you are dealing with special
> 
> I'd be tempted to not bother adding a depends here ... it won't do any
> harm; it's not controlling hardware after all.

Seems out of place to me. But we have a bunch of other strange config
options as well, e.g. support for the Amiga AFFS filesystem. Anybody
who wants to attach an Amiga disk to a mainframe?

> Actually, this wants cleaning up for everyone:
> 
> @@ -867,10 +867,10 @@ config TANBAC_TB0219
>         depends TANBAC_TB022X
>  
>  menu "Ftape, the floppy tape device driver"
> +       depends on BROKEN_ON_SMP && (ALPHA || X86)

Ok, will change the patch.

> > @@ -1025,6 +1030,7 @@ source "drivers/char/tpm/Kconfig"
> >  config TELCLOCK
> >  	tristate "Telecom clock driver for MPBL0010 ATCA SBC"
> >  	depends on EXPERIMENTAL
> > +	depends on !S390
> >  	default n
> >  	help
> >  	  The telecom clock device is specific to the MPBL0010 ATCA computer and
> 
> As the description says, it's specific to some embedded junk:
> http://www.intel.com/design/telecom/products/cbp/atca/9445/overview.htm
> 
> so that should be 'depends on X86'.

Same here.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


