Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:55436 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S932267AbWEQNZC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 May 2006 09:25:02 -0400
Date: Wed, 17 May 2006 07:25:01 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch] s390 kconfig cleanup.
Message-ID: <20060517132501.GC1604@parisc-linux.org>
References: <20060515171645.GA11397@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515171645.GA11397@skybase>
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, May 15, 2006 at 07:16:45PM +0200, Martin Schwidefsky wrote:
> I tried once again to clean up the Kconfig files for s390.
> We do not use drivers/Kconfig so far because this creates
> a lot of config options that make absolutely no sense for
> s390. The hardware for whole families of drivers, e.g.
> IPMI, TPM, I2C, I2O, ATA, IEEE1394, ISDN, etc, do not exist
> and very likely will never exist on a s390.
> 
> The "solution" so far had been to avoid drivers/Kconfig and
> use a special s390 version in driver/s390/Kconfig which
> includes some Kconfig files from the drivers directory
> tree and <copies> a few more config options which are useful
> for s390.

Yeah, I noticed that the other day ;-)

I don't know whether drivers/Kconfig makes sense for S390 since it is
just so different.  I don't think the problem is really not using
drivers/Kconfig, it's copying the bits-and-pieces.  And the
bits-and-pieces seem to be entirely from drivers/char/Kconfig.
So how about keeping drivers/s390/Kconfig and sanitising
drivers/char/Kconfig so it's reasonable for you to include it?

> The attached patch makes s390 use the common drivers/Kconfig
> and adds a lot of "depends on !S390" to hide all the config
> options that do not make sense for us. What I think could
> be improved is the fact that the dependency is negative,
> that is not-something, it would be much cleaner to have
> positive dependencies.

Actually, I think that's the right thing.  By default, new architectures
should get these options.  They can put in negative dependencies to hide
them if they want, but by default people should see them.

> That is where the arch people get involved. Can we come
> up with a method how to "tag" all menus in the Kconfig files
> under drivers/ with a positive list of the architectures
> that actually want to include the menu/driver? Or even
> better tag the menu/driver with the bus that is required
> to attach the device?

The problem is that so many of these things are not on a particular kind
of bus.  They're built-in to the chipset, or they're attached on some
kind of hidden bus, or they're features of some other chip.  Or they're
on basically every bus in existence.

> @@ -713,7 +715,7 @@ config NVRAM
>  
>  config RTC
>  	tristate "Enhanced Real Time Clock Support"
> -	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM
> +	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM && !S390
>  	---help---
>  	  If you say Y here and create a character special file /dev/rtc with
>  	  major number 10 and minor number 135 using mknod ("man mknod"), you
> @@ -761,7 +763,7 @@ config SGI_IP27_RTC
>  
>  config GEN_RTC
>  	tristate "Generic /dev/rtc emulation"
> -	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
> +	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV && !S390
>  	---help---
>  	  If you say Y here and create a character special file /dev/rtc with
>  	  major number 10 and minor number 135 using mknod ("man mknod"), you

Yeah, the RTC config is a bit of a mess.  That should definitely be
cleaned up to be positive dependencies.

> @@ -814,6 +816,7 @@ config COBALT_LCD
>  
>  config DTLK
>  	tristate "Double Talk PC internal speech card support"
> +	depends on !S390
>  	help
>  	  This driver is for the DoubleTalk PC, a speech synthesizer
>  	  manufactured by RC Systems (<http://www.rcsys.com/>).  It is also

This one looks like an ISA card, judging by how the driver's written,
and also the website above.  So that should be 'depends on ISA'.

> @@ -824,6 +827,7 @@ config DTLK
>  
>  config R3964
>  	tristate "Siemens R3964 line discipline"
> +	depends on !S390
>  	---help---
>  	  This driver allows synchronous communication with devices using the
>  	  Siemens R3964 packet protocol. Unless you are dealing with special

I'd be tempted to not bother adding a depends here ... it won't do any
harm; it's not controlling hardware after all.

> @@ -867,6 +871,7 @@ config TANBAC_TB0219
>  	depends TANBAC_TB022X
>  
>  menu "Ftape, the floppy tape device driver"
> +	depends on !S390
>  
>  config FTAPE
>  	tristate "Ftape (QIC-80/Travan) support"

Actually, this wants cleaning up for everyone:

@@ -867,10 +867,10 @@ config TANBAC_TB0219
        depends TANBAC_TB022X
 
 menu "Ftape, the floppy tape device driver"
+       depends on BROKEN_ON_SMP && (ALPHA || X86)
 
 config FTAPE
        tristate "Ftape (QIC-80/Travan) support"
-       depends on BROKEN_ON_SMP && (ALPHA || X86)
        ---help---
          If you have a tape drive that is connected to your floppy
          controller, say Y here.


> @@ -1025,6 +1030,7 @@ source "drivers/char/tpm/Kconfig"
>  config TELCLOCK
>  	tristate "Telecom clock driver for MPBL0010 ATCA SBC"
>  	depends on EXPERIMENTAL
> +	depends on !S390
>  	default n
>  	help
>  	  The telecom clock device is specific to the MPBL0010 ATCA computer and

As the description says, it's specific to some embedded junk:
http://www.intel.com/design/telecom/products/cbp/atca/9445/overview.htm

so that should be 'depends on X86'.

