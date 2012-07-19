From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] Make most arch asm/module.h files use
 asm-generic/module.h
Date: Thu, 19 Jul 2012 15:23:21 +0900
Message-ID: <20120719062320.GA21565@linux-sh.org>
References: <32350.1342615619@warthog.procyon.org.uk>
 <2597.1342617840@warthog.procyon.org.uk>
 <874np4cymj.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:53361 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415Ab2GSGXh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jul 2012 02:23:37 -0400
Content-Disposition: inline
In-Reply-To: <874np4cymj.fsf@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>

On Thu, Jul 19, 2012 at 11:15:24AM +0930, Rusty Russell wrote:
> On Wed, 18 Jul 2012 14:24:00 +0100, David Howells <dhowells@redhat.com> wrote:
> > diff --git a/arch/sh/include/asm/module.h b/arch/sh/include/asm/module.h
> > index b7927de..81300d8b 100644
> > --- a/arch/sh/include/asm/module.h
> > +++ b/arch/sh/include/asm/module.h
> > @@ -1,21 +1,13 @@
> >  #ifndef _ASM_SH_MODULE_H
> >  #define _ASM_SH_MODULE_H
> >  
> > -struct mod_arch_specific {
> > +#include <asm-generic/module.h>
> > +
> >  #ifdef CONFIG_DWARF_UNWINDER
> > +struct mod_arch_specific {
> >  	struct list_head fde_list;
> >  	struct list_head cie_list;
> > -#endif
> >  };
> 
> Hmm, this means we get two definitions if CONFIG_DWARF_UNWINDER?
> 
> Seems like a useful effort.  Fiddly though.
> 
The DWARF_UNWINDER check is already done in the Kconfig part of this
patch, so the ifdef here simply seems like a remnant that should have
been deleted (as the endif was) -- similar to the ARM unwinder case.
