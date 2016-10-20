From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] kbuild: modversions for exported asm symbols
Date: Thu, 20 Oct 2016 14:58:27 +1100
Message-ID: <20161020145827.453025a6@roar.ozlabs.ibm.com>
References: <20161015124352.10795-1-npiggin@gmail.com>
        <20161015124352.10795-3-npiggin@gmail.com>
        <24ebaba8-d20c-bc2e-8430-599cab2dbb33@suse.com>
        <7315031.MmlhY1rulM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33509 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbcJTD6d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2016 23:58:33 -0400
In-Reply-To: <7315031.MmlhY1rulM@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Wed, 19 Oct 2016 16:59:42 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday, October 19, 2016 4:50:26 PM CEST Michal Marek wrote:
> > Dne 15.10.2016 v 14:43 Nicholas Piggin napsal(a):  
> > > +# .S file exports must have their C prototypes defined in asm/asm-prototypes.h
> > > +# or a file that it includes, in order to get versioned symbols. We build a
> > > +# dummy C file that includes asm-prototypes and the EXPORT_SYMBOL lines from
> > > +# the .S file (with trailing ';'), and run genksyms on that, to extract vers.
> > > +#
> > > +# These mirror gensymtypes_c and co above, keep them in synch.
> > > +cmd_gensymtypes_S =                                                         \
> > > +    (echo "\#include <linux/kernel.h>" ;                                    \
> > > +     echo "\#include <asm/asm-prototypes.h>" ;                              \
> > > +     grep EXPORT_SYMBOL $< | sed 's/$$/;/' ) |                              \
> > > +    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
> > > +    $(GENKSYMS) $(if $(1), -T $(2))                                         \
> > > +     $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
> > > +     $(if $(KBUILD_PRESERVE),-p)                                            \
> > > +     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))  
> > 
> > I think it would be cleaner to add the #include to the .S files
> > themselves and grep for both EXPORT_SYMBOL and #include here. The reason
> > is that some files might need additional #includes to allow genksyms to
> > properly expand some function prototypes.
> >   
> 
> This is something I tried earlier, and it wasn't pretty: Some of the assembler
> files rely on -D__ASSEMBLER__  to be set in order to read the right headers,
> but setting that macro means that all of the declarations get skipped.
> 
> I ended up testing for -D__GENKSYMS__ in each .S file, which was also
> rather ugly.

Yeah, I had the same idea as you and Michal too. It's conceptually nicer,
but in practice it turned into a mess. If some architectures wanted to start
protecting their .h files and including them into .S for the prototypes, we
could start parsing those too. Should we do the quick and dirty way for 4.9?

Thanks,
Nick
