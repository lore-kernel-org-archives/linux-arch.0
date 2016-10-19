From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] kbuild: modversions for exported asm symbols
Date: Wed, 19 Oct 2016 16:59:42 +0200
Message-ID: <7315031.MmlhY1rulM@wuerfel>
References: <20161015124352.10795-1-npiggin@gmail.com> <20161015124352.10795-3-npiggin@gmail.com> <24ebaba8-d20c-bc2e-8430-599cab2dbb33@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:61429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943460AbcJSO7w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2016 10:59:52 -0400
In-Reply-To: <24ebaba8-d20c-bc2e-8430-599cab2dbb33@suse.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Wednesday, October 19, 2016 4:50:26 PM CEST Michal Marek wrote:
> Dne 15.10.2016 v 14:43 Nicholas Piggin napsal(a):
> > +# .S file exports must have their C prototypes defined in asm/asm-prototypes.h
> > +# or a file that it includes, in order to get versioned symbols. We build a
> > +# dummy C file that includes asm-prototypes and the EXPORT_SYMBOL lines from
> > +# the .S file (with trailing ';'), and run genksyms on that, to extract vers.
> > +#
> > +# These mirror gensymtypes_c and co above, keep them in synch.
> > +cmd_gensymtypes_S =                                                         \
> > +    (echo "\#include <linux/kernel.h>" ;                                    \
> > +     echo "\#include <asm/asm-prototypes.h>" ;                              \
> > +     grep EXPORT_SYMBOL $< | sed 's/$$/;/' ) |                              \
> > +    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
> > +    $(GENKSYMS) $(if $(1), -T $(2))                                         \
> > +     $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
> > +     $(if $(KBUILD_PRESERVE),-p)                                            \
> > +     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
> 
> I think it would be cleaner to add the #include to the .S files
> themselves and grep for both EXPORT_SYMBOL and #include here. The reason
> is that some files might need additional #includes to allow genksyms to
> properly expand some function prototypes.
> 

This is something I tried earlier, and it wasn't pretty: Some of the assembler
files rely on -D__ASSEMBLER__  to be set in order to read the right headers,
but setting that macro means that all of the declarations get skipped.

I ended up testing for -D__GENKSYMS__ in each .S file, which was also
rather ugly.

	Arnd
