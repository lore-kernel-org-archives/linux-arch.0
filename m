From: wfp5p@viridian.itc.virginia.edu (Bill Pemberton)
Subject: Re: [PATCH 022/493] ARM: remove CONFIG_HOTPLUG ifdefs
Date: Wed, 21 Nov 2012 13:35:25 -0500
Message-ID: <20121121183525.BF1118013C@viridian.itc.virginia.edu>
References: <20121121114419.GB3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:46248 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524Ab2KUSf0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Nov 2012 13:35:26 -0500
In-Reply-To: <20121121114419.GB3290@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org

Russell King - ARM Linux writes:
> 
> > diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> > index b9f38e3..38279fe 100644
> > --- a/arch/arm/kernel/vmlinux.lds.S
> > +++ b/arch/arm/kernel/vmlinux.lds.S
> > @@ -66,10 +66,8 @@ SECTIONS
> >  		ARM_EXIT_DISCARD(EXIT_TEXT)
> >  		ARM_EXIT_DISCARD(EXIT_DATA)
> >  		EXIT_CALL
> > -#ifndef CONFIG_HOTPLUG
> >  		*(.ARM.exidx.devexit.text)
> >  		*(.ARM.extab.devexit.text)
> > -#endif
> 
> This to me looks wrong.  Do we want to unconditionally discard devexit
> debugging?
> 

Whoa, yeah, that's not right.  I got it backwards.

The right fix gets rid of all those devexit lines as devexit will be
going away.

Should I just redo this patch or send an additional one that removes
those 2 lines?


> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index d1ea7ce..856b58d 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -74,13 +74,8 @@
> >   * are handled as text/data or they can be discarded (which
> >   * often happens at runtime)
> >   */
> > -#ifdef CONFIG_HOTPLUG
> >  #define DEV_KEEP(sec)    *(.dev##sec)
> >  #define DEV_DISCARD(sec)
> 
> I hope there will be a follow-on patch to remove the DEV_KEEP() and
> DEV_DISCARD() stuff entirely?
> 

Yes, once hotplug is truly gone these can also go away.

-- 
Bill
